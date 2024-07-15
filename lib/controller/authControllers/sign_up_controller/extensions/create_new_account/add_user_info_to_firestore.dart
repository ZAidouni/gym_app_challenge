import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:work_out/controller/authControllers/sign_up_controller/sign_up_controller.dart';

extension AddExtraInfoExt on SignUpController {
  Future<void> addUserInformationToFirestore({
    required UserCredential credential,
    required String email,
    required String username,
    String? siret,
    required String profileImgPath,
    required String uid,
    required bool isEmailVerified,
    String? password,
  }) async {
    // Add by uid
    await FirebaseFirestore.instance.collection("aboutUsers").doc(uid).set({
      "email": email,
      "password": password ?? "",
      "username": username,
      "siret": siret ?? "",
      "profileImgPath": profileImgPath,
      "uid": credential.user!.uid,
      "verified": isEmailVerified,
      "createdAt": thisMomentTime,
    });
  }
}
