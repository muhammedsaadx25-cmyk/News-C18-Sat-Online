import 'package:injectable/injectable.dart';
import 'package:news/data/apis/api_service.dart';
import 'package:news/data/apis/result.dart';
import 'package:news/data/apis/sources_response/Source.dart';
import 'package:news/data/data_sources/articles_data_source.dart';
@Singleton(as: ArticlesDataSource)
class ArticlesApiDataSourceImpl implements ArticlesDataSource{

  APIService apiService;
  ArticlesApiDataSourceImpl({required this.apiService});
  @override
  Future<Result> getArticles(Source source) {
    return apiService.getArticles(source);
  }

}