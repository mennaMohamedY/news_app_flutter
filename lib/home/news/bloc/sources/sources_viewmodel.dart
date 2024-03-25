
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:newsapp/api_utiles/api_manager.dart';
import 'package:newsapp/home/news/bloc/states/states.dart';

class SourcesViewModel extends Cubit<SourceStates>{

  SourcesViewModel():super(LoadingState());

  void getResources(String categoryID)async{
    try{
      emit(LoadingState());
      var sourceResponse = await APIManager.getResources(categoryID);
      if(sourceResponse.status !='ok'){
        emit(ErrorState(errorMSg: sourceResponse.message!));
      }else{
        //success
        emit(SuccessState(sourcesList: sourceResponse.sources!));
      }
    }catch(e){
      emit(ErrorState(errorMSg: e.toString()));
    }

  }

}