import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/data/apis/articlesResponse/article.dart';
import 'package:news/features/home/views/sources_view/widgets/article_body.dart';
import 'package:news/features/home/views/sources_view/widgets/article_image.dart';

class ArticleBottomSheet extends StatelessWidget {
  const ArticleBottomSheet({super.key, required this.article});

  final Article article;

  static void show(BuildContext context, Article article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ArticleBottomSheet(article: article),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ArticleImage(imageUrl: article.urlToImage),
            ArticleBody(article: article),
          ],
        ),
      ),
    );
  }
}
