import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/features/home/views/sources_view/articles_view_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:news/features/home/views/sources_view/sources_viewmodel.dart';
import 'package:news/features/home/views/sources_view/widgets/tab_bar_widget.dart';
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
          return Center(
              child: Text(state.message,
                  style: const TextStyle(color: Colors.white)));
        }
        if (state is SourcesSuccess) {
          return TabBarWidget(
              sources: state.sources, articlesViewModel: articlesViewModel);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
