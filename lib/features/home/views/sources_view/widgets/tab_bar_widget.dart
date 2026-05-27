import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/core/resources/colors_manager.dart';
import 'package:news/data/apis/sources_response/source.dart';
import 'package:news/features/home/views/sources_view/articles_view_model.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget(
      {super.key, required this.sources, required this.articlesViewModel});

  final List<Source> sources;
  final ArticlesViewModel articlesViewModel;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: sources.length,
      child: TabBar(
        onTap: (index) =>
            articlesViewModel.loadArticles(sourceId: sources[index].id),
        tabAlignment: TabAlignment.start,
        dividerColor: Colors.transparent,
        indicatorColor: ColorsManager.white,
        isScrollable: true,
        labelStyle: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.white),
        unselectedLabelStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: ColorsManager.white),
        tabs: sources.map((source) => Tab(text: source.name)).toList(),
      ),
    );
  }
}
