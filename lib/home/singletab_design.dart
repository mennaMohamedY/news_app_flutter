
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/model/SourceResponse.dart';
import 'package:newsapp/mytheme.dart';

class CustomTab extends StatelessWidget {
  Sources source;
  bool isSelected;
  CustomTab({required this.source,required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 5),
      decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(25)),
       border: Border.all(width: 2,color: MyTheme.primaryColor,),
      color: (isSelected)? MyTheme.primaryColor: Colors.transparent),
      child: Text(source.name??"",style: TextStyle(
          color:(isSelected)? Colors.white: MyTheme.primaryColor ,
      fontSize: 19),),


    );
  }
}
