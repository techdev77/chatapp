import 'package:chatapp/controllers/login_controller.dart';
import 'package:chatapp/view/signup.dart';
import 'package:chatapp/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/signup_bottom_btn.dart';
import '../widgets/form.dart';
class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
final LoginController _loginController=Get.put(LoginController(),tag:"loginController");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children:  [
                const Center(child: Text("Welcome back!",style: TextStyle(fontSize: 22),)),
                const SizedBox(height:20),
                const Text("Email"),
                MyForm(textHint: "Enter email",textEditingController: _loginController.emailController),
                const Text("password"),
                MyForm(textHint: "min. 6 characters",textEditingController: _loginController.passwordController),
                const SizedBox(height: 5),
                Align(alignment: Alignment.topRight,child: InkWell(onTap:_loginController.resetPassword,child: Text("Forgot Password?",style: TextStyle(color: Color(0xFF00B294)),))),
                const SizedBox(height:20),
                Obx(()=>_loginController.status.value=="PROGRESS"?loader():
                   SignupBottomBtn(text: 'Log in',callback: (){
                    _loginController.login();
                  }),
                ),
                const SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                        style:TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(50, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft),
                        onPressed: (){
                          Get.to(()=> SignupScreen());
                        },
                        child: const Text("Sign Up",style: TextStyle(color:Color(0xFF00B294)),)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
