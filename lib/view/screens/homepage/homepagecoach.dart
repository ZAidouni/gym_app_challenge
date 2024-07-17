import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/config/Colors.dart';
import 'package:work_out/config/text.dart';
import 'package:work_out/config/workouts%20lists/workouts%20Lists.dart';
import 'package:work_out/view/screens/user%20profile/userProfil.dart';
import 'package:work_out/view/screens/coach/add_group_session_page.dart';
import 'package:work_out/view/screens/coach/my_sessions_page.dart';
import 'package:work_out/view/screens/user%20profile/customizeCoachProfilePage.dart';

import '../../../controller/functionsController.dart';
import '../../../controller/tabs controllers/workOutTabController.dart';
import '../../../controller/userController/userController.dart';
import '../../../config/images sources.dart';
import '../../../helpers/string_methods.dart';
import '../../widgets/general_widgets/screen_background_image.dart';
import 'componenets/ItemsSwitchTiles.dart';
import 'componenets/find_your_workout.dart';
import 'componenets/playButton.dart';
import 'componenets/tabBarViewSections.dart';
import 'componenets/usernameAndProfile.dart';

class HomePageCoach extends StatefulWidget {
  HomePageCoach({Key? key}) : super(key: key);

  final String bgImg = ImgSrc().randomFromAssetsList();

  @override
  State<HomePageCoach> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageCoach> {
  final FunctionsController controller = Get.put(FunctionsController());
  final UserInformationController userInformationController = Get.put(UserInformationController());
  final CustomTabBarController _tabx = Get.put(CustomTabBarController());
  Color? scfldColor = AppColors.darkBlue;
  Color? overlayedColor = const Color.fromARGB(255, 22, 23, 43);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundImage(backgroundImage: widget.bgImg),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                stops: const [0.45, 1],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColors.darkBlue,
                  AppColors.darkBlue.withOpacity(0.05),
                ],
              ),
            ),
            width: double.infinity,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 50),
                      Obx(
                        () => ProfileAndUsername(
                          onProfileImgTap: () {
                            Get.offAll(() => CustomCoachProfileSettings(), arguments: [scfldColor, overlayedColor]);
                          },
                          username: capitalize(userInformationController.username.value),
                          profileImg: userInformationController.userProfileImg.value,
                        ),
                      ),
                      const SizedBox(height: 55),
                      DelayedDisplay(
                        delay: Duration(milliseconds: delay + 100),
                        child: PlayButton(),
                      ),
                      const SizedBox(height: 55),
                      DelayedDisplay(
                        delay: Duration(milliseconds: delay + 200),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: capitalize('Let\'s '),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 25,
                                ),
                                children: [
                                  const TextSpan(text: " "),
                                  TextSpan(
                                    text: capitalize('forge a warrior spirit'),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.showFilterDialog(context);
                              },
                              child: const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 26,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      const SizedBox(height: 150),
                      DelayedDisplay(
                        delay: Duration(milliseconds: delay + 400),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.to(() => AddGroupSessionPage());
                            },
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.group, color: AppColors.darkBlue),
                                  SizedBox(width: 10),
                                  Text(
                                    "Ajouter une séance en groupe",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.darkBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      DelayedDisplay(
                        delay: Duration(milliseconds: delay + 500),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.to(() => CoachSessionsPage());
                            },
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.calendar_today, color: AppColors.darkBlue),
                                  SizedBox(width: 10),
                                  Text(
                                    "Voir mes séances",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.darkBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
