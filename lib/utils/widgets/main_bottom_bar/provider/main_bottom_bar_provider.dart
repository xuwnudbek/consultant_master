import 'package:flutter/material.dart';

class MainBottomBarProvider extends ChangeNotifier{
    int itemSelect = 0;
    
    void onPressed(value){
      itemSelect = value;
      notifyListeners();
    }
}