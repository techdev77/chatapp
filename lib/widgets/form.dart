import 'package:flutter/material.dart';

import '../controllers/signup_controller.dart';
class MyForm extends StatelessWidget {
  String textHint;
  TextEditingController textEditingController;
  MyForm({required this.textHint, required this.textEditingController,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(top: 5,bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black12)
      ),
      child:  TextField(
        controller: textEditingController,
        decoration: InputDecoration(
            isDense: true,
            hintText: textHint,
            hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero
        ),
      ),
    );
  }
}
