
import 'package:flutter/material.dart';

import '../mytheme.dart';

class ErrorWidgett extends StatelessWidget {
  String errorMsg;
  Function onBtnPressed;
  ErrorWidgett({required this.errorMsg, required this.onBtnPressed});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(errorMsg,style: TextStyle(color: Colors.red),),
      Center(child: ElevatedButton(onPressed:onBtnPressed(),
        child: Text("Try Again!",style: TextStyle(fontSize: 18),),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
              side: BorderSide(color: MyTheme.primaryColor,width: 2),
            ), backgroundColor: MyTheme.primaryColor
        ),),)
    ],);
  }
}
