
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/home/news/resources/category_details_view_model.dart';
import 'package:newsapp/home/news/articles/singlenews_design.dart';
import 'package:newsapp/home/tab_layout.dart';
import 'package:provider/provider.dart';

import '../../../api_utiles/api_manager.dart';
import '../../../model/NewsResponse.dart';
import '../../../model/SourceResponse.dart';
import '../../../mytheme.dart';
import '../../../providers/provider.dart';

class NewsScreen extends StatefulWidget {

  static String routeName="NewsScreen";
  String categoryID;
  NewsScreen({required this.categoryID});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  List<Sources> sourcesList=[];
  List<Articles> articlesList=[];
  CategoryDetailsViewModel categoryDetailsViewModel=CategoryDetailsViewModel();

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [Container(
          child: Image.asset("assets/images/bg.png",fit:BoxFit.fill,height: double.infinity,width: double.infinity,),
        ),
          ChangeNotifierProvider(
            create: (context)=>CategoryDetailsViewModel(),
            child: Container(
              padding: EdgeInsets.all(12),
              child: Consumer<CategoryDetailsViewModel>(
                builder: (context,categoryDetailsViewModel,child){
                  categoryDetailsViewModel.getSources(widget.categoryID);

                  if(categoryDetailsViewModel.errorMessage.isNotEmpty){
                    //error mn nhyty ana aw mn nhyt al server
                    return Column(children: [
                      Text(categoryDetailsViewModel.errorMessage,style: TextStyle(color: Colors.red),),
                      SizedBox(height: 22,),
                      Center(child: ElevatedButton(child: Text("Try Again!"),onPressed: (){
                        APIManager.getResources(widget.categoryID);
                        //setState
                        categoryDetailsViewModel.getSources(widget.categoryID);
                        setState(() {

                        });
                      },),),
                    ]);}
                 if(categoryDetailsViewModel.sourcesList.isEmpty){
                    return Center(child: CircularProgressIndicator(color: MyTheme.primaryColor),);
                  }else{
                    return //Text("data");

                      TabLayout(sourcesList: categoryDetailsViewModel.sourcesList);
                  }
                    }
            )),
          ),
        ]);
  }

}

