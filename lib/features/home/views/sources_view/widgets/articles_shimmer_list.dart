import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/features/home/views/sources_view/article_shimmer_item.dart';

class ArticlesShimmerList extends StatelessWidget {
  const ArticlesShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: REdgeInsets.all(16),
        itemCount: 5,
        separatorBuilder: (_, __) => SizedBox(height: 16.h),
        itemBuilder: (_, __) => const ArticleShimmerItem(),
      ),
    );
  }
}
