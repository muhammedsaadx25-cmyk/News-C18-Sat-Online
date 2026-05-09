import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ArticleShimmerItem extends StatelessWidget {
  const ArticleShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 180.h,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              width: double.infinity,
              height: 16.h,
              color: Colors.grey[700],
            ),
            SizedBox(height: 6.h),
            Container(
              width: 200.w,
              height: 16.h,
              color: Colors.grey[700],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Container(width: 100.w, height: 12.h, color: Colors.grey[700]),
                const Spacer(),
                Container(width: 80.w, height: 12.h, color: Colors.grey[700]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
