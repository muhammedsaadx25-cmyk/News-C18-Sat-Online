import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/data/apis/articlesResponse/article.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';

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
            _ArticleImage(imageUrl: article.urlToImage),
            _ArticleBody(article: article),
          ],
        ),
      ),
    );
  }
}

class _ArticleImage extends StatelessWidget {
  const _ArticleImage({required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        width: double.infinity,
        height: 250.h,
        fit: BoxFit.cover,
        placeholder: (_, __) => Shimmer.fromColors(
          baseColor: Colors.grey[800]!,
          highlightColor: Colors.grey[600]!,
          child: Container(color: Colors.grey[900]),
        ),
        errorWidget: (_, __, ___) => const Icon(Icons.error, color: Colors.black),
      ),
    );
  }
}

class _ArticleBody extends StatelessWidget {
  const _ArticleBody({required this.article});

  final Article article;

  Future<void> _launchUrl() async {
    if (article.url == null || article.url!.isEmpty) return;
    final Uri uri = Uri.parse(article.url!);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) return;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            article.content ?? article.description ?? 'No content available.',
            style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.black, height: 1.5, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF171717),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
              onPressed: _launchUrl,
              child: Text(
                'View Full Article',
                style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
