import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/toasty.dart';

class SignupController extends GetxController{
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  RxString status="NORMAL".obs;

  Future<void> registerUser() async {
    status.value="PROGRESS";
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
 String dff=userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'name': nameController.text,
        'email': emailController.text,
        'profile_pic':"",
        "created_at":DateTime.now().toUtc(),
        "updated_at":DateTime.now().toUtc(),
        "id":userCredential.user?.uid
      });
      status.value="NORMAL";
      Toasty.success("You have registered successfully");
    } catch (e) {
      Toasty.success(e.toString());
      debugPrint('USER SIGN UP : $e');
      status.value="NORMAL";
    }
  }

}