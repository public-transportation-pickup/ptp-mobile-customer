import 'package:flutter/material.dart';

class OrderCountNotifier extends ChangeNotifier {
  int _orderCount = 0;

  int get orderCount => _orderCount;

  void setOrderCount(int count) {
    _orderCount = count;
    notifyListeners();
  }
}
