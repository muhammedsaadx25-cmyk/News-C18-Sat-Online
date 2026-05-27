import 'package:news/data/apis/articlesResponse/article.dart';
import 'package:news/data/apis/result.dart';

abstract class ArticlesDataSource{
  Future<Result<List<Article>>> getArticles({String? sourceId, String? searchKey, int page = 1, int pageSize = 20});
}