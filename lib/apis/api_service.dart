import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/apis/articlesResponse/Article.dart';
import 'package:news/apis/articlesResponse/ArticlesResponse.dart';
import 'package:news/apis/sources_response/Source.dart';
import 'package:news/apis/sources_response/SourcesResponse.dart';
import 'package:news/models/category_model.dart';

class APIService {
  static const String baseUrl = "newsapi.org";
  static const String apiKey = "69500f03ae084e309303f8fe3a277f1f";
  static const String sourcesEndPoint = "/v2/top-headlines/sources";
  static const String articlesEndPoint = "/v2/everything";

  ///
  static Future<List<Source>?> getSources(CategoryModel category) async {
    Uri url = Uri.https(baseUrl, sourcesEndPoint, {
      'apiKey': apiKey,
      'category': category.id,
    });
    http.Response serverResponse = await http.get(url);
    var json = jsonDecode(serverResponse.body);
    SourcesResponse sourcesResponse = SourcesResponse.fromJson(json);
    return sourcesResponse.sources;
  }

  static Future<List<Article>?>getArticles(Source source, [String? searchKey]) async {
    Uri url = Uri.https(baseUrl, articlesEndPoint, {
      'apiKey': apiKey,
      'sources': source.id,
      'q': searchKey,
    });
    http.Response serverResponse = await http.get(url);
    var json = jsonDecode(serverResponse.body);
    ArticlesResponse articlesResponse = ArticlesResponse.fromJson(json);
    return articlesResponse.articles;
  }
  static Future<List<Article>?> searchArticles(String searchKey) async {
    Uri url = Uri.https(baseUrl, articlesEndPoint, {
      'apiKey': apiKey,
      'q': searchKey,
    });
    http.Response serverResponse = await http.get(url);
    var json = jsonDecode(serverResponse.body);
    ArticlesResponse articlesResponse = ArticlesResponse.fromJson(json);
    return articlesResponse.articles;
  }
}
