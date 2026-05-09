import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/core/resources/colors_manager.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.onClose,
  });

  final TextEditingController controller;
  final VoidCallback onSubmitted;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(color: ColorsManager.white, width: 1),
        ),
        child: TextField(
          controller: controller,
          style: GoogleFonts.inter(color: ColorsManager.white),
          onSubmitted: (_) => onSubmitted(),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: GoogleFonts.inter(
              color: ColorsManager.white.withValues(alpha: 0.6),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 12.h),
            prefixIcon: const Icon(
              Icons.search,
              color: ColorsManager.white,
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.close,
                color: ColorsManager.white,
                size: 20,
              ),
              onPressed: onClose,
            ),
          ),
        ),
      ),
    );
  }
}
