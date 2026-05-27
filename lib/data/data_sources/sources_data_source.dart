import 'package:news/data/apis/result.dart';
import 'package:news/models/category_model.dart';

abstract class SourcesDataSource{
  Future<Result>getSource(CategoryModel category);
}