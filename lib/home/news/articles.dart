
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/providers/provider.dart';
import 'package:provider/provider.dart';

import '../../api_utiles/api_manager.dart';
import '../../model/NewsResponse.dart';
import '../../mytheme.dart';
import 'articles/singlenews_design.dart';

class MYArticles extends StatefulWidget{
  String sourceID;
  int pageNum=1;
  int pageSize=15;
  var count=20;
  var controllerFlag=0;


  MYArticles({required this.sourceID,required this.controllerFlag});

  @override
  State<MYArticles> createState() => _MYArticlesState();
}

class _MYArticlesState extends State<MYArticles> {
  List<Articles> articlesList=[];
  ScrollController _scrollController = ScrollController();
  List<Articles> searchList=[];
  bool notFound=false;




  @override
  void initState() {
    super.initState();
    //_scrollController.addListener(_loadMoreData);
    fetch();
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
  void _loadMoreData() async{
    print('${articlesList.length}');
    if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
      widget.pageSize+=20;
      widget.count +=20;
      if(widget.count ==100){
        widget.count=0;
        widget.pageNum +=1;
      }
      fetch();
      // User has reached the end of the list
      // Load more data or trigger pagination in flutter

      // var articlesResponse=await APIManager.loadMoreArticles(widget.sourceID, widget.pageNum);
      // var newArticlesList=articlesResponse.articles;

      //articlesList = List.from(articlesList)..addAll(newArticlesList as Iterable<Articles>);
      //var newList = [...articlesList, ...?newArticlesList];
      setState(() {
        //articlesList = List.from(articlesList)..addAll(newArticlesList as Iterable<Articles>);
        //articlesList=newList;
        print('${articlesList.length}');

      });
    }
  }
  void fetch()async{
    var articlesResponse=await APIManager.getNews(widget.sourceID,widget.pageSize.toString(),widget.pageNum.toString());
    var newArticlesList=articlesResponse.articles;
    widget.controllerFlag=1;

    setState(() {
      widget.pageSize =15;
      widget.pageNum +=1;
      articlesList.addAll(newArticlesList!.map((article) {
        return article;
      }).toList());
    });

  }

  @override
  Widget build(BuildContext context) {
    ///leh 3mlna kda 3lshan al futurebuilder bt3ml build llwidget kolaha mn awl wgded w bt3ml load llList
    ///fa bltaly kol mara h3ml scroll kan kan bytl3le fo2 khales w lazm anzl tany
    ///lakn fl listview lma bnstkhdmha fa lma alitem gded bydaf m3 alcontroller hwa byrouh yhmlo
    ///w htena alfutureBuilder bflag 3lshan lma adous 3ala source gded mhtag arouh a3ml rebuild

     return (widget.controllerFlag !=0)?
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
  }



  void OnSearch(String query){
    var provider=Provider.of<NewsProvider>(context);

    if(provider.searchQuery.isNotEmpty){

      setState(() {
        searchList = articlesList
            .where((item) => item.author!.toLowerCase().contains(query.toLowerCase()))
            .toList();
        notFound=true;
        widget.controllerFlag=1;
        provider.getSearchQuery();


        if(query.isNotEmpty && searchList.isEmpty){
          notFound=true;
        }
        
      });
     

    }
  }

}
