
import '../../../../model/NewsResponse.dart';
import '../../../../model/SourceResponse.dart';

abstract class SourceStates{}

class LoadingState extends SourceStates{}

class ErrorState extends SourceStates{
  String errorMSg;
  ErrorState({required this.errorMSg});
}

class SuccessState extends SourceStates{
  List<Sources> sourcesList=[];
  SuccessState({required this.sourcesList});
}

class SuccessArticlesState extends SourceStates{
  List<Articles> articlesList=[];
SuccessArticlesState({required this.articlesList});
}