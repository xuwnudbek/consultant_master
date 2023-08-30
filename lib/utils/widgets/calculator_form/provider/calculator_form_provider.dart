import 'package:flutter/material.dart';

class CalculatorFormProvider extends ChangeNotifier {
  late TextEditingController totalPriceController;
  var initPriceController = TextEditingController();

  Map<int, dynamic> instalmentTable = {};
  bool isCalculating = false;

  int price;

  CalculatorFormProvider(this.price) {
    totalPriceController = TextEditingController(
      text: price.truncate().toString(),
    );

    initPriceController.addListener(() {
      onCalculate();
      print("initPriceController");
    });
    totalPriceController.addListener(() {
      onCalculate();
      print("totalPriceController");
    });

    onCalculate();
  }

  onCalculate() async {
    isCalculating = true;
    notifyListeners();

    int productPrice = int.tryParse(totalPriceController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    int initPrice = int.tryParse(initPriceController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

    int increasedPrice = (productPrice - initPrice) > 0 ? productPrice - initPrice : 0;

    for (var i = 3; i < 13; i++) {
      var data = {
        "summ": increasedPrice,
        "per_month": increasedPrice ~/ i,
      };

      instalmentTable.addAll({i: data});
    }

    isCalculating = false;
    notifyListeners();
  }

  void clear() {
    initPriceController.clear();
    notifyListeners();
  }
}
