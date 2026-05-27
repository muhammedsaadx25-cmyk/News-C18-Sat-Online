import 'package:news/core/resources/assets_manager.dart';

class CategoryModel{
  String id;
  String name;
  String imagePath;
  CategoryModel({required this.id, required this.name, required this.imagePath});

  static List<CategoryModel> categories = [
    CategoryModel(id: "general", name: "General", imagePath: ImageAssets.general),
    CategoryModel(id: "sports", name: "Sports", imagePath: ImageAssets.sports),
    CategoryModel(id: "business", name: "Business", imagePath: ImageAssets.business),
    CategoryModel(id: "technology", name: "Technology", imagePath: ImageAssets.business),
    CategoryModel(id: "entertainment", name: "Entertainment", imagePath: ImageAssets.business),
    CategoryModel(id: "health", name: "Health", imagePath: ImageAssets.business),
    CategoryModel(id: "science", name: "Science", imagePath: ImageAssets.business),
  ];
}