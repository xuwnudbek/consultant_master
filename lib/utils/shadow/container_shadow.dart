import 'package:flutter/material.dart';

List<BoxShadow> shadowContainer() {
  return [
    BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: 1,
      blurRadius: 7,
      offset: Offset(0, 0),
    ),
  ];
}
