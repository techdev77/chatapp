import 'package:chatapp/const/extentions.dart';
import 'package:chatapp/const/helper.dart';
import 'package:chatapp/controllers/home_controller.dart';
import 'package:chatapp/models/chat.dart';
import 'package:chatapp/view/chat_screen.dart';
import 'package:chatapp/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../const/theme.dart';
import '../dialogs/add_friends_dialog.dart';


class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
final HomeController _homeController=Get.put(HomeController(),tag: "homeController");
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Obx(()=>_homeController.status.value=="PROGRESS"?cardLoader():
           Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
                children: [
                  profile(),
                  chatBuilder(),
                ],
            ),
          ),
        ),
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: (){
          AddFriendDialog(emailController: _homeController.emailController,messageController:_homeController.messageController,onClick: (){
            _homeController.addFriend();
          });
        },
        mini: true,
        backgroundColor: ThemeColors.primaryColor,
        child: const Icon(Icons.add,color: Colors.white),
      ),
    );
  }

  Widget chatBuilder() {
    return Expanded(
      child: Obx(()=>
          ListView.builder(
            physics: const BouncingScrollPhysics(),
             itemCount:_homeController.friendList.length ,
            shrinkWrap: true,
            itemBuilder:(_,index)=> chatList(_,index,(){
              ChatModel data=_homeController.friendList[index];
              Get.to(()=>ChatScreen(data.name.nullSafe, data.sendTo, ''));
            })
        ),
      ),
    );
  }

  Widget? chatList(BuildContext context, int index,Function() callback) {
     ChatModel data=_homeController.friendList[index];
     String name=Helper.getFirstValue(data.name.nullSafe);

     // Timestamp stamp = Timestamp.now();
     // DateTime date = stamp.toDate();
     // print(date);
     // DateTime time=DateTime.parse(DateTime.fromMicrosecondsSinceEpoch(int.parse(data.createdAt.nullSafe)).toString());
     // Print(Timestamp.fromMicrosecondsSinceEpoch(data.createdAt.nullSafe))
     // DateTime dateTime = firestoreTimestamp.toDate();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextButton(
        onPressed: callback,
        child: Row(
          children: [
            CircleAvatar(
             radius: 20,
              backgroundColor: ThemeColors.primaryColor,
              child: Text(name.nullSafe,style: const TextStyle(color: Colors.white,fontSize: 20)),
            ),
            const SizedBox(width: 15,),
            Expanded(
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.name.nullSafe,style: TextStyle(color: Color(0xFF3C3C3C),fontSize: 16),),
                    Text(data.message.nullSafe,maxLines: 1,style: const TextStyle(color: Color(0xFFC6C8CE),
                    overflow: TextOverflow.ellipsis),)
                  ],
                ),
              ),
            ),
          // Text(time.toLocal().toString(),style: TextStyle(color: Color(0xFFC6C8CE),fontSize: 12),)
          ],
        ),
      ),
    );

  }

  Widget profile() {
      Future<String> name=_homeController.getUserData();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      decoration: BoxDecoration(
        color: ThemeColors.primaryColor,
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
              // child: Text(name.toString().nullSafe)
          ),
          InkWell(
            onTap: _homeController.logOut,
              child: Icon(Icons.exit_to_app,color: Colors.white,))
        ],
      ),
    );
  }
}
