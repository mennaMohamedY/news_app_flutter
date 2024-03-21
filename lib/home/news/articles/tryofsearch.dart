

import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/home/news/articles/articles_viewmodel.dart';
import 'package:newsapp/providers/provider.dart';
import 'package:provider/provider.dart';

import '../../../api_utiles/api_manager.dart';
import '../../../model/NewsResponse.dart';
import '../../../mytheme.dart';
import 'singlenews_design.dart';

class MYSearch extends StatefulWidget{
  String sourceID;
  int pageNum=1;
  int pageSize=20;
  var count=20;
  bool isVisible=false;

  MYSearch({required this.sourceID});

  @override
  State<MYSearch> createState() => _MYSearchState();
}

class _MYSearchState extends State<MYSearch> {
  ScrollController _scrollController = ScrollController();
  final TextEditingController searchcontroller=TextEditingController();

  @override
  void initState() {
    super.initState();
    articlesViewModel.getArticlesBySourceID(widget.sourceID, widget.pageSize, widget.pageNum);

    _scrollController.addListener((){
      if(_scrollController.offset == _scrollController.position.maxScrollExtent){
       // yes
        //fetch();
        widget.pageNum +=1;
        //print("pageNum ------------> ${widget.pageNum}");
        articlesViewModel.fetchMoreData(widget.sourceID, widget.pageSize);
      }});
      searchcontroller.addListener(QueryListener);
  }
  void QueryListener(){
    articlesViewModel.search(searchcontroller.text);
  }

  @override
  void dispose() {
    _scrollController.dispose();
      searchcontroller.removeListener(QueryListener);
      searchcontroller.dispose();
    super.dispose();
  }

  ArticlesViewModel articlesViewModel=ArticlesViewModel();

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<NewsProvider>(context);
    print ("provider: ");
    articlesViewModel.search(provider.searchQuery);
    return ChangeNotifierProvider(
        create: (context)=>articlesViewModel,
    child:Consumer<ArticlesViewModel>(
      builder: (context,articlesViewModel,child){
        if(articlesViewModel.errorMsg.isNotEmpty){
          return Column(children: [
            Text(articlesViewModel.errorMsg,style: TextStyle(color: Colors.red),),
            Center(child: ElevatedButton(onPressed: () {
              articlesViewModel.getArticlesBySourceID(widget.sourceID, widget.pageSize, widget.pageNum);
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
        if(articlesViewModel.articlesList.isEmpty){
          return Center(child: CircularProgressIndicator(color: MyTheme.primaryColor),);
        }else{
          return ListView.builder(
            //shrinkWrap: true,
            //1
            controller: _scrollController,
            itemBuilder: (BuildContext context, int position){
              if(position < articlesViewModel.articlesList.length){
                //need to pass the articles
                return (articlesViewModel.notFound)?Text("Not Found!"):SingleNewsDesign(article: (articlesViewModel.searchList.isEmpty)?articlesViewModel.articlesList[position]:articlesViewModel.searchList[position],);
              }else{
                return Center(child: CircularProgressIndicator(color: MyTheme.primaryColor),);
              }
            },itemCount: (articlesViewModel.searchList.isEmpty)?articlesViewModel.articlesList.length+1:articlesViewModel.searchList.length,
            scrollDirection: Axis.vertical,
          );
        }
      },) ,);

  }
}

