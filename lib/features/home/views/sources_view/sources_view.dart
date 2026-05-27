import 'package:flutter/material.dart';
import 'package:news/data/apis/api_service.dart';
import 'package:news/data/data_sources/articles_api_datasource_impl.dart';
import 'package:news/data/data_sources/sources_api_data_source_impl.dart';
import 'package:news/data/repositories/articles_repo_impl.dart';
import 'package:news/data/repositories/sources_repo_impl.dart';
import 'package:news/features/home/views/sources_view/articles_list.dart';
import 'package:news/features/home/views/sources_view/articles_view_model.dart';
import 'package:news/features/home/views/sources_view/sources_tab_bar.dart';
import 'package:news/features/home/views/sources_view/sources_viewmodel.dart';
import 'package:news/models/category_model.dart';
import 'package:provider/provider.dart';

class SourcesView extends StatefulWidget {
  const SourcesView({super.key, required this.category});

  final CategoryModel category;

  @override
  State<SourcesView> createState() => _SourcesViewState();
}

class _SourcesViewState extends State<SourcesView> {
  late SourcesViewModel sourcesViewModel;
  late ArticlesViewModel articlesViewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    fetchData();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      articlesViewModel.loadMoreArticles();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void fetchData() async {
    sourcesViewModel = SourcesViewModel(
      sourcesRepository: SourcesRepositoryImpl(
        sourcesDataSource: SourcesApiDataSourceImpl(apiService: APIService()),
      ),
    );
    articlesViewModel = ArticlesViewModel(
      articlesRepository: ArticlesRepositoryImpl(
        articlesDataSource: ArticlesApiDataSourceImpl(apiService: APIService()),
      ),
    );
    await sourcesViewModel.loadSources(widget.category);
    if (sourcesViewModel.state is SourcesSuccess) {
      articlesViewModel.loadArticles(
        sourceId: (sourcesViewModel.state as SourcesSuccess).sources[0].id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: sourcesViewModel),
        ChangeNotifierProvider.value(value: articlesViewModel),
      ],
      child: Column(
        children: [
          SourcesTabBar(articlesViewModel: articlesViewModel),
          ArticlesList(scrollController: _scrollController),
        ],
      ),
    );
  }
}
