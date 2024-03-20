
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/home/news/category_details_view_model.dart';
import 'package:newsapp/home/news/singlenews_design.dart';
import 'package:newsapp/home/tab_layout.dart';
import 'package:provider/provider.dart';

import '../../api_utiles/api_manager.dart';
import '../../model/NewsResponse.dart';
import '../../model/SourceResponse.dart';
import '../../mytheme.dart';
import '../../providers/provider.dart';

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
  void initState() {
    //categoryDetailsViewModel.getSources(widget.categoryID);
    super.initState();
    //categoryDetailsViewModel.getSources(widget.categoryID);
  }

  @override
  Widget build(BuildContext context) {
    //var newsProvider=Provider.of<NewsProvider>(context);
  // categoryDetailsViewModel.getSources(widget.categoryID);

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
                    return TabLayout(sourcesList: categoryDetailsViewModel.sourcesList);
                  }
                    }


            )),
          ),
        ]);
  }

}

/*
FutureBuilder(
                  future:APIManager.getResources(widget.categoryID) ,
                  builder:(BuildContext context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      //still loading the data from the server
                      return Center(child: CircularProgressIndicator(color: MyTheme.primaryColor),);

                    }
                    if(snapshot.hasError){
                      //error mn nhyty ana
                      return Column(children: [
                        Text(snapshot.error.toString(),style: TextStyle(color: Colors.red),),
                        SizedBox(height: 22,),
                        Center(child: ElevatedButton(onPressed: () {
                          APIManager.getResources(widget.categoryID);
                          //setState
                          setState(() {

                          });
                        },
                          child: Text("Try Again !",style: TextStyle(fontSize: 17),),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                                side: BorderSide(color: MyTheme.primaryColor,width: 2),
                              ), backgroundColor: MyTheme.primaryColor
                          ),),)
                      ],);
                    }

                    if(snapshot.data?.status != 'ok'){
                      //mn alserver side w hytl3ly al error msg w alerror code a3rf mnhm eh alsbb
                      return Column(children: [
                        Text(snapshot.data?.message?? "error message",style: TextStyle(color: Colors.red),),
                        Center(child: ElevatedButton(onPressed: () {
                          APIManager.getResources(widget.categoryID);
                          //setState
                          setState(() {});},
                          child: Text("Try Again!",style: TextStyle(fontSize: 18),),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                                side: BorderSide(color: MyTheme.primaryColor,width: 2),
                              ), backgroundColor: MyTheme.primaryColor
                          ),),)
                      ],);
                    }
                    sourcesList=snapshot.data!.sources!;
                    return  TabLayout(sourcesList: sourcesList);

                  } )
 */
