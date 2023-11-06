import 'dart:io';

import 'package:chatapp/const/extentions.dart';
import 'package:chatapp/const/helper.dart';
import 'package:chatapp/view/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/toasty.dart';
import '../models/chat.dart';
import '../models/user.dart';

class HomeController extends GetxController{
  TextEditingController emailController=TextEditingController();
  TextEditingController messageController=TextEditingController();
  RxList<UserModel> userList=<UserModel>[].obs;
  RxList<ChatModel> friendList=<ChatModel>[].obs;
  RxString status="NORMAL".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    chatSocket();
    // getChatData();
    uploadFile();
  }

  FirebaseStorage _storage = FirebaseStorage.instance;

   uploadFile() async {
    ImagePicker picker = ImagePicker();
    //Get the file from the image picker and store it
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

      File file=File(image!.path);

    Reference ref = _storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(file);
    uploadTask.then((res) {
       print(res.ref.getDownloadURL());
    });
  }

  void chatSocket()async {
    FirebaseFirestore.instance.collection('chat').snapshots().listen((event) {
      for(int i=0;i<1;i++){
             getData();
      }
    });
  }

  getData() async{
    status.value="PROGRESS";
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
    CollectionReference chatsCollection = FirebaseFirestore.instance.collection('chat');
    QuerySnapshot userSnapshot = await chatsCollection.orderBy("created_at",descending: true).where(Filter.or(Filter('sender_id', isEqualTo:uid), Filter('send_to',isEqualTo:uid ))).get();
    List<DocumentSnapshot> userDocuments = userSnapshot.docs;
    QuerySnapshot querySnapshot1 = await usersCollection.get();
    List<DocumentSnapshot> documents1 = querySnapshot1.docs;
    friendList.clear();
    Set<String> uniqueEmails = Set<String>();
    int i=0;
    for (var user in documents1) {
    for (var userDoc in userDocuments) {
        if (user['id']!=uid && (userDoc['send_to'] == user.id || userDoc['sender_id'] == user.id) ) {
          ChatModel list = ChatModel.fromJson(user.data());
          String email = user['email'];
          if(!uniqueEmails.contains(email)){
            uniqueEmails.add(email);
            list.message = userDoc['message'];
            list.sendTo = user['id'];
            friendList.add(list);
          }

        }}
    }
    status.value="NORMAL";
  }

  void addFriend() async{
    if(messageController.text.isEmpty || emailController.text.isEmpty){
      Toasty.normal("please fill all fields");
      return;
    }
    String friendToken='';
    int i=0;
     FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
      event.docs.forEach((element) {
         if(emailController.text==element.data()['email']){
           i++;
           friendToken=element.data()['id'];
           add(friendToken);
         }

      });
      if(i==0){
        Toasty.normal("User does not exists");
      }
    });


    // try {
    //   UserCredential userCredential= await FirebaseAuth.instance
    //       .createUserWithEmailAndPassword(email: emailController.text,password: '123456');
    //   Toasty.success("user does not exists");
    // } catch (signUpError) {
    //   UserCredential userCredential= await FirebaseAuth.instance
    //       .createUserWithEmailAndPassword(email: emailController.text,password: '123456');
    //   final FirebaseAuth auth = FirebaseAuth.instance;
    //   await FirebaseFirestore.instance.collection('chat').doc(auth.currentUser?.uid).set({
    //     'message': messageController.text,
    //     'created_at': emailController.text,
    //     'msg_img':"",
    //     "read_status":"",
    //     "send_to":userCredential.user?.uid,
    //     "sender_id":auth.currentUser?.uid,
    //     "updated_at":"",
    //   });
    // }
  }
  add(String friendToken) async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    await FirebaseFirestore.instance.collection('chat').doc(DateTime.now().millisecond.toString()).set({
      'message': messageController.text,
      'created_at': DateTime.now().toUtc(),
      'msg_img':"",
      "read_status":"",
      "send_to":friendToken,
      "id":DateTime.now().microsecond.toString(),
      "sender_id":auth.currentUser?.uid,
      "updated_at":DateTime.now().toUtc(),
    });
  }




  void logOut() async{
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("islogin");
    Get.to(()=>LoginScreen());
  }

  Future<String> getUserData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Toasty.normal(prefs.getString("name").nullSafe);
    return Helper.getFirstValue(prefs.getString("name").nullSafe);
  }
}