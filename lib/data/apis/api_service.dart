import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:news/data/apis/articlesResponse/article.dart';
import 'package:news/data/apis/articlesResponse/articles_response.dart';
import 'package:news/data/apis/result.dart';
import 'package:news/data/apis/sources_response/source.dart';
import 'package:news/data/apis/sources_response/sources_response.dart';
import 'package:news/models/category_model.dart';

class APIService {
  static const String baseUrl = "newsapi.org";
  static const String apiKey = "4fd9021797f4477896b95a1830566396";
  static const String sourcesEndPoint = "/v2/top-headlines/sources";
  static const String articlesEndPoint = "/v2/everything";

  Future<Result<List<Source>>> getSources(CategoryModel category) async {
    try {
      Uri url = Uri.https(baseUrl, sourcesEndPoint, {
        'apiKey': apiKey,
        'category': category.id,
      });
      http.Response serverResponse = await http.get(url);
      var json = jsonDecode(serverResponse.body);
      SourcesResponse sourcesResponse = SourcesResponse.fromJson(json);
      if (sourcesResponse.status == 'error') {
        return ServerError(
          code: sourcesResponse.code ?? " ",
          message: sourcesResponse.message ?? "Failed To Get Sources",
        );
      } else {
        return Success(data: sourcesResponse.sources ?? []);
      }
    } catch (exception) {
      if (exception is SocketException) {
        return Error(message: "No Internet connection 😑");
      }
      if (exception is HttpException) {
        return Error(message: "Couldn't find the post 😱");
      }
      if (exception is FormatException) {
        return Error(message: "Bad response format 👎");
      }
      return Error(message: exception.toString());
    }
  }

  Future<Result<List<Article>>> getArticles({
    String? sourceId,
    String? searchKey,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {
        'apiKey': apiKey,
        'page': page.toString(),
        'pageSize': pageSize.toString(),
      };
      if (sourceId != null && sourceId.isNotEmpty) {
        queryParameters['sources'] = sourceId;
      }
      if (searchKey != null && searchKey.isNotEmpty) {
        queryParameters['q'] = searchKey;
      }
      Uri url = Uri.https(baseUrl, articlesEndPoint, queryParameters);
      http.Response serverResponse = await http.get(url);
      var json = jsonDecode(serverResponse.body);
      ArticlesResponse articlesResponse = ArticlesResponse.fromJson(json);
      if (articlesResponse.status == 'error') {
        return ServerError(
          code: articlesResponse.code ?? "",
          message: articlesResponse.message ?? "Failed To Get Articles",
        );
      } else {
        return Success(data: articlesResponse.articles ?? []);
      }
    } catch (exception) {
      if (exception is SocketException) {
        return Error(message: "No Internet connection 😑");
      }
      if (exception is HttpException) {
        return Error(message: "Couldn't find the post 😱");
      }
      if (exception is FormatException) {
        return Error(message: "Bad response format 👎");
      }
      return Error(message: exception.toString());
    }
  }
}
