

import 'package:flutter/material.dart';
import 'package:newsapp/api_utiles/api_manager.dart';

import '../../../model/NewsResponse.dart';

class ArticlesViewModel extends ChangeNotifier{
  List<Articles> articlesList=[];
  String errorMsg='';
  String errorMsg2='';


  void getArticlesBySourceID(String sourceID,int pageSize,int pageNum)async{

    try{
      var articles=await APIManager.getNews(sourceID, pageSize.toString(), pageNum.toString());
      if(articles.status !='ok'){
        errorMsg=articles.message!;
      }else{
        articlesList=articles.articles!;
      }
    }catch(e){
      errorMsg=e.toString();
    }
    notifyListeners();
  }

  var pageNum =1;
  void fetchMoreData(String sourceID,int pageSize)async{
      try{
        pageSize =20;
        pageNum+=1;
        print("pageNum-----------------------> ${pageNum}");

        var articlesResponse=await APIManager.getNews(sourceID,pageSize.toString(),pageNum.toString());
        var newArticlesList=articlesResponse.articles;
        articlesList.addAll(newArticlesList!.map((article) {
          return article;
        }).toList());
        print("newListLengthvm-----------------------> ${newArticlesList.length}");

        print("articlesListLengthvm-----------------------> ${articlesList.length}");

      }catch(e){
        print("${e.toString()}");
      }
  }

  List<Articles> searchList=[];
  bool notFound=false;

  void search(String query){
      if(query.isEmpty){

        searchList=articlesList;
        notFound=false;

      }else{
        searchList=articlesList.where((item) => item.title!.toLowerCase().contains(query.toLowerCase()))
            .toList();
        print(searchList.length);
        if(searchList.isEmpty){
          notFound=true;
        }
      }
      notifyListeners();
  }

}