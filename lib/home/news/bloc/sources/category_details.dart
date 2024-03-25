
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/home/news/bloc/sources/sources_viewmodel.dart';
import 'package:newsapp/home/news/bloc/states/states.dart';
import 'package:newsapp/home/news/singlenews_design.dart';
import 'package:newsapp/home/tab_layout.dart';
import 'package:provider/provider.dart';

import '../../../../api_utiles/api_manager.dart';
import '../../../../model/NewsResponse.dart';
import '../../../../model/SourceResponse.dart';
import '../../../../mytheme.dart';
import '../../../../providers/provider.dart';

class NewsScreen extends StatefulWidget {

  static String routeName="NewsScreen";
  String categoryID;
  NewsScreen({required this.categoryID});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  //List<Sources> sourcesList=[];
  List<Articles> articlesList=[];


  SourcesViewModel sourcesViewModel=SourcesViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sourcesViewModel.getResources(widget.categoryID);
  }
  @override
  Widget build(BuildContext context) {
    var newsProvider=Provider.of<NewsProvider>(context);
    return Stack(
        children: [Container(
          child: Image.asset("assets/images/bg.png",fit:BoxFit.fill,height: double.infinity,width: double.infinity,),
        ),
          Container(
            padding: EdgeInsets.all(12),
            child: BlocBuilder<SourcesViewModel,SourceStates>(
              bloc: sourcesViewModel,
              builder:(context,state){
                if(state is LoadingState){
                  return Center(child: CircularProgressIndicator(color: MyTheme.primaryColor),);
                }
                else if(state is ErrorState){
                  return Column(children: [
                    Text(state.errorMSg,style: TextStyle(color: Colors.red),),
                    SizedBox(height: 22,),
                    Center(child: ElevatedButton(onPressed: () {
                      sourcesViewModel.getResources(widget.categoryID);
                    },
                      child: Text("Try Again !",style: TextStyle(fontSize: 17),),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                            side: BorderSide(color: MyTheme.primaryColor,width: 2),
                          ), backgroundColor: MyTheme.primaryColor
                      ),),)
                  ],);
                }
                else if(state is SuccessState){
                  return  TabLayout(sourcesList: state.sourcesList);
                }
                else{
                  return Container();
                }

              },),
          )
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
