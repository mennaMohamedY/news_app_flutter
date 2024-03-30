
import 'package:newsapp/home/news/bloc/sources/repository/articles_repository/resources_repository_interface.dart';
import 'package:newsapp/model/SourceResponse.dart';

class ResourcesRepositoryImp extends ResourcesRepositoryInterface{
  ResourcesRemoteDataSourceInterface resourcesRemoteDataSourceInterface;
  ResourcesRepositoryImp({required this.resourcesRemoteDataSourceInterface});

  @override
  Future<SourceResponse> getSources(String categoryID)async {
    var response=await resourcesRemoteDataSourceInterface.getSources(categoryID);
    return response;
  }

}