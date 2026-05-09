import 'package:flutter/cupertino.dart';

class BaseViewModell<T> extends ChangeNotifier{
  T? state;
  void emit(T newState){
    state = newState;
    notifyListeners();
  }
}