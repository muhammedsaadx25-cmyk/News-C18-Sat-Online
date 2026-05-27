import 'package:news/data/apis/result.dart';
import 'package:news/data/data_sources/sources_data_source.dart';
import 'package:news/data/repositories/sources_repository.dart';
import 'package:news/models/category_model.dart';

class SourcesRepositoryImpl implements SourcesRepository{
   SourcesDataSource sourcesDataSource;

  SourcesRepositoryImpl({required this.sourcesDataSource});
  @override
  Future<Result> getSources(CategoryModel category) {
   return sourcesDataSource.getSource(category);
  }
  
}