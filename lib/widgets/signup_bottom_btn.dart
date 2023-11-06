import 'package:flutter/material.dart';
class SignupBottomBtn extends StatelessWidget {
  String text;
  Function() callback;
   SignupBottomBtn({required this.text,required this.callback,super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
            padding: const EdgeInsets.all(10),
        decoration:  BoxDecoration(
          color: const Color(0xFF00B294),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Center(child: Text(text,style: const TextStyle(color: Color(0xFFC4E7E1),fontSize: 16))),
      ),
    );
  }
}
