import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/authControllers/sign_up_controller/extensions/text_editing_controller_lifecycle.dart';
import '../../functionsController/dialogsAndLoadingController.dart';

class SignUpController extends GetxController {
  final DialogsAndLoadingController dialogsAndLoadingController = Get.find();
  FieldValue thisMomentTime = FieldValue.serverTimestamp();

  // Input controllers
  late TextEditingController signUpUserController;
  late TextEditingController signUpEmailController;
  late TextEditingController signUpSiretController;
  late TextEditingController signUpPasswordController;

  @override
  void onInit() {
    super.onInit();
    initializeTextEditingControllers();
  }

  @override
  void onClose() {
    disposeTextEditingControllers();
    super.onClose();
  }

  void initializeTextEditingControllers() {
    signUpUserController = TextEditingController();
    signUpEmailController = TextEditingController();
    signUpSiretController = TextEditingController();
    signUpPasswordController = TextEditingController();
  }

  void disposeTextEditingControllers() {
    signUpUserController.dispose();
    signUpEmailController.dispose();
    signUpSiretController.dispose();
    signUpPasswordController.dispose();
  }
}
