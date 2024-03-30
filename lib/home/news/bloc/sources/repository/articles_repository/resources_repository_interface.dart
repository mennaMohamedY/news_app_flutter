

import 'package:newsapp/model/SourceResponse.dart';

abstract class ResourcesRepositoryInterface{
  Future<SourceResponse> getSources(String categoryID);
}

abstract class ResourcesRemoteDataSourceInterface{
  Future<SourceResponse> getSources(String categoryID);

}