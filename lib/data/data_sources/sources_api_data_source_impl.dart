import 'package:injectable/injectable.dart';
import 'package:news/data/apis/api_service.dart';
import 'package:news/data/apis/result.dart';
import 'package:news/data/data_sources/sources_data_source.dart';
import 'package:news/models/category_model.dart';
@Singleton(as: SourcesDataSource)
class SourcesApiDataSourceImpl implements SourcesDataSource{
   APIService apiService;


  /// Dependency Injection
  SourcesApiDataSourceImpl({required this.apiService});

  @override
  Future<Result> getSource(CategoryModel category) {
    return apiService.getSources(category);
  }

}