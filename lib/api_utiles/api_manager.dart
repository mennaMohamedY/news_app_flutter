import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/api_utiles/constants.dart';
import 'package:newsapp/model/NewsResponse.dart';
import 'package:newsapp/model/SourceResponse.dart';
class APIManager{

  static Future<SourceResponse> getResources(String categoryID)async {
    Uri url=Uri.https(
      Constants.baseUrl,
      Constants.apiSourcesService,
      {
        "apiKey": Constants.apiKey,
        "category":categoryID
      }
    );
    try{
      var soucesResponce=await http.get(url);
      //returned as a string
      var sourcesbody=soucesResponce.body;
      //so we need to convert it to json
      var json =jsonDecode(sourcesbody);
      return SourceResponse.fromJson(json);

    }catch(e){
      throw e;
    }
  }
  //,int pageNum
  
  static Future<NewsResponse> getNews(String sourceID,String pageSize,String pageNum)async {
    Uri url =Uri.https(Constants.baseUrl,
    Constants.apiNewsService,
    {
      "apiKey": Constants.apiKey,
      "sources":sourceID,
      "pageSize":pageSize,
      "page":pageNum,

    });
    try{
      var newsResponse=await http.get(url);
      var body=newsResponse.body;
      var json=jsonDecode(body);
      print('${NewsResponse.fromJson(json).articles?.length}');
      return NewsResponse.fromJson(json);
    }
    catch(e){
      print('error ${e}');
      throw e;
    }

  }

  static Future<NewsResponse> loadMoreArticles(String sourceID,int pageNum)async {
    Uri url =Uri.https(Constants.baseUrl,
        Constants.apiNewsService,
        {
          "apiKey": Constants.apiKey,
          "sources":sourceID,
          "page":pageNum
        });
    var newsResponse=await http.get(url);
    var body=newsResponse.body;
    var json=jsonDecode(body);
    return NewsResponse.fromJson(json);
  }
}