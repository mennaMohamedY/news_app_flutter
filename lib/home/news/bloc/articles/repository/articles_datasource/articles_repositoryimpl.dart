
import 'package:newsapp/home/news/bloc/articles/repository/articles_repository/articles_repository.dart';
import 'package:newsapp/model/NewsResponse.dart';

class ArticlesRepositoryImpl extends ArticlesRepositoryInterface{
  ArticlesRemoteDataSourceInterface articlesRemoteDataSourceInterface;
  ArticlesRepositoryImpl({required this.articlesRemoteDataSourceInterface});

  @override
  Future<NewsResponse> getArticlesBySourceID(String sourceID, String pageSize, String pageNum) async{
    var response =await articlesRemoteDataSourceInterface.getArticlesBySourceID(sourceID, pageSize, pageNum);
    return response;
  }

}