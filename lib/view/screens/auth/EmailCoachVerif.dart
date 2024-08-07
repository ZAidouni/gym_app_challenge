import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/authControllers/signOutController.dart';
import 'package:work_out/controller/functionsController.dart';
import 'package:work_out/config/images%20sources.dart';
import 'package:work_out/config/text.dart';
import 'package:work_out/config/text_fr.dart';
import 'package:work_out/view/widgets/general_widgets/button.dart';

import '../../../controller/authControllers/emailVerficationController.dart';
import '../../../helpers/string_methods.dart';

class EmailCoachPage extends StatelessWidget {
  EmailCoachPage({Key? key}) : super(key: key);
  //depend. injection
  final FunctionsController controller = Get.put(FunctionsController());
  final EmailVerificatioController emailVerificatioController =
  Get.put(EmailVerificatioController());
  final SignOutController signOutController = Get.put(SignOutController());

  // Add this to manage the selected language
  final RxString selectedLanguage = 'en'.obs;

  // Helper method to get the text based on the selected language
  String getText(String key) {
    if (selectedLanguage.value == 'fr') {
      return AppTextsFr.getText(key);
    } else {
      return AppTexts.getText(key);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff131429),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 22, 23, 43),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(30),
                width: double.infinity,
                child: SizedBox(
                  width: 300,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 90,
                        child: Image.asset(ImgSrc.imgVerification),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Obx(() => Text(
                        getText('coachVerif'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Obx(() => CustomButton(
                  text: capitalize(getText('done')),
                  isOutlined: false,
                  onPressed: () {
                    signOutController.signOut();
                  })),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
