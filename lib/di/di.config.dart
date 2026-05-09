// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:news/data/apis/api_service.dart' as _i771;
import 'package:news/data/data_sources/articles_api_datasource_impl.dart'
    as _i390;
import 'package:news/data/data_sources/articles_data_source.dart' as _i450;
import 'package:news/data/data_sources/sources_api_data_source_impl.dart'
    as _i1066;
import 'package:news/data/data_sources/sources_data_source.dart' as _i672;
import 'package:news/data/repositories/articles_repo_impl.dart' as _i886;
import 'package:news/data/repositories/articles_repository.dart' as _i351;
import 'package:news/data/repositories/sources_repo_impl.dart' as _i522;
import 'package:news/data/repositories/sources_repository.dart' as _i1033;
import 'package:news/features/home/views/sources_view/articles_viewModel.dart'
    as _i286;
import 'package:news/features/home/views/sources_view/sources_viewmodel.dart'
    as _i520;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i771.APIService>(() => _i771.APIService());
    gh.singleton<_i450.ArticlesDataSource>(
      () => _i390.ArticlesApiDataSourceImpl(apiService: gh<_i771.APIService>()),
    );
    gh.singleton<_i672.SourcesDataSource>(
      () => _i1066.SourcesApiDataSourceImpl(apiService: gh<_i771.APIService>()),
    );
    gh.singleton<_i351.ArticlesRepository>(
      () => _i886.ArticlesRepositoryImpl(
        articlesDataSource: gh<_i450.ArticlesDataSource>(),
      ),
    );
    gh.factory<_i286.ArticlesViewModel>(
      () => _i286.ArticlesViewModel(
        articlesRepository: gh<_i351.ArticlesRepository>(),
      ),
    );
    gh.singleton<_i1033.SourcesRepository>(
      () => _i522.SourcesRepositoryImpl(
        sourcesDataSource: gh<_i672.SourcesDataSource>(),
      ),
    );
    gh.factory<_i520.SourcesViewModel>(
      () => _i520.SourcesViewModel(
        sourcesRepository: gh<_i1033.SourcesRepository>(),
      ),
    );
    return this;
  }
}
