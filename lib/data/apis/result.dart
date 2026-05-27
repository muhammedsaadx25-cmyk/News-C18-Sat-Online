
sealed class Result<T>{

}
class Success<T> extends Result<T>{
  T data;
  Success({required this.data});

}
class ServerError<T> extends Result<T>{
  String code;
  String message;
  ServerError({required this.code, required this.message});
}
class Error<T> extends Result<T> implements Exception{
  String message;
  Error({required this.message});
}
