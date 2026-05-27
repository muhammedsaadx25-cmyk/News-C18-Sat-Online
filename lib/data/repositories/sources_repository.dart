import 'package:news/data/apis/result.dart';
import 'package:news/models/category_model.dart';

abstract class SourcesRepository{
  Future<Result> getSources(CategoryModel category);
}