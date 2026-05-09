import 'package:injectable/injectable.dart';
import 'package:news/data/apis/api_service.dart';
import 'package:news/data/apis/result.dart';
import 'package:news/data/data_sources/sources_api_data_source_impl.dart';
import 'package:news/data/data_sources/sources_data_source.dart';
import 'package:news/data/repositories/sources_repository.dart';
import 'package:news/models/category_model.dart';
@Singleton(as: SourcesRepository)
class SourcesRepositoryImpl implements SourcesRepository{
   SourcesDataSource sourcesDataSource;

  SourcesRepositoryImpl({required this.sourcesDataSource});
  @override
  Future<Result> getSources(CategoryModel category) {
   return sourcesDataSource.getSource(category);
  }
  
}