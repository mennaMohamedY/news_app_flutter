
import 'package:newsapp/api_utiles/api_manager.dart';
import 'package:newsapp/model/SourceResponse.dart';

import '../articles_repository/resources_repository_interface.dart';

class ResourcesRemoteDataSourceImpl extends ResourcesRemoteDataSourceInterface{

  APIManager apiManager;
  ResourcesRemoteDataSourceImpl({required this.apiManager});
  @override
  Future<SourceResponse> getSources(String categoryID)async {
    var response=await apiManager.getResources(categoryID);
    return response;
  }

}