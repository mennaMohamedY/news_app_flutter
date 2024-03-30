

import 'package:bloc/bloc.dart';
import 'package:newsapp/api_utiles/api_manager.dart';
import 'package:newsapp/home/news/bloc/articles/repository/articles_datasource/articles_datasourceimpl.dart';
import 'package:newsapp/home/news/bloc/articles/repository/articles_datasource/articles_repositoryimpl.dart';
import 'package:newsapp/home/news/bloc/articles/repository/articles_repository/articles_repository.dart';
import 'package:newsapp/home/news/bloc/states/states.dart';
import 'package:newsapp/model/NewsResponse.dart';

class ArticlesViewModel extends Cubit<SourceStates>{
  late ArticlesRepositoryInterface articlesRepositoryInterface;
  late ArticlesRemoteDataSourceInterface articlesRemoteDataSourceInterface;
  late APIManager apiManager;
  List<Articles> articlesList=[];

  ArticlesViewModel():super(LoadingState()){
    apiManager =APIManager();
    articlesRemoteDataSourceInterface =ArticlesRemoteDataSourceImpl(apiManager: apiManager);
    articlesRepositoryInterface=ArticlesRepositoryImpl(articlesRemoteDataSourceInterface: articlesRemoteDataSourceInterface);
  }


  void getArticlesBySourceID(String sourceID)async{
   try{
     emit(LoadingState());
     var articles=await articlesRepositoryInterface.getArticlesBySourceID(sourceID, 20.toString(), 1.toString());
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

  void fetch(String sourceID,int pageSize,int pageNum)async{
    //var articlesResponse=await APIManager.getNews(sourceID,pageSize.toString(),pageNum.toString());
    var articlesResponse=await articlesRepositoryInterface.getArticlesBySourceID(sourceID, pageSize.toString(), pageNum.toString());
    var newArticlesList=articlesResponse.articles;
    articlesList.addAll(newArticlesList!.map((article) {
      return article;
    }).toList());


  }

}