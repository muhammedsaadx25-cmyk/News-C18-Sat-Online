import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/core/resources/colors_manager.dart';
import 'package:news/data/apis/sources_response/source.dart';
import 'package:news/features/home/views/sources_view/articles_view_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:news/features/home/views/sources_view/sources_viewmodel.dart';
import 'package:provider/provider.dart';

class SourcesTabBar extends StatelessWidget {
  const SourcesTabBar({super.key, required this.articlesViewModel});

  final ArticlesViewModel articlesViewModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<SourcesViewModel>(
      builder: (context, viewModel, _) {
        final state = viewModel.state;
        if (state is SourcesLoading) {
          return SizedBox(
            height: 48,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[800]!,
              highlightColor: Colors.grey[600]!,
              child: Container(
                height: 40.h,
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
          );
        }
        if (state is SourcesError) {
          return Center(child: Text(state.message, style: const TextStyle(color: Colors.white)));
        }
        if (state is SourcesSuccess) {
          return _TabBarWidget(sources: state.sources, articlesViewModel: articlesViewModel);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _TabBarWidget extends StatelessWidget {
  const _TabBarWidget({required this.sources, required this.articlesViewModel});

  final List<Source> sources;
  final ArticlesViewModel articlesViewModel;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: sources.length,
      child: TabBar(
        onTap: (index) => articlesViewModel.loadArticles(sourceId: sources[index].id),
        tabAlignment: TabAlignment.start,
        dividerColor: Colors.transparent,
        indicatorColor: ColorsManager.white,
        isScrollable: true,
        labelStyle: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.bold, color: ColorsManager.white),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w500, color: ColorsManager.white),
        tabs: sources.map((source) => Tab(text: source.name)).toList(),
      ),
    );
  }
}
