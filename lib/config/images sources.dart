// local Assets Imgs
import 'dart:math';

class ImgSrc {
  ImgSrc();

  List<String> imgList = <String>[
    ImgSrc.welcome,
    ImgSrc.getStarted,
    ImgSrc.login,
    ImgSrc.homepageOverlay,
  ];

  static String welcome = 'assets/img/welcomeOverlayImg.png';
  static String getStarted = 'assets/img/GetStartedOverlay.png';
  static String login = 'assets/img/loginOverlayImg.png';
  static String primaryLaungage = "assets/img/en.png";
  static String secondaryLaungage = "assets/img/fr.png";
  static String imgVerification = "assets/img/email_verif.png";
  static String homepageOverlay = 'assets/img/welcomePageOverlay.png';


  String randomFromAssetsList() {
    return imgList[Random().nextInt(imgList.length)];
  }
}
