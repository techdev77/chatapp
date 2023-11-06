import 'dart:convert';
import 'dart:io';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../const/toasty.dart';
import '../models/message.dart';

class ChatController extends GetxController{
  String? userId;
  RxList<Message> messageList=<Message>[].obs;
  ChatController({ this.userId}){
    getChatData();

  }
  //p1mFS7SB2vbtKxCBugrCSKOW00E2
  // p1mFS7SB2vbtKxCBugrCSKOW00E2
  String uid='';
  void getChatData(){
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
   uid= user!.uid;
    FirebaseFirestore.instance
        .collection('chat').orderBy("created_at",descending: true)
           // where(Filter.or(Filter("send_to",isEqualTo: userId), Filter("send_to",isEqualTo: uid)))
          // .where(Filter.or(Filter("sender_id", isEqualTo: uid),Filter("sender_id", isEqualTo: userId)))
        .snapshots()
        .listen((data) {
           messageList.clear();
          data.docs.forEach((element){
            if((element["send_to"]==userId || element["send_to"]==uid) && (element["sender_id"]==userId || element["sender_id"]==uid)){
             Message message=Message.fromJson(element.data());
             messageList.add(message);
            }
        });
        });
  }

  // void getChatData(){
  //   print(userId);
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final User? user = auth.currentUser;
  //   uid= user!.uid;
  //   FirebaseFirestore.instance
  //       .collection('chat').
  //   where(Filter.or(Filter("send_to",isEqualTo: userId), Filter("send_to",isEqualTo: uid)))  // Replace 'uid' with the user's ID
  //       .get()
  //       .then((querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       // Process messages sent by the user
  //       Message message = Message.fromJson(doc.data());
  //       messageList.add(message);
  //     });
  //   });
  //
  //   FirebaseFirestore.instance
  //       .collection('chat')
  //       .where(Filter.or(Filter("sender_id", isEqualTo: uid),Filter("sender_id", isEqualTo: userId))) // Replace 'uid' with the user's ID
  //       .get()
  //       .then((querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       // Process messages sent to the user
  //       Message message = Message.fromJson(doc.data());
  //       messageList.add(message);
  //     });
  //   });
  //
  // }
  // where("sender_id", isEqualTo: uid).where("send_to",isEqualTo: userId)

  RxString status = "".obs;
  TextEditingController  chatTextController=TextEditingController();
  // RxList<ChatModel> chatList = <ChatModel>[].obs;
RxInt chatTextSize=0.obs;
RxBool emojiShowing = false.obs;
File? file;
Rx<File> isFileEmpty=File('').obs;
// final ImagePicker _picker = ImagePicker();

@override
  void onInit() {
    super.onInit();

  }
//   void changechatSize() {
//     chatTextSize.value++;
//     chatTextController.clear();
//   }
//    onBackspacePressed() {
//      chatTextController
//          ..text = chatTextController.text.characters.toString()
//     ..selection = TextSelection.fromPosition(
//         TextPosition(offset: chatTextController.text.length));
// }

  void getChatgetChat() {

  }

//
// Future<void> pickImageFromGallery() async {
//   bool permission = await Helper.requestPermission(Permission.storage);
//   if (permission) {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       file = File(pickedFile.path);
//       isFileEmpty.value = file!;
//     } else {
//       // User canceled the picker
//       Toasty.success('image not selected'.tr);
//     }
//   }
// }

  // Future<void> pickImageFromCamera() async {
  //   bool permission = await Helper.requestPermission(Permission.storage);
  //   if (permission) {
  //     final pickedFile = await _picker.pickImage(source: ImageSource.camera);
  //     if (pickedFile != null) {
  //       file = File(pickedFile.path);
  //       isFileEmpty.value = file!;
  //     } else {
  //       // User canceled the picker
  //       Toasty.success('image not selected'.tr);
  //     }
  //   }
  // }

  sendMessage() async{
  String message=chatTextController.text;
  chatTextController.clear();
    final FirebaseAuth auth = FirebaseAuth.instance;
    await FirebaseFirestore.instance.collection('chat').doc(DateTime.now().millisecond.toString()).set({
      'message': message,
      'created_at': DateTime.now().toUtc(),
      'msg_img':"",
      "read_status":"",
      "send_to":userId,
      "id":DateTime.now().microsecond.toString(),
      "sender_id":auth.currentUser?.uid,
      "updated_at":DateTime.now().toUtc(),
    });
  }
}