import 'package:flutter/material.dart';
import 'package:news/apis/api_service.dart';
import 'package:news/apis/articlesResponse/Article.dart';
import 'package:news/apis/articlesResponse/ArticlesResponse.dart';
import 'package:news/core/resources/colors_manager.dart';
import 'package:news/features/home/views/sources_view/article_item.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = 'search';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  List<Article> articles = [];
  bool isLoading = false;
  bool isMoreLoading = false;
  int currentPage = 1;
  int totalResults = 0;
  String query = "";

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (articles.length < totalResults && !isMoreLoading) {
          _loadMore();
        }
      }
    });
  }

  void _search() async {
    query = _searchController.text;
    if (query.isEmpty) return;

    setState(() {
      isLoading = true;
      articles = [];
      currentPage = 1;
    });

    try {
      ArticlesResponse response = await APIService.searchArticles(query, page: currentPage);
      setState(() {
        articles = response.articles ?? [];
        totalResults = response.totalResults ?? 0;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error
    }
  }

  void _loadMore() async {
    setState(() {
      isMoreLoading = true;
    });
    currentPage++;
    try {
      ArticlesResponse response = await APIService.searchArticles(query, page: currentPage);
      setState(() {
        articles.addAll(response.articles ?? []);
        isMoreLoading = false;
      });
    } catch (e) {
      setState(() {
        isMoreLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onSubmitted: (value) => _search(),
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search Articles...',
            hintStyle: const TextStyle(color: Colors.white70),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: _search,
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: articles.isEmpty
                      ? const Center(child: Text('No articles found', style: TextStyle(color: Colors.white),))
                      : ListView.separated(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, index) => ArticleItem(article: articles[index]),
                          separatorBuilder: (context, index) => const SizedBox(height: 16),
                          itemCount: articles.length,
                        ),
                ),
                if (isMoreLoading)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )
              ],
            ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
