import 'dart:async';
import 'package:chatapp/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/login.dart';
class IsLogin{

   void isLogin(){
    final auth=FirebaseAuth.instance;
    final user=auth.currentUser;
    if(user!=null){
    // Timer(const Duration(seconds: 3),(){
      Get.to(()=>HomeScreen());
      // Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomeScreen(),));
    // });
    }
    else{
      Timer(const Duration(seconds: 3),(){
        Get.to(()=>LoginScreen());
        // Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginScreen(),));
      });
    }
  }
}