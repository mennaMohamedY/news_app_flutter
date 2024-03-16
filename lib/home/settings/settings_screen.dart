
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:newsapp/home/settings/mybottomsheet.dart';
import 'package:newsapp/mytheme.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName="SettingsScreen";

  @override
  Widget build(BuildContext context) {
    var localization=AppLocalizations.of(context);

    return Stack(children: [
      Image.asset("assets/images/bg.png")
      ,
      Container(

        padding: EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.stretch,children: [
          Text(localization!.language,style: TextStyle(color: Colors.black,fontSize: 19,),),
          Container(margin:EdgeInsets.symmetric(vertical: 12),padding:EdgeInsets.symmetric(vertical: 12,horizontal: 8),decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(7,)),color: MyTheme.primaryColor,
              border:Border.all(width: 2,color: MyTheme.primaryColor) ),child:
            InkWell(
              onTap: (){
                showModalBottomSheet(context: context,
                    builder:(context){
                  return MyBottomSheet();
                    });
              },
              child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                Text(localization.language,style: TextStyle(fontSize: 17,color: Colors.white),),
                Icon(Icons.arrow_drop_down,color: Colors.white,)
              ]),
            ),)


        ],),
      )
      
    ],);
  }
}
