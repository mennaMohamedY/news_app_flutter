
import 'package:flutter/material.dart';
import 'package:newsapp/api_utiles/api_manager.dart';
import 'package:newsapp/model/SourceResponse.dart';

class CategoryDetailsViewModel extends ChangeNotifier{

  List<Sources> sourcesList=[];
  String errorMessage='';

  void getSources(String categoryID)async {

   try{
     var souraces= await APIManager.getResources(categoryID);
     if(souraces.status !='ok'){
       //error mn alserver
       errorMessage = souraces.message!;
        return;
     }else{
       sourcesList=souraces.sources!;
     }
   }catch(e){
     //error mn 3ndy
     errorMessage=e.toString();
   }
   notifyListeners();
  }

}