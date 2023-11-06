import 'package:chatapp/const/theme.dart';
import 'package:chatapp/view/home.dart';
import 'package:chatapp/view/signup.dart';
import 'package:chatapp/view/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
    statusBarColor: ThemeColors.primaryColor, // status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ThemeColors.primaryColor),
        useMaterial3: true,
      ),
      home:  const SplashScreen(),
      // home:  HomeScreen(),
    );
  }
}



