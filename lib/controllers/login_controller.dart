import 'package:chatapp/const/toasty.dart';
import 'package:chatapp/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/signup.dart';

class LoginController extends GetxController{
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  RxString status="NORMAL".obs;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> resetPassword() async {
    if(emailController.text.isEmpty){
      Toasty.normal("Please enter email");
    }
    final auth = FirebaseAuth.instance;
    await auth
        .sendPasswordResetEmail(email: emailController.text)
        .then((value) => Toasty.normal("Please check your email"))
        .catchError(
            (e) => e);
    return;
  }

  Future<User> login() async {
    status.value="PROGRESS";
    UserCredential result =
    await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value) async{
      Toasty.success("You have login successfully");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
           prefs.setBool("islogin", true);
           prefs.setString("name",emailController.text);
      Get.to(()=> HomeScreen());
      status.value="NORMAL";
      return value;
    }).catchError((e){
      Toasty.success("Email or Password incorrect");
      status.value="NORMAL";
      return e;
    });
    status.value="NORMAL";
    final User user = result.user!;
    return user;
  }
}