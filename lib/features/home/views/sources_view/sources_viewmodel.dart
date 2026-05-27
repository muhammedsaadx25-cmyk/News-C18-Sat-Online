import 'package:news/base_view_model.dart';
import 'package:news/data/apis/result.dart';
import 'package:news/data/apis/sources_response/source.dart';
import 'package:news/data/repositories/sources_repository.dart';
import 'package:news/models/category_model.dart';

class SourcesViewModel extends BaseViewModell<SourcesState> {

SourcesRepository sourcesRepository;
SourcesViewModel({required this.sourcesRepository});


  Future<void> loadSources(CategoryModel category)async{
    emit(SourcesLoading());
    var result = await sourcesRepository.getSources(category);

    switch(result){
      case Success():{
       emit(SourcesSuccess(sources: result.data));
      }
      case ServerError():{
      emit(SourcesError(message: result.message));
      }
      case Error():{
       emit(SourcesError(message: result.message));

      }
    }
  }
}


sealed class SourcesState{}

class SourcesInitial extends SourcesState{}
class SourcesLoading extends SourcesState{}
class SourcesSuccess extends SourcesState{
  List<Source> sources;
  SourcesSuccess({required this.sources});
}
class SourcesError extends SourcesState {
  String message;

  SourcesError({required this.message});
}