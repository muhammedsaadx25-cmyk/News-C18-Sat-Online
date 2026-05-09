import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/features/home/views/categories_view/category_item.dart';
import 'package:news/models/category_model.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key, required this.onCategoryItemClicked});
  final void Function(CategoryModel) onCategoryItemClicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Good Morning\nHere is Some News For You",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (_, index) =>
                  InkWell(
                      onTap: (){
                        onCategoryItemClicked(CategoryModel.categories[index]);
                      },
                      child: CategoryItem(category: CategoryModel.categories[index])),
              separatorBuilder: (_, index)=> SizedBox(height: 16.h,),
              itemCount: CategoryModel.categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
