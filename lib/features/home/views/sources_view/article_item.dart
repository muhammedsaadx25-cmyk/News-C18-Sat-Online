import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/core/resources/colors_manager.dart';
import 'package:news/data/apis/articlesResponse/article.dart';
import 'package:news/features/home/views/sources_view/article_bottom_sheet.dart';
import 'package:shimmer/shimmer.dart';

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
            _ArticleThumbnail(imageUrl: article.urlToImage),
            SizedBox(height: 10.h),
            Text(
              article.title ?? '',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16.sp, color: ColorsManager.white),
            ),
            SizedBox(height: 10.h),
            _ArticleMeta(author: article.author?.toString(), publishedAt: article.publishedAt),
          ],
        ),
      ),
    );
  }
}

class _ArticleThumbnail extends StatelessWidget {
  const _ArticleThumbnail({required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (_, __) => Shimmer.fromColors(
          baseColor: Colors.grey[800]!,
          highlightColor: Colors.grey[600]!,
          child: Container(color: Colors.grey[900]),
        ),
        errorWidget: (_, __, ___) => const Icon(Icons.error),
      ),
    );
  }
}

class _ArticleMeta extends StatelessWidget {
  const _ArticleMeta({required this.author, required this.publishedAt});

  final String? author;
  final String? publishedAt;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            author ?? '',
            style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 12.sp, color: ColorsManager.grey),
          ),
        ),
        Text(
          publishedAt ?? '',
          style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 12.sp, color: ColorsManager.grey),
        ),
      ],
    );
  }
}
