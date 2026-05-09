import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/core/resources/colors_manager.dart';
import 'package:news/data/apis/articlesResponse/article.dart';
import 'package:news/features/home/views/sources_view/article_bottom_sheet.dart';
import 'package:news/features/home/views/sources_view/widgets/article_meta.dart';
import 'package:news/features/home/views/sources_view/widgets/article_thumbnail.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ArticleBottomSheet.show(context, article),
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: ColorsManager.white, width: 1.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArticleThumbnail(imageUrl: article.urlToImage),
            SizedBox(height: 10.h),
            Text(
              article.title ?? '',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: ColorsManager.white),
            ),
            SizedBox(height: 10.h),
            ArticleMeta(
                author: article.author?.toString(),
                publishedAt: article.publishedAt),
          ],
        ),
      ),
    );
  }
}
