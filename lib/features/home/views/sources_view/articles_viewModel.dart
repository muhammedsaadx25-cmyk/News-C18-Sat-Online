import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:news/base_viewModel.dart';
import 'package:news/data/apis/api_service.dart';
import 'package:news/data/apis/articlesResponse/Article.dart';
import 'package:news/data/apis/result.dart';
import 'package:news/data/apis/sources_response/Source.dart';
import 'package:news/data/repositories/articles_repository.dart';
@injectable
class ArticlesViewModel extends BaseViewMode<ArticlesState> {
ArticlesRepository articlesRepository;
ArticlesViewModel({required this.articlesRepository});



  Future<void> loadArticles(Source source, [String? searchKey]) async {
    emit(ArticlesLoading());
    var result = await articlesRepository.getArticles(source);
    switch (result) {
      case Success():
        {
          emit(ArticlesSuccess(articles: result.data));
        }
      case ServerError():
        {
          emit(ArticlesError(message: result.message));
        }
      case Error():
        {
          emit(ArticlesError(message: result.message));
        }
    }
  }
}

sealed class ArticlesState {}

class ArticlesInitial extends ArticlesState {}

class ArticlesSuccess extends ArticlesState {
  List<Article> articles;

  ArticlesSuccess({required this.articles});
}

class ArticlesLoading extends ArticlesState {}

class ArticlesError extends ArticlesState {
  String message;

  ArticlesError({required this.message});
}
