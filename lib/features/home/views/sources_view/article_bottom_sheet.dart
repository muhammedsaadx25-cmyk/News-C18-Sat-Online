import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../apis/articlesResponse/Article.dart';
import '../../../../core/resources/colors_manager.dart';

Future<void> showArticleBottomSheet({
  required BuildContext context,
  required Article article,
  required Future<void> Function(String) onViewFullArticleClick,
}) {
  return showModalBottomSheet(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.r),
    ),
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: ColorsManager.grey, width: 1.w),
                ),
                child: CachedNetworkImage(imageUrl: article.urlToImage ?? ""),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                  article.description ?? "",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(double.infinity, 56.h),
                  backgroundColor: ColorsManager.black,
                  foregroundColor: ColorsManager.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: () async {
                  await onViewFullArticleClick(article.url ?? "");
                },
                child: Text("View Full Article"),
              ),
            ),
          ],
        ),
      );
    },
  );
}
