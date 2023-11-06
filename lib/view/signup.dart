import 'package:chatapp/controllers/signup_controller.dart';
import 'package:chatapp/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../utils/is_login.dart';
import '../widgets/signup_bottom_btn.dart';
import '../widgets/form.dart';
import 'login.dart';
class SignupScreen extends StatefulWidget {
   SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // IsLogin isLogin=IsLogin();
  @override
  void initState() {
    // isLogin.isLogin();
    super.initState();
    // if(FirebaseAuth.instance.currentUser?.uid == null){
    //     Get.to(()=>LoginScreen());
    // } else {
    //     Get.to(()=>HomeScreen());
    //
    // }
  }
final SignupController _signupController=Get.put(SignupController(),tag: "signupController");

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
                      const Center(child: Text("Create a new account",style: TextStyle(fontSize: 22),)),
                      const SizedBox(height:20),
                      const Text("Full Name"),
                      MyForm(textHint: "Enter your name",textEditingController: _signupController.nameController),
                      const Text("Email"),
                      MyForm(textHint: "Enter email",textEditingController: _signupController.emailController),
                      const Text("password"),
                      MyForm(textHint: "min. 6 characters",textEditingController: _signupController.passwordController),
                      const SizedBox(height:20),
                      Obx(()=> _signupController.status.value=="PROGRESS"?loader():
                          SignupBottomBtn(text: 'Sign Up',callback:(){
                          _signupController.registerUser();
                        }),
                      ),
                       const SizedBox(height: 50,),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text("Already have an account? "),
                          TextButton(
                            style:TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(50, 30),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                alignment: Alignment.centerLeft),
                            onPressed: (){
                              Get.to(()=>LoginScreen());
                            },
                            child: const Text("Log in",style: TextStyle(color:Color(0xFF00B294)),)),
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
