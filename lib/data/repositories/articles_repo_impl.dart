import 'package:news/data/apis/articlesResponse/article.dart';
import 'package:news/data/apis/result.dart';
import 'package:news/data/data_sources/articles_data_source.dart';
import 'package:news/data/repositories/articles_repository.dart';

class ArticlesRepositoryImpl implements ArticlesRepository{
  ArticlesDataSource articlesDataSource;
  ArticlesRepositoryImpl({required this.articlesDataSource});
  @override
  Future<Result<List<Article>>> getArticles({String? sourceId, String? searchKey, int page = 1, int pageSize = 20}) {
    return articlesDataSource.getArticles(sourceId: sourceId, searchKey: searchKey, page: page, pageSize: pageSize);
  }

}