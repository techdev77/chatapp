import 'package:chatapp/const/extentions.dart';
import 'package:chatapp/const/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFriendDialog {
 TextEditingController? emailController;
 TextEditingController? messageController;
  void Function() onClick;

  AddFriendDialog({this.emailController, required this.onClick, this.messageController}) {
    _show();
  }

  void _show() {
    Get.dialog(
      Dialog(
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Center(child: Text("Add Friend",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16),)),
               Container(
                 margin: EdgeInsets.only(top: 10,bottom: 5),
                 padding: EdgeInsets.all(8),
                 decoration: BoxDecoration(
                   border: Border.all(color: Colors.black12),
                   borderRadius: BorderRadius.circular(10)
                 ),
                 child:  TextField(
                   controller: emailController,
                   decoration: const InputDecoration(
                     contentPadding: EdgeInsets.zero,
                     border: InputBorder.none,
                     isDense: true,
                     hintText: "Enter email",
                     hintStyle: TextStyle(fontSize: 13)
                   ),
                 ),
               ),
              Container(
                margin: EdgeInsets.only(bottom: 5,top: 5),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(10)
                ),
                child:  TextField(
                  controller: messageController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      isDense: true,
                      hintText: "Enter message",
                      hintStyle: TextStyle(fontSize: 13)
                  ),
                ),
              ),
              TextButton(
                  onPressed: (){
                    onClick();
                    Get.back();
                  },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(ThemeColors.primaryColor),
                ),
                  child:  const Text("Add",style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
      // barrierDismissible: false,
    );
  }
}