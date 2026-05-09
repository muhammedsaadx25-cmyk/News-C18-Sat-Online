import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ArticleImage extends StatelessWidget {
  const ArticleImage({super.key, required this.imageUrl});

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
