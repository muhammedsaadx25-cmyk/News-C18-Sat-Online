import 'package:news/data/apis/result.dart';
import 'package:news/data/data_sources/sources_data_source.dart';
import 'package:news/models/category_model.dart';

class SourcesFireStoreDataSourceImpl implements SourcesDataSource{
  @override
  Future<Result> getSource(CategoryModel category) {
    // TODO: implement getSource
    throw UnimplementedError();
  }

}