import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:news/data/apis/articlesResponse/Article.dart';
import 'package:news/data/apis/articlesResponse/ArticlesResponse.dart';
import 'package:news/data/apis/result.dart';
import 'package:news/data/apis/sources_response/Source.dart';
import 'package:news/data/apis/sources_response/SourcesResponse.dart';
import 'package:news/models/category_model.dart';
@singleton
class APIService {
  static const String baseUrl = "newsapi.org";
  static const String apiKey = "811d8ca53d0d4ff281843e66552efcee";
  static const String sourcesEndPoint = "/v2/top-headlines/sources";
  static const String articlesEndPoint = "/v2/everything";

  ///
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
      print("Exceptionnnnn");
      if (exception is SocketException) {
        return Error(message: "No Internet connection 😑");
      }
      if (exception is HttpException) {
        return Error(message: "Couldn't find the post 😱");
      }
      if (exception is FormatException) {
        print("Ana da5alt el bad rrsponse");
        return Error(message: "Bad response format 👎");
      }
      return Error(message: exception.toString());
    }
  }

   Future<Result<List<Article>>> getArticles(
    Source source, [
    String? searchKey,
  ]) async {
    try {
      Uri url = Uri.https(baseUrl, articlesEndPoint, {
        'apiKey': apiKey,
        'sources': source.id,
        'q': searchKey,
      });
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
        print("Ana da5alt el bad rrsponse");
        return Error(message: "Bad response format 👎");
      }
      return Error(message: exception.toString());
    }
  }
}
/// Solid
