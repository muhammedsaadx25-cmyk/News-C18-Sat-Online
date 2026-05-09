import 'package:flutter/material.dart';
import 'package:news/features/home/views/sources_view/article_shimmer_item.dart';
import 'package:news/features/home/views/sources_view/articles_view_model.dart';
import 'package:news/features/home/views/sources_view/widgets/articles_list_body.dart';
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
            child: Center(
                child: Text(state.message,
                    style: const TextStyle(color: Colors.white))),
          );
        }
        if (state is ArticlesSuccess) {
          return ArticlesListBody(
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
