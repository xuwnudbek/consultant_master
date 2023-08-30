import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int itemSelect = 0;

  void onPressed(value) {
    itemSelect = value;
    notifyListeners();
  }
}
