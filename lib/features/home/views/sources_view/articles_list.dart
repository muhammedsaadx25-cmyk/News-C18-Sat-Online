import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:news/data/apis/articlesResponse/article.dart';
import 'package:news/features/home/views/sources_view/article_item.dart';
import 'package:news/features/home/views/sources_view/article_shimmer_item.dart';
import 'package:news/features/home/views/sources_view/articles_view_model.dart';
import 'package:provider/provider.dart';

class ArticlesList extends StatelessWidget {
  const ArticlesList({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticlesViewModel>(
      builder: (context, viewModel, _) {
        final state = viewModel.state;

        if (state is ArticlesLoading) return const ArticlesShimmerList();
        if (state is ArticlesError) {
          return Expanded(
            child: Center(child: Text(state.message, style: const TextStyle(color: Colors.white))),
          );
        }
        if (state is ArticlesSuccess) {
          return _ArticlesListBody(
            articles: state.articles,
            isFetchingMore: state.isFetchingMore,
            scrollController: scrollController,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _ArticlesListBody extends StatelessWidget {
  const _ArticlesListBody({
    required this.articles,
    required this.isFetchingMore,
    required this.scrollController,
  });

  final List<Article> articles;
  final bool isFetchingMore;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              controller: scrollController,
              padding: REdgeInsets.all(16),
              itemCount: articles.length,
              separatorBuilder: (_, __) => SizedBox(height: 16.h),
              itemBuilder: (_, index) => ArticleItem(article: articles[index]),
            ),
          ),
          if (isFetchingMore)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: const ArticleShimmerItem(),
            ),
        ],
      ),
    );
  }
}
