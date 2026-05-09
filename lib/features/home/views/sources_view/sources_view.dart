import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/core/resources/colors_manager.dart';
import 'package:news/data/apis/api_service.dart';
import 'package:news/data/apis/articlesResponse/Article.dart';
import 'package:news/data/apis/sources_response/Source.dart';
import 'package:news/data/data_sources/articles_api_datasource_impl.dart';
import 'package:news/data/data_sources/sources_api_data_source_impl.dart';
import 'package:news/data/repositories/articles_repo_impl.dart';
import 'package:news/data/repositories/sources_repo_impl.dart';
import 'package:news/di/di.dart';
import 'package:news/features/home/views/sources_view/article_item.dart';
import 'package:news/features/home/views/sources_view/articles_viewModel.dart';
import 'package:news/features/home/views/sources_view/sources_viewmodel.dart';
import 'package:news/models/category_model.dart';
import 'package:provider/provider.dart';

class SourcesView extends StatefulWidget {
  SourcesView({super.key, required this.category});

  CategoryModel category;

  @override
  State<SourcesView> createState() => _SourcesViewState();
}

class _SourcesViewState extends State<SourcesView> {
  late SourcesViewModel sourcesViewModel;
  late ArticlesViewModel articlesViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    sourcesViewModel = serviceLocator.get<SourcesViewModel>();
    articlesViewModel = serviceLocator.get<ArticlesViewModel>();
    await sourcesViewModel.loadSources(widget.category);
    articlesViewModel.loadArticles(
      (sourcesViewModel.state as SourcesSuccess).sources[0],
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
                  return Center(child: CircularProgressIndicator());
                case SourcesSuccess():
                  List<Source> sources = state.sources;
                  return DefaultTabController(
                    length: sources.length,
                    child: TabBar(
                      onTap: (index) {
                        articlesViewModel.loadArticles(sources[index]);
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
            builder: (_, viewModel, _) {
              var state = viewModel.state;

              switch (state) {
                case ArticlesLoading():
                  {
                    return Center(child: CircularProgressIndicator());
                  }
                case ArticlesError():
                  {
                    return Center(child: Text(state.message));
                  }
                case ArticlesSuccess():
                  {
                    List<Article> articles = state.articles;
                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) =>
                            ArticleItem(article: articles[index]),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16.h),
                        itemCount: articles.length,
                      ),
                    );
                  }
                case ArticlesInitial():
                  return Container();
                case null:
                  return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
