import 'package:flutter/material.dart';

import '../view_states.dart';

class BaseModel extends ChangeNotifier{
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  bool get value => _state.toString() == 'Idle' ? true : false;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}