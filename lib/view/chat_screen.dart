import 'dart:io';
import 'package:chatapp/const/extentions.dart';
import 'package:chatapp/const/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:intl/intl.dart';
import '../const/helper.dart';
import '../controllers/chat_controller.dart';
import '../models/message.dart';

class ChatScreen extends StatelessWidget {
  String? userName;
   String? userId;
   String? profilePic;
  late ChatController? chatController;
   ChatScreen(this.userName,this.userId,this.profilePic,{super.key}){
     chatController=Get.put(ChatController(userId: userId));
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            chatHeader(),
            _list(),
            // selectedImage(),
            chatTextView(),
          ],
        ),
      ),
    );
  }

  Widget chatHeader() {
    String name=Helper.getFirstValue(userName.nullSafe);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      decoration: BoxDecoration(
        color: ThemeColors.primaryColor,
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
           InkWell(
             onTap: () => Get.back(),
               child: const Icon(Icons.arrow_back,color:Colors.white)),
          const SizedBox(width: 10,),
            CircleAvatar(
             child: Text(name.nullSafe,style: const TextStyle(color: Colors.white)),
             // backgroundImage: NetworkImage(Const.config.value.profileImagePath.nullSafe+profilePic.nullSafe)
          ),
          const SizedBox(width:10,),
           Text(userName.nullSafe,style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600
          ),),
          const Expanded(child: SizedBox()),
        ],

      ),
    );
  }

  Widget chatTextView() {
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      padding: const EdgeInsets.only(left: 10,right: 5),
      child: Column(
        children: [
          Row(
            children: [
              // InkWell(
                // onTap:()=> chatController?.pickImageFromGallery(),
                //   child: Image.asset("assets/images/atacher.png",width: 18,color: Color(0xFF535353),)),
              SizedBox(height: 15,),
               Expanded(
                child: TextField(
                  controller: chatController?.chatTextController,
                  decoration:  InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "Type your message".tr,
                    hintStyle: const TextStyle(
                      color: Color(0xFF727272),
                      fontSize: 13
                    ),
                    contentPadding: EdgeInsets.zero
                  ),
                ),
              ),
              InkWell(
                onTap: chatController?.sendMessage,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(8),
                  decoration:  BoxDecoration(
                   color:ThemeColors.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(5))
                  ),
                child:  Image.asset("assets/images/send.png",width: 20,color:Colors.white,),
                ),
              )

            ],
          ),
        ],
      ),
    );
  }

  Widget _list() {
    return Expanded(
     child: Obx(() {

       return Container(
         padding: EdgeInsets.symmetric(horizontal: 20),
         child: ListView.builder(
            physics: BouncingScrollPhysics(),
             shrinkWrap: true,
             reverse: true,
             itemCount:chatController?.messageList.length,
             itemBuilder:(contex,index)=> listItems(contex,index)
         ),
       );
     },
     ),
      );
  }

  Widget listItems(BuildContext context,int index) {
     Message data=chatController!.messageList[index];
        return  Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: data.senderId.toString()==chatController?.uid?CrossAxisAlignment.end:CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
           SizedBox(height: 5,),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                // child: MyNetworkImage(path: Const.config.value.filePath.nullSafe+data.media.nullSafe,width: 40.w,open: true),
              ),
            // Image.asset("assets/images/Screenshot4.png",width: 100),
             Container(
               constraints: BoxConstraints( maxWidth:250 ),
               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
               decoration:  BoxDecoration(
                 color: data.senderId.toString()==chatController?.uid?Color(0xFFE4EAF3):Color(0xFFF2F2F2),
                 borderRadius: BorderRadius.all(Radius.circular(15)),
               ),
               child: Text(data.message.nullSafe,textAlign: TextAlign.center,),
             ),
             const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              // child: Text("messageTime",style: TextStyle(color: Color(0xFF727272,),fontSize:12),),
            ),
            SizedBox(height: 20,)
          ],
        );
  }


  Widget selectedImage(){
    return Obx(()=>
        chatController?.isFileEmpty.value.path!=''?Container(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(5)
        ),
        child:Row(
          mainAxisSize: MainAxisSize.max,
          children: [
                Image.file(File(chatController!.file!.path),width: 40,height: 40,),
            SizedBox(height: 5,),
             Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Selected",style: TextStyle(
                  ),),
                  Text(chatController!.isFileEmpty.value.path),
                ],
              ),
            ),
            InkWell(
              // onTap: chatController?.cancelSelectedImage,
                child: const Icon(Icons.cancel))
          ],
        )
      ):SizedBox(),
    );
  }

}
