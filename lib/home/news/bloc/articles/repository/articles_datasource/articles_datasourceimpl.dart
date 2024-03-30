
import 'package:newsapp/api_utiles/api_manager.dart';
import 'package:newsapp/home/news/bloc/articles/repository/articles_repository/articles_repository.dart';
import 'package:newsapp/model/NewsResponse.dart';

class ArticlesRemoteDataSourceImpl extends ArticlesRemoteDataSourceInterface{
  APIManager apiManager;
  ArticlesRemoteDataSourceImpl({required this.apiManager});
  @override
  Future<NewsResponse> getArticlesBySourceID(String sourceID, String pageSize, String pageNum)async {
    //var response=await apiManager.getNews(sourceID, pageSize, pageNum);
    var response=await APIManager.getNews(sourceID, pageSize, pageNum);

    return response;
  }

}