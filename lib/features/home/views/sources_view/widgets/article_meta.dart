import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/core/resources/colors_manager.dart';

class ArticleMeta extends StatelessWidget {
  const ArticleMeta({super.key, required this.author, required this.publishedAt});

  final String? author;
  final String? publishedAt;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            author ?? '',
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: ColorsManager.grey),
          ),
        ),
        Text(
          publishedAt ?? '',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: ColorsManager.grey),
        ),
      ],
    );
  }
}
