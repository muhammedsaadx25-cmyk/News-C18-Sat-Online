import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/data/apis/articlesResponse/article.dart';
import 'package:news/features/home/views/sources_view/article_item.dart';
import 'package:news/features/home/views/sources_view/article_shimmer_item.dart';

class ArticlesListBody extends StatelessWidget {
  const ArticlesListBody({
    super.key,
    required this.articles,
    required this.isFetchingMore,
    required this.scrollController,
  });

  final List<Article> articles;
  final bool isFetchingMore;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              controller: scrollController,
              padding: REdgeInsets.all(16),
              itemCount: articles.length,
              separatorBuilder: (_, __) => SizedBox(height: 16.h),
              itemBuilder: (_, index) => ArticleItem(article: articles[index]),
            ),
          ),
          if (isFetchingMore)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: const ArticleShimmerItem(),
            ),
        ],
      ),
    );
  }
}
