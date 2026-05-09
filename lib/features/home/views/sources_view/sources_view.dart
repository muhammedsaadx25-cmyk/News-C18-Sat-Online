import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/core/resources/colors_manager.dart';
import 'package:news/data/apis/api_service.dart';
import 'package:news/data/apis/articlesResponse/article.dart';
import 'package:news/data/apis/sources_response/source.dart';
import 'package:news/data/data_sources/articles_api_datasource_impl.dart';
import 'package:news/data/data_sources/sources_api_data_source_impl.dart';
import 'package:news/data/repositories/articles_repo_impl.dart';
import 'package:news/data/repositories/sources_repo_impl.dart';
import 'package:news/features/home/views/sources_view/article_item.dart';
import 'package:news/features/home/views/sources_view/articles_view_model.dart';
import 'package:news/features/home/views/sources_view/sources_viewmodel.dart';
import 'package:news/models/category_model.dart';
import 'package:news/features/home/views/sources_view/article_shimmer_item.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
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
    articlesViewModel.loadArticles(
      sourceId: (sourcesViewModel.state as SourcesSuccess).sources[0].id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => sourcesViewModel),
        ChangeNotifierProvider(create: (context) => articlesViewModel),
      ],
      child: Column(
        children: [
          Consumer<SourcesViewModel>(
            builder: (context, viewModel, _) {
              var state = viewModel.state;
              switch (state) {
                case SourcesInitial():
                  return Container();
                case SourcesLoading():
                  return Shimmer.fromColors(
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
                  );
                case SourcesSuccess():
                  List<Source> sources = state.sources;
                  return DefaultTabController(
                    length: sources.length,
                    child: TabBar(
                      onTap: (index) {
                        articlesViewModel.loadArticles(sourceId: sources[index].id);
                      },
                      tabAlignment: TabAlignment.start,
                      dividerColor: Colors.transparent,
                      indicatorColor: ColorsManager.white,
                      isScrollable: true,
                      labelStyle: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.white,
                      ),
                      unselectedLabelStyle: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.white,
                      ),
                      tabs: sources
                          .map((source) => Tab(text: source.name))
                          .toList(),
                    ),
                  );
                case SourcesError():
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                case null:
                  return Container();
              }
            },
          ),
          Consumer<ArticlesViewModel>(
            builder: (context, viewModel, child) {
              final state = viewModel.state;

              if (state is ArticlesLoading) {
                return const ArticlesShimmerList();
              } else if (state is ArticlesError) {
                return Center(child: Text(state.message));
              } else if (state is ArticlesSuccess) {
                final List<Article> articles = state.articles;
                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          controller: _scrollController,
                          itemBuilder: (context, index) =>
                              ArticleItem(article: articles[index]),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16.h),
                          itemCount: articles.length,
                        ),
                      ),
                      if (state.isFetchingMore)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: const ArticleShimmerItem(),
                        ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
