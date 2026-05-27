import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/core/resources/colors_manager.dart';
import 'package:news/data/apis/articlesResponse/article.dart';
import 'package:news/features/home/views/sources_view/article_item.dart';
import 'package:news/features/home/views/sources_view/article_shimmer_item.dart';

class SearchResultsList extends StatelessWidget {
  final List<Article> articles;
  final ScrollController scrollController;
  final bool isFetchingMore;

  const SearchResultsList({
    super.key,
    required this.articles,
    required this.scrollController,
    required this.isFetchingMore,
  });

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) {
      return Center(
        child: Text(
          'No articles found',
          style: GoogleFonts.inter(color: ColorsManager.white),
        ),
      );
    }
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            controller: scrollController,
            padding: EdgeInsets.all(16.w),
            itemCount: articles.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              return ArticleItem(article: articles[index]);
            },
          ),
        ),
        if (isFetchingMore)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: const ArticleShimmerItem(),
          ),
      ],
    );
  }
}
