import 'package:chatapp/const/theme.dart';
import 'package:flutter/material.dart';

Widget cardLoader(){
  return  Center(
    child:  Container(
      width: 50,
      height: 50,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow:  [
            BoxShadow(color: ThemeColors.primaryColor,
              blurRadius: 5.0,)
          ]
      ),
      child:Center(child: CircularProgressIndicator(strokeWidth: 3,)),
    ),
  );
}