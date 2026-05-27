import 'package:news/data/apis/api_service.dart';
import 'package:news/data/apis/articlesResponse/article.dart';
import 'package:news/data/apis/result.dart';
import 'package:news/data/data_sources/articles_data_source.dart';

class ArticlesApiDataSourceImpl implements ArticlesDataSource{

  APIService apiService;
  ArticlesApiDataSourceImpl({required this.apiService});
  @override
  Future<Result<List<Article>>> getArticles({String? sourceId, String? searchKey, int page = 1, int pageSize = 20}) {
    return apiService.getArticles(sourceId: sourceId, searchKey: searchKey, page: page, pageSize: pageSize);
  }

}