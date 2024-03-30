
import 'package:newsapp/model/NewsResponse.dart';

abstract class ArticlesRepositoryInterface{
  Future<NewsResponse> getArticlesBySourceID(String sourceID,String pageSize,String pageNum);
}

abstract class ArticlesRemoteDataSourceInterface{
  Future<NewsResponse> getArticlesBySourceID(String sourceID,String pageSize,String pageNum);
}
