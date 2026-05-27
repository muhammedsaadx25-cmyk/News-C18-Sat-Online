import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/data/apis/articlesResponse/article.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleBody extends StatelessWidget {
  const ArticleBody({super.key, required this.article});

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
            style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.black,
                height: 1.5,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF171717),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              onPressed: _launchUrl,
              child: Text(
                'View Full Article',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
