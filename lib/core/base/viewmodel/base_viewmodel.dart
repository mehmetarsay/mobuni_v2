import 'package:flutter/material.dart';

enum _ViewState { busy, idle }

abstract class CustomBaseViewModel extends ChangeNotifier {
  final BuildContext _context;

  BuildContext get context => _context;

  _ViewState _viewState = _ViewState.idle;

  _ViewState get viewState => _viewState;

  set viewState(_ViewState value) {
    _viewState = value;
    notifyListeners();
  }

  void get setBusy => viewState = _ViewState.busy;
  void get setIdle => viewState = _ViewState.idle;

  bool get isBusy => viewState == _ViewState.busy;
  bool get isIdle => viewState == _ViewState.idle;

  CustomBaseViewModel(this._context);

  void initialize() {}
}
