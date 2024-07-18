import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/functionsController.dart';
import '../../../controller/userProfileOptions/userProfileOptionsController.dart';
import '../../../controller/userController/userController.dart'; // Importer le contrôleur
import '../../../helpers/string_methods.dart';
import 'package:work_out/checkout/subscription_redirect_page.dart';
import '../../../../controller/authControllers/signOutController.dart';
import 'package:work_out/config/text.dart';
import 'package:work_out/config/Colors.dart';
import 'package:work_out/view/screens/homepage/homepagecoach.dart';

class CustomCoachProfileSettings extends StatelessWidget {
  CustomCoachProfileSettings({Key? key}) : super(key: key);

  final FunctionsController controller = Get.find();
  final UserProfileOptionsController userProfileOptionsController = Get.put(UserProfileOptionsController());
  final UserInformationController userInformationController = Get.find(); // Obtenez l'instance du contrôleur

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Get.offAll(() => HomePageCoach());
      },
    ),
      title: Text(
        capitalize(AppTexts.profile),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
      toolbarHeight: 80,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        GetBuilder<SignOutController>(
            init: SignOutController(),
            builder: (signOutController) {
              return ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBlue, elevation: 0),
                label: Text(
                  capitalize(AppTexts.logOut),
                  style: const TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  signOutController.signOut();
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
              );
            }),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
      ),
      backgroundColor: Get.arguments[0],
      body: FutureBuilder<bool>(
        future: userInformationController.IsCoach(), // Appeler la méthode IsCoach
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Afficher un indicateur de chargement pendant que nous attendons le résultat
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Afficher une erreur si quelque chose se passe mal
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            bool isCoach = snapshot.data!;
            // Filtrer les options basées sur le statut de coach
            var filteredOptions = userProfileOptionsController.userProfileOptionsList.where((option) {
              return !(isCoach &&
                  (option["optionTitle"] == "subscription" || option["optionTitle"] == "Mes séances"));
            }).toList();
            
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    filteredOptions.length,
                    (i) => DelayedDisplay(
                      delay: Duration(milliseconds: delay + 100 * i),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Get.arguments[1],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: InkWell(
                          onTap: () {
                            if (filteredOptions[i]["optionTitle"] == "subscription") {
                              try {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SubscriptionRedirectPage()),
                                );
                              } catch (e, stacktrace) {
                                print('Erreur: $e');
                                print('Stacktrace: $stacktrace');
                              }
                            } else {
                              filteredOptions[i]["optionFunction"]();
                            }
                          },
                          child: ListTile(
                            title: Text(
                              capitalize(filteredOptions[i]["optionTitle"]),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: i == filteredOptions.length - 1
                                    ? Colors.red
                                    : Theme.of(context).primaryColor,
                                fontSize: 20,
                              ),
                            ),
                            leading: Icon(
                              filteredOptions[i]["optionIcon"],
                              color: i == filteredOptions.length - 1
                                  ? Colors.red
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('Aucune donnée disponible'));
          }
        },
      ),
    );
  }
}
