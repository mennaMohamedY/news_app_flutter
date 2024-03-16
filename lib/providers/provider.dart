

import 'package:flutter/cupertino.dart';

import '../model/SourceResponse.dart';

class NewsProvider extends ChangeNotifier {
  String sourceID='abc-news';
  int tabIndex=0;
  String searchQuery='';
  Function? QueryListener;
  String appLanguage='en';




  void UpdateSourceID(String newSourceID){
    sourceID=newSourceID;
    notifyListeners();

  }
  void UpdateTabIndex(int newindex){
    tabIndex=newindex;
    notifyListeners();
  }
  void UpdateSearchQuery(String newQuery){
    searchQuery=newQuery;
    notifyListeners();
  }
  void getSearchQuery(){
    QueryListener?.call();
    notifyListeners();

  }
  void upDateAppLanguage(String newLang){
    if(newLang==appLanguage){
      return;
    }
    appLanguage=newLang;
    notifyListeners();
  }

}