
import 'package:flutter/material.dart';
import 'package:newsapp/mytheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SideDrawerr extends StatelessWidget {

  static int categories=0;
  static int settings=1;

  Function onItemClick;
  SideDrawerr({required this.onItemClick});
  @override
  Widget build(BuildContext context) {
    var localization=AppLocalizations.of(context);
    return Drawer( child: Column(
      children: [
      Container(height:MediaQuery.of(context).size.height*0.2,
        width: double.infinity,
        child: Center(child: Text(localization!.newsApp,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),)),
    color: MyTheme.primaryColor,),
        
        Padding(padding: EdgeInsets.all(9),
          child: InkWell(onTap: (){
            onItemClick(categories);
    },child:
          Row(children: [
            Icon(Icons.list),
            SizedBox(width: 9,),
            Text(localization!.categories,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),)
          ],),),
        ),
        Padding(padding:EdgeInsets.all(9) ,child:
        InkWell(onTap:(){
    onItemClick(settings);
    },
          child:
        Row(children: [
          Icon(Icons.settings),
          SizedBox(width: 9,),
          Text(localization!.settings,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),)
        ],),),)
       
    ],),);
  }
}
