import 'package:flutter/material.dart';
import 'package:news/features/home/views/categories_view/categories_view.dart';
import 'package:news/features/home/views/sources_view/sources_view.dart';
import 'package:news/features/home/widgets/custom_drawer.dart';
import 'package:news/models/category_model.dart';

import 'package:news/features/search/views/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Widget view = CategoriesView(onCategoryItemClicked: onCategoryItemClicked,);

  String title = "Home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      drawer:CustomDrawer(goToHome: goToHome,  ),
      body: view,
    );
  }

  void onCategoryItemClicked(CategoryModel category){
    title = category.name;
    view = SourcesView(category: category,);
    setState(() {

    });
  }

  void goToHome(){
    view = CategoriesView(onCategoryItemClicked: onCategoryItemClicked);
    setState(() {

    });
 Navigator.pop(context);
  }
}


