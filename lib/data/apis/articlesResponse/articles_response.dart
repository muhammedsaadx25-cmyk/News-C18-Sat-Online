import 'article.dart';

class ArticlesResponse {
  ArticlesResponse({
      this.status, 
      this.totalResults, 
      this.articles,
      this.code,
      this.message,

  });

  ArticlesResponse.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = [];
      json['articles'].forEach((v) {
        articles?.add(Article.fromJson(v));
      });
    }
  }
  String? status;
  String? code;
  String? message;
  int? totalResults;
  List<Article>? articles;


}