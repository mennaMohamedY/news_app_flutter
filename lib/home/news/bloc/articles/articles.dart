
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/home/news/bloc/articles/articles_viewmodel.dart';
import 'package:newsapp/home/news/bloc/states/states.dart';
import 'package:newsapp/providers/provider.dart';
import 'package:provider/provider.dart';

import '../../../../api_utiles/api_manager.dart';
import '../../../../model/NewsResponse.dart';
import '../../../../mytheme.dart';
import '../../singlenews_design.dart';

class MYArticles extends StatefulWidget{
  String sourceID;
  int pageNum=1;
  int pageSize=15;



  MYArticles({required this.sourceID});

  @override
  State<MYArticles> createState() => _MYArticlesState();
}

class _MYArticlesState extends State<MYArticles> {
  //but this function in the viewmodel
  late List<Articles> articlesList=[];
  ScrollController _scrollController = ScrollController();
  List<Articles> searchList=[];
  bool notFound=false;




  @override
  void initState() {
    super.initState();
    //_scrollController.addListener(_loadMoreData);
    //fetch();
    _scrollController.addListener((){
    if(_scrollController.offset == _scrollController.position.maxScrollExtent){
       fetch();
    }});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  //but this function in the viewmodel


  void fetch()async{
    widget.pageSize =15;
    widget.pageNum +=1;

    var articlesResponse=await APIManager.getNews(widget.sourceID,widget.pageSize.toString(),widget.pageNum.toString());
    var newArticlesList=articlesResponse.articles;
    setState(() {
      articlesList.addAll(newArticlesList!.map((article) {
        return article;
      }).toList());
    });
  }

  ArticlesViewModel articlesViewModel=ArticlesViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: articlesViewModel,
        builder: (context,state){
        if(state is LoadingState){
          return Center(child: CircularProgressIndicator(color: MyTheme.primaryColor),);
        }
        else if(state is ErrorState){
          return Column(children: [

            Text(state.errorMSg,style: TextStyle(color: Colors.red),),
            Center(child: ElevatedButton(onPressed: () {
              articlesViewModel.getArticlesBySourceID(widget.sourceID);
            },
              child: Text("Try Again!",style: TextStyle(fontSize: 18),),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                    side: BorderSide(color: MyTheme.primaryColor,width: 2),
                  ), backgroundColor: MyTheme.primaryColor
              ),),)
          ],);
        }
        else if(state is SuccessArticlesState){
          return Expanded(
            child: ListView.builder(
              controller: _scrollController,


              itemBuilder: (BuildContext context, int position){
                articlesList=state.articlesList;
                if(position < state.articlesList.length){
                  //need to pass the articles

                  return SingleNewsDesign(article: state.articlesList[position],);
                }else{
                  return Center(child: CircularProgressIndicator(color: MyTheme.primaryColor),);
                }
              },itemCount: state.articlesList.length+1,
              scrollDirection: Axis.vertical,
            ),
          );
        }
        else{
          return Container();
        }
        },);
  }

}

/*
(widget.controllerFlag !=0)?
     Expanded(
       child: ListView.builder(
         controller: _scrollController,

         itemBuilder: (BuildContext context, int position){
           if(position < articlesList.length){
             //need to pass the articles
             return (notFound)?Text("Not Found!"):
             SingleNewsDesign(article: (searchList.isEmpty)?articlesList[position]:searchList[position],);
           }else{
             return Center(child: CircularProgressIndicator(color: MyTheme.primaryColor),);
           }
         },itemCount: (searchList.isEmpty)?articlesList.length+1:searchList.length,
         scrollDirection: Axis.vertical,
       ),
     ):
    FutureBuilder(
        future: APIManager.getNews(widget.sourceID,widget.pageSize.toString(),widget.pageNum.toString()),
        builder:(BuildContext context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: MyTheme.primaryColor),);
          }
          if(snapshot.hasError){
            //error mn nhyty
            print('${snapshot.error}');
            return Column(children: [

              Text(snapshot.data?.message?? "error messagee",style: TextStyle(color: Colors.red),),
              Center(child: ElevatedButton(onPressed: () {
                APIManager.getNews(widget.sourceID,widget.pageSize.toString(),widget.pageNum.toString());
                //APIManager.loadMoreArticles('abc-news', 1);
               setState(() {});
                },
                child: Text("Try Again!",style: TextStyle(fontSize: 18),),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                      side: BorderSide(color: MyTheme.primaryColor,width: 2),
                    ), backgroundColor: MyTheme.primaryColor
                ),),)
            ],);
          }
          if(snapshot.data!.status != 'ok'){
            return Column(children: [

              Text(snapshot.data?.message?? "error message",style: TextStyle(color: Colors.red),),
              Center(child: ElevatedButton(onPressed: () {
                APIManager.getNews(widget.sourceID,widget.pageSize.toString(),widget.pageNum.toString());
                //APIManager.loadMoreArticles('abc-news', 1);
                setState(() {});
                },
                child: Text("Try Again!",style: TextStyle(fontSize: 18),),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                      side: BorderSide(color: MyTheme.primaryColor,width: 2),
                    ), backgroundColor: MyTheme.primaryColor
                ),),)
            ],);
          }
          articlesList=snapshot.data?.articles??[];
          print('${articlesList.length}');
          return  Expanded(
            child: ListView.builder(
              controller: _scrollController,

              itemBuilder: (BuildContext context, int position){
                if(position < articlesList.length){
                  //need to pass the articles
                  return SingleNewsDesign(article: articlesList[position],);
                }else{
                  return Center(child: CircularProgressIndicator(color: MyTheme.primaryColor),);
                }
              },itemCount: articlesList.length+1,
            scrollDirection: Axis.vertical,
             ),
          );
        } );
 */
