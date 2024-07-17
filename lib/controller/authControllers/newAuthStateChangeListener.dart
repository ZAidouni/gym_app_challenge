import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:work_out/view/screens/auth/EmailVerification.dart';
import 'package:work_out/view/screens/auth/EmailCoachVerif.dart';
import 'package:work_out/view/screens/homepage/homepagecoach.dart';

import 'package:work_out/view/screens/welcome/welcome_page.dart';

import '../../view/screens/homepage/homePage.dart';


class NewAuthStateChangeListener extends GetxController {
  // Instance of the FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // An observable that can bu null
  Rxn<User?> user = Rxn<User?>(null);

  // Auth state handler
  handleTheUserState(User? user) async {
    DocumentReference userDocRef = FirebaseFirestore.instance.collection("aboutUsers").doc(user?.uid);

    // Obtenez le document utilisateur
    DocumentSnapshot userDoc = await userDocRef.get();
    if (user == null) {
      // print("no user / user is signed out");
      Get.offAll(() => WelcomePage());
    } else {
      if (!user.emailVerified && userDoc.get("siret") == "" ) {
        Get.offAll(() => EmailVerificatioPage());

      } if(!userDoc.get("verified") && userDoc.get("siret") != "" ) {
        Get.offAll(() => EmailCoachPage());

      }
      if(user.emailVerified && userDoc.get("siret") == "" ) {
        Get.offAll(() => HomePage());

      }
      if(userDoc.get("verified") && userDoc.get("siret") != "" ) {
        Get.offAll(() => HomePageCoach());

      }
    }
  }

  @override
  void onReady() {
    ever(user, handleTheUserState);

    user.bindStream(_auth.authStateChanges());
    super.onReady();
  }
}