
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:newsapp/api_utiles/api_manager.dart';
import 'package:newsapp/home/news/bloc/sources/repository/articles_repository/resources_repository_interface.dart';
import 'package:newsapp/home/news/bloc/sources/repository/data_sources/resources_datasourcesImp.dart';
import 'package:newsapp/home/news/bloc/sources/repository/data_sources/resources_repositoryimpl.dart';
import 'package:newsapp/home/news/bloc/states/states.dart';

class SourcesViewModel extends Cubit<SourceStates>{

  late ResourcesRepositoryInterface resourcesRepositoryInterface;
  late ResourcesRemoteDataSourceInterface resourcesRemoteDataSourceInterface;
  late APIManager apiManager;
  SourcesViewModel():super(LoadingState()){
    apiManager= APIManager();
    resourcesRemoteDataSourceInterface = ResourcesRemoteDataSourceImpl(apiManager: apiManager);
    resourcesRepositoryInterface = ResourcesRepositoryImp(
        resourcesRemoteDataSourceInterface: resourcesRemoteDataSourceInterface
    );
  }
  

  void getResources(String categoryID)async{
    try{
      emit(LoadingState());
      var sourceResponse = await resourcesRepositoryInterface.getSources(categoryID);
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