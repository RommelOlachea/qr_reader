import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 1;

  int get selectMenuOpt {
    return this._selectedMenuOpt;
  }

  set selectMenuOpt(int i) {
    this._selectedMenuOpt = i;
    notifyListeners();
  }
}
