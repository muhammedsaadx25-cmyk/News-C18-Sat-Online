import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/core/resources/colors_manager.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  final VoidCallback onSearch;

  const SearchAppBar({
    super.key,
    required this.searchController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search articles...',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            suffixIcon: IconButton(
              icon: const Icon(Icons.search, color: ColorsManager.black),
              onPressed: onSearch,
            ),
          ),
          onSubmitted: (_) => onSearch(),
          style: GoogleFonts.inter(color: ColorsManager.black),
        ),
      ),
      backgroundColor: ColorsManager.black,
      iconTheme: const IconThemeData(color: ColorsManager.white),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
