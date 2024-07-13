import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:work_out/checkout/server_stub.dart';
import 'package:work_out/constants.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

void redirectToCheckout(BuildContext context) async {
  final sessionId = await Server().createCheckout();
  Navigator.of(context).push(MaterialPageRoute(
    builder: (_) => CheckoutPage(sessionId: sessionId),
  ));
}

class CheckoutPage extends StatefulWidget {
  final String sessionId;

  const CheckoutPage({Key? key, required this.sessionId}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri.uri(Uri.parse(initialUrl)),
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
          ),
        ),
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        onLoadStop: (controller, url) {
          if (url.toString() == initialUrl) {
            _redirectToStripe(widget.sessionId);
          }
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          var uri = navigationAction.request.url!;
          if (uri.toString().startsWith('http://localhost:8080/#/success')) {
            _handlePaymentSuccess();
            return NavigationActionPolicy.CANCEL;
          } else if (uri.toString().startsWith('http://localhost:8080/#/cancel')) {
            Get.offNamed('/cancel');
            return NavigationActionPolicy.CANCEL;
          }
          return NavigationActionPolicy.ALLOW;
        },
      ),
    );
  }

  String get initialUrl => 'https://marcinusx.github.io/test1/index.html';

  Future<void> _redirectToStripe(String sessionId) async {
    final redirectToCheckoutJs = '''
var stripe = Stripe('$apiKey');
stripe.redirectToCheckout({
  sessionId: '$sessionId'
}).then(function (result) {
  result.error.message = 'Error'
});
''';

    try {
      await _webViewController.evaluateJavascript(source: redirectToCheckoutJs);
    } on PlatformException catch (e) {
      if (!e.details.contains(
          'JavaScript execution returned a result of an unsupported type')) {
        rethrow;
      }
    }
  }

  void _handlePaymentSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Payment Success'),
        content: Text('Payment was successful!'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              Get.offAllNamed('/home');
            },
          ),
        ],
      ),
    );
  }
}
