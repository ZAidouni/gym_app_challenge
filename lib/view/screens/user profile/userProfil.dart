import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/functionsController.dart';
import 'package:work_out/config/Colors.dart';
import 'package:work_out/config/text.dart';
import 'package:work_out/view/widgets/general_widgets/button.dart';
import '../../../controller/authControllers/signOutController.dart';
import '../../../controller/userController/userController.dart';
import '../../../config/UserProfile/userProfil.dart';
import '../../../helpers/string_methods.dart';
import 'components/appBar.dart';
import 'components/stat.dart';
import 'customizeProfilePage.dart';
import 'package:work_out/services/openai_service.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final FunctionsController controller = Get.put(FunctionsController());
  final UserInformationController userInformationController = Get.find();
  final SignOutController signOutController = Get.put(SignOutController());
  Color? scfldColor = AppColors.darkBlue;
  Color? overlayedColor = const Color.fromARGB(255, 22, 23, 43);
  String description = "Loading..."; // Variable pour stocker la description

  @override
  void initState() {
    super.initState();
    _generateDescription();
  }

  Future<void> _generateDescription() async {
    final achievements = int.parse(UserProfileStats.stats[0]["value"]);
    final badges = int.parse(UserProfileStats.stats[1]["value"]);
    final workouts = int.parse(UserProfileStats.stats[2]["value"]);
    final openAIService = OpenAIService();
    final prompt = 'Génère moi une description avec de la motivation en max 50 mots pour mon niveau de progression en se basant sur le nombre achievements ($achievements), badges ($badges), workouts ($workouts) que j\'ai effectués.';
    
    print('Generating description with prompt: $prompt'); // Debug print

    try {
      final generatedDescription = await openAIService.generateDescription(prompt);
      setState(() {
        description = generatedDescription;
      });
    } catch (e) {
      setState(() {
        description = "Failed to load description.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scfldColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: DelayedDisplay(
          delay: Duration(milliseconds: delay),
          child: ProfileAppBar(),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            Column(
              children: [
                DelayedDisplay(
                  delay: Duration(milliseconds: delay + 100),
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Obx(
                        (() => Image(
                              image: NetworkImage(userInformationController.userProfileImg.value),
                              fit: BoxFit.cover,
                              frameBuilder: (_, image, loadingBuilder, __) {
                                if (loadingBuilder == null) {
                                  return const SizedBox(
                                    height: 300,
                                    child: Center(
                                      child: SpinKitSpinningLines(
                                        color: Color(0xff40D876),
                                        duration: Duration(seconds: 1),
                                        size: 60,
                                      ),
                                    ),
                                  );
                                }
                                return image;
                              },
                            )),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: delay + 400),
                  child: Obx(
                    () => DelayedDisplay(
                      child: Text(
                        capitalize(
                          userInformationController.username.value,
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: delay + 300),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      description, // Utilisation de la description générée
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(.8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: delay + 400),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...List.generate(
                        UserProfileStats.stats.length,
                        (i) => Stat(
                          statValue: capitalize(UserProfileStats.stats[i]["value"]),
                          statTitle: capitalize(UserProfileStats.stats[i]["title"]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
            DelayedDisplay(
              delay: Duration(milliseconds: delay + 500),
              child: CustomButton(
                text: capitalize(AppTexts.configureSettings),
                isOutlined: true,
                onPressed: () {
                  Get.to(() => CustomProfileSettings(), arguments: [scfldColor, overlayedColor]);
                },
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
