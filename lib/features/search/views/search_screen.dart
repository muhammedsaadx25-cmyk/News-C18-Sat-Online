import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/core/resources/colors_manager.dart';
import 'package:news/data/apis/api_service.dart';
import 'package:news/data/data_sources/articles_api_datasource_impl.dart';
import 'package:news/data/repositories/articles_repo_impl.dart';
import 'package:news/features/home/views/sources_view/article_shimmer_item.dart';
import 'package:news/features/home/views/sources_view/articles_view_model.dart';
import 'package:news/features/search/views/widgets/search_results_list.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late ArticlesViewModel _articlesViewModel;
  String _currentQuery = '';

  @override
  void initState() {
    super.initState();
    _articlesViewModel = ArticlesViewModel(
      articlesRepository: ArticlesRepositoryImpl(
        articlesDataSource: ArticlesApiDataSourceImpl(apiService: APIService()),
      ),
    );
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _articlesViewModel.loadMoreArticles();
    }
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty && query != _currentQuery) {
      _currentQuery = query;
      _articlesViewModel.loadArticles(searchKey: query);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _articlesViewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Search',
            style: GoogleFonts.inter(
              color: ColorsManager.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: ColorsManager.black,
          iconTheme: const IconThemeData(color: ColorsManager.white),
          elevation: 0,
        ),
        body: Column(
          children: [
            Padding(
              padding: REdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: ColorsManager.white, width: 1),
                ),
                child: TextField(
                  controller: _searchController,
                  style: GoogleFonts.inter(color: ColorsManager.white),
                  onSubmitted: (_) => _performSearch(),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: GoogleFonts.inter(color: ColorsManager.white.withOpacity(0.6)),
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
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _currentQuery = '';
                          _articlesViewModel.loadArticles(searchKey: '');
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<ArticlesViewModel>(
                builder: (context, viewModel, _) {
                  final state = viewModel.state;
                  
                  if (state is ArticlesInitial) {
                    return Center(
                      child: Text(
                        'Type a keyword to search',
                        style: GoogleFonts.inter(color: ColorsManager.grey, fontSize: 16.sp),
                      ),
                    );
                  } else if (state is ArticlesLoading) {
                    return const Column(
                      children: [
                        ArticlesShimmerList(),
                      ],
                    );
                  } else if (state is ArticlesError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: GoogleFonts.inter(color: ColorsManager.white),
                      ),
                    );
                  } else if (state is ArticlesSuccess) {
                    return SearchResultsList(
                      articles: state.articles,
                      scrollController: _scrollController,
                      isFetchingMore: state.isFetchingMore,
                    );
                  }
                  
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
