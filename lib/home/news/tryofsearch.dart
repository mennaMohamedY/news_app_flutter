

import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/home/news/bloc/articles/articles_viewmodel.dart';
import 'package:newsapp/home/news/bloc/states/states.dart';
import 'package:newsapp/providers/provider.dart';
import 'package:provider/provider.dart';

import '../../api_utiles/api_manager.dart';
import '../../model/NewsResponse.dart';
import '../../mytheme.dart';
import 'singlenews_design.dart';

class MYSearch extends StatefulWidget{
  String sourceID;
  int pageNum=1;
  int pageSize=20;
  var count=20;
  var controllerFlag=0;
  bool isVisible=false;


  MYSearch({required this.sourceID,required this.controllerFlag});

  @override
  State<MYSearch> createState() => _MYSearchState();
}

class _MYSearchState extends State<MYSearch> {
  List<Articles> articlesList=[];
  ScrollController _scrollController = ScrollController();
  final TextEditingController searchcontroller=TextEditingController();
  ArticlesViewModel articlesViewModel=ArticlesViewModel();


  List<Articles> searchList=[];
  bool notFound=false;


  void search(String query) {
    if(query.isEmpty){
      setState(() {
        // items=list;
        searchList=articlesList;
        notFound=false;

      });
    }else{
      setState(() {
        searchList = articlesList
            .where((item) => item.title!.toLowerCase().contains(query.toLowerCase()))
            .toList();
        print(searchList.length);
        if(query.isNotEmpty && searchList.isEmpty){
          //notFound=true;
        }
      });
    }
  }


  @override
  void initState() {
    super.initState();
    //fetch();
    articlesViewModel.getArticlesBySourceID(widget.sourceID);
    _scrollController.addListener((){
      if(_scrollController.offset == _scrollController.position.maxScrollExtent){
      //  fetch();
        articlesViewModel.fetch(widget.sourceID, widget.pageSize, widget.pageNum);
      }});
      searchcontroller.addListener(QueryListener);

  }
  void QueryListener(){
    search(searchcontroller.text);
  }

  @override
  void dispose() {
    _scrollController.dispose();
      searchcontroller.removeListener(QueryListener);
      searchcontroller.dispose();
    super.dispose();
  }
  // void _loadMoreData() async{
  //   print('${articlesList.length}');
  //   if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
  //     widget.pageSize+=20;
  //     widget.count +=20;
  //     if(widget.count ==100){
  //       widget.count=0;
  //       widget.pageNum +=1;
  //     }
  //     fetch();
  //     setState(() {
  //       print('${articlesList.length}');
  //     });
  //   }
  // }
  // void fetch()async{
  //   var articlesResponse=await APIManager.getNews(widget.sourceID,widget.pageSize.toString(),widget.pageNum.toString());
  //   var newArticlesList=articlesResponse.articles;
  //   widget.controllerFlag=1;
  //
  //   setState(() {
  //     widget.pageSize =20;
  //     widget.pageNum +=1;
  //     articlesList.addAll(newArticlesList!.map((article) {
  //       return article;
  //     }).toList());
  //   });
  // }
  void onQueryChanged(String query) {
    setState(() {
      searchList = articlesList
          .where((item) => item.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      if(query.isNotEmpty && searchList.isEmpty){
       // notFound=true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<NewsProvider>(context);
    print ("provider: ${provider.searchQuery}");
    search(provider.searchQuery);
    return  BlocBuilder(
      bloc: articlesViewModel,
      builder:(context,state){
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
                articlesViewModel.articlesList=state.articlesList;
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




void searchlistener(){
  var provider=Provider.of<NewsProvider>(context);

  if(provider.searchQuery.isNotEmpty){
    widget.isVisible=true;
    setState(() {

    });
  }
}
}
/*
 (widget.controllerFlag !=0)?
    ListView.builder(
      shrinkWrap: true,
      controller: _scrollController,

      itemBuilder: (BuildContext context, int position){
        if(position < articlesList.length){
          //need to pass the articles
          return (notFound)?Text("Not Found!"):SingleNewsDesign(article: (searchList.isEmpty)?articlesList[position]:searchList[position],);
        }else{
          return Center(child: CircularProgressIndicator(color: MyTheme.primaryColor),);
        }
      },itemCount: (searchList.isEmpty)?articlesList.length+1:searchList.length,
      scrollDirection: Axis.vertical,
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
          return  ListView.builder(
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
          );
        } );
 */
/*
BlocBuilder(
      bloc: articlesViewModel,
        builder:(context,state){
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
                articlesViewModel.articlesList=state.articlesList;
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
 */