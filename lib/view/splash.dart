import 'package:chatapp/view/home.dart';
import 'package:chatapp/view/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('islogin')==true){
      Get.to(()=>HomeScreen());
    }
    else{
      Get.to(()=>LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
