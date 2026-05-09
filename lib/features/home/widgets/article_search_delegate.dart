import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/apis/api_service.dart';
import 'package:news/apis/articlesResponse/Article.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../apis/sources_response/Source.dart';
import '../../../models/category_model.dart';
import '../views/sources_view/article_bottom_sheet.dart';
import '../views/sources_view/article_item.dart';

class ArticleSearchDelegate extends SearchDelegate {
  List<Article> searchedArticles = [];
  int page = 1;
  int pageSize = 10;
  final ScrollController _scrollController = ScrollController();


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            Navigator.pop(context);
          }
          query = "";
          showResults(context);
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Icon(Icons.search);
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      itemCount: searchedArticles.length,
      itemBuilder: (context, index) {
        return ArticleItem(article: searchedArticles[index], onClick: (article) async {
          showArticleBottomSheet(context: context, article: article, onViewFullArticleClick: (url) async{
            await launchUrl(Uri.parse(url));
          });
        });
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 8.h);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: _fetchArticlesSuggestions(query, page, pageSize),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        if (snapshot.hasData) {
          return ListView.separated(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ArticleItem(
                article: snapshot.data![index],
                onClick: (article) {
                  showArticleBottomSheet(
                    article: article,
                    context: context,
                    onViewFullArticleClick: (url) async {
                      await launchUrl(Uri.parse(url));
                    },
                  );
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 8.h);
            },
          );
        } else {
          return Center(child: Text("No Data"));
        }
      },
    );
  }

  Future<List<Article>> _fetchArticlesSuggestions(
    String query,
    int page,
    int pageSize,
  ) async {
    if (query.isEmpty) {
      List<Source>? sources = await APIService.getSources(
        CategoryModel.categories[1],
      );
      if (sources == null || sources.isEmpty) {
        return [];
      } else {
        List<Article>? articles = await APIService.getArticles(
          sources.first,
          "",
          1,
          5,
        );
        if (articles == null || articles.isEmpty) {
          return [];
        } else {
          return articles;
        }
      }
    } else {
      List<Article>? articles = await APIService.searchArticles(
        query,
        page,
        pageSize,
      );
      if (articles == null || articles.isEmpty) {
        return [];
      } else {
        searchedArticles = articles;
        return articles;
      }
    }
  }
}
