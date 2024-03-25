

import 'package:flutter/material.dart';
import 'package:newsapp/api_utiles/api_manager.dart';
import 'package:newsapp/home/categories/categories_screen.dart';
import 'package:newsapp/home/categories/cateory_dm.dart';
import 'package:newsapp/home/drawer/sidedrawer.dart';
import 'package:newsapp/home/errorwidget.dart';
import 'package:newsapp/home/news/bloc/sources/category_details.dart';
import 'package:newsapp/home/settings/settings_screen.dart';
import 'package:newsapp/home/news/singlenews_design.dart';
import 'package:newsapp/home/tab_layout.dart';
import 'package:newsapp/model/NewsResponse.dart';
import 'package:newsapp/model/SourceResponse.dart';
import 'package:newsapp/mytheme.dart';
import 'package:newsapp/providers/provider.dart';
import 'package:provider/provider.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {

  static String routeName="HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Sources> sourcesList = [];
  List<Articles> articlesList = [];
  int selectedWidgetIndex = 0;
  var selectedCategory=null;
  String? categoryID=null;


  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<NewsProvider>(context);
    var localization=AppLocalizations.of(context);
    return Scaffold(appBar:
    // AppBar(
    //   title: Text((selectedWidgetIndex==0)?localization!.newsApp:localization!.settings,style: TextStyle(color: Colors.white),),
    //   actions: [
    //     IconButton(onPressed: (){
    //       provider.UpdateSearchQuery("yess");
    //     }, icon: Icon(Icons.search))
    //   ],
    // ),
    EasySearchBar(
       onSearch: (value){

         if(value.isNotEmpty){
           provider.UpdateSearchQuery(value);
         }
         if(value.isEmpty){
           provider.UpdateSearchQuery('');

         }
         //provider.QueryListener!(value);

       },
      title: Text((selectedWidgetIndex==0)?localization!.newsApp:localization!.settings,style: TextStyle(color: Colors.white),),
      iconTheme: IconThemeData( color: Colors.white),
    ),
      drawer: Drawer(child: SideDrawerr(onItemClick: OnItemClick,)),
      body: (selectedWidgetIndex == 0) ?
      (selectedCategory==null)? CategoriesList(OnCategoryClickListener: OnCategoryClickListener,):
      NewsScreen(categoryID: categoryID!) : SettingsScreen(),);
  }


  void OnItemClick(int selectedDrawerItem) {
    selectedWidgetIndex = selectedDrawerItem;
    Navigator.pop(context);
    selectedCategory=null;
    setState(() {});
  }
  void OnCategoryClickListener(CategoryDataModel categoryDataModel){
    //NewsScreen(categoryID: categoryDataModel.id,);
    selectedCategory=categoryDataModel;
    categoryID=categoryDataModel.id;

    setState(() {});
  }
}
