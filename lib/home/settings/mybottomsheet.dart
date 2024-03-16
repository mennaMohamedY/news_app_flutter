
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:newsapp/providers/provider.dart';
import 'package:provider/provider.dart';

class MyBottomSheet extends StatefulWidget{
  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var localization=AppLocalizations.of(context);
    var provider=Provider.of<NewsProvider>(context);

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(12),
          child:(provider.appLanguage=='en')? selectedWidget(localization!.english):
          unSelectedWidget(localization!.english))
        ,
        Padding(
          padding: EdgeInsets.all(12),
          child: (provider.appLanguage=='ar') ? selectedWidget(localization.arabic):unSelectedWidget(localization.arabic)
            
        )
      ],);
  }

  Widget selectedWidget(String lang){
    var localization=AppLocalizations.of(context);
    var r=localization!.english;
    var provider=Provider.of<NewsProvider>(context,listen: false);
    var language=(lang==localization!.english)?'en':'ar';

    return InkWell(onTap: (){
      provider.upDateAppLanguage(language);
    },
      child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
        Text(lang),
        Icon(Icons.check)
      ],),
    );
  }
  
  Widget unSelectedWidget(String lang){
    var localization=AppLocalizations.of(context);
    var provider=Provider.of<NewsProvider>(context,listen: false);
    var language=(lang==localization!.english)?'en':'ar';

    return InkWell(onTap: (){
      provider.upDateAppLanguage(language);
    },
        child: Row(children: [
      Text(lang),
    ],),);
  }
}