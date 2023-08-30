import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntRangeTextInputFormatter extends TextInputFormatter {
  IntRangeTextInputFormatter({this.min = 0, required this.max});
  final int min;
  final int max;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    int value = int.tryParse(newValue.text.replaceAll(" ", "")) ?? min;
    if (value < min) {
      value = min;
    } else if (value > max) {
      value = max;
    }
    return TextEditingValue(
      text: value.toString(),
      selection: TextSelection.collapsed(offset: value.toString().length),
    );
  }
}
