

import 'package:bloc/bloc.dart';
import 'package:newsapp/api_utiles/api_manager.dart';
import 'package:newsapp/home/news/bloc/states/states.dart';
import 'package:newsapp/model/NewsResponse.dart';

class ArticlesViewModel extends Cubit<SourceStates>{
  ArticlesViewModel():super(LoadingState());


  void getArticlesBySourceID(String sourceID)async{
   try{
     emit(LoadingState());
     var articles=await  APIManager.getNews(sourceID, 20.toString(), 1.toString());
     if(articles.status!='ok'){
       emit(ErrorState(errorMSg: articles.message!));
     }
     else{
       emit(SuccessArticlesState(articlesList: articles.articles!));
     }
   }catch(e){
     emit(ErrorState(errorMSg: e.toString()));
   }

  }

  // void fetch(String sourceID,int pageSize,int pageNum)async{
  //   var articlesResponse=await APIManager.getNews(sourceID,pageSize.toString(),pageNum.toString());
  //   var newArticlesList=articlesResponse.articles;
  //
  //   setState(() {
  //     widget.pageSize =15;
  //     widget.pageNum +=1;
  //     articlesList.addAll(newArticlesList!.map((article) {
  //       return article;
  //     }).toList());
  //   });
  //
  // }

}