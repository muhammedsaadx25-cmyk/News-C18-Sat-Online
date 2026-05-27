import 'package:news/base_view_model.dart';
import 'package:news/data/apis/articlesResponse/article.dart';
import 'package:news/data/apis/result.dart';
import 'package:news/data/repositories/articles_repository.dart';

class ArticlesViewModel extends BaseViewModell<ArticlesState> {
  ArticlesRepository articlesRepository;
  ArticlesViewModel({required this.articlesRepository});

  int _currentPage = 1;
  bool _isFetchingMore = false;
  List<Article> _articles = [];
  String? _currentSourceId;
  String? _currentSearchKey;
  bool _hasReachedMax = false;

  Future<void> loadArticles({String? sourceId, String? searchKey}) async {
    _currentPage = 1;
    _articles = [];
    _hasReachedMax = false;
    _currentSourceId = sourceId;
    _currentSearchKey = searchKey;
    
    emit(ArticlesLoading());
    var result = await articlesRepository.getArticles(
      sourceId: sourceId,
      searchKey: searchKey,
      page: _currentPage,
    );
    
    switch (result) {
      case Success():
        _articles = result.data;
        _hasReachedMax = result.data.isEmpty;
        emit(ArticlesSuccess(articles: _articles, hasReachedMax: _hasReachedMax));
      case ServerError():
        emit(ArticlesError(message: result.message));
      case Error():
        emit(ArticlesError(message: result.message));
    }
  }

  Future<void> loadMoreArticles() async {
    if (_isFetchingMore || _hasReachedMax || state is! ArticlesSuccess) return;

    _isFetchingMore = true;
    _currentPage++;
    
    emit(ArticlesSuccess(articles: _articles, hasReachedMax: _hasReachedMax, isFetchingMore: true));

    var result = await articlesRepository.getArticles(
      sourceId: _currentSourceId,
      searchKey: _currentSearchKey,
      page: _currentPage,
    );

    switch (result) {
      case Success():
        List<Article> newArticles = result.data;
        if (newArticles.isEmpty) {
          _hasReachedMax = true;
        } else {
          _articles.addAll(newArticles);
        }
        _isFetchingMore = false;
        emit(ArticlesSuccess(articles: _articles, hasReachedMax: _hasReachedMax, isFetchingMore: false));
      case ServerError():
        _isFetchingMore = false;
        _currentPage--;
        emit(ArticlesSuccess(articles: _articles, hasReachedMax: _hasReachedMax, isFetchingMore: false));
      case Error():
        _isFetchingMore = false;
        _currentPage--;
        emit(ArticlesSuccess(articles: _articles, hasReachedMax: _hasReachedMax, isFetchingMore: false));
    }
  }
}

sealed class ArticlesState {}

class ArticlesInitial extends ArticlesState {}

class ArticlesSuccess extends ArticlesState {
  List<Article> articles;
  bool hasReachedMax;
  bool isFetchingMore;

  ArticlesSuccess({
    required this.articles,
    this.hasReachedMax = false,
    this.isFetchingMore = false,
  });
}

class ArticlesLoading extends ArticlesState {}

class ArticlesError extends ArticlesState {
  String message;

  ArticlesError({required this.message});
}
