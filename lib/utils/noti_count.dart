import 'package:flutter/material.dart';

import '../services/shared_preferences.dart';

class NotificationCountNotifier extends ChangeNotifier {
  int _notificationCount = 0;

  int get notificationCount => _notificationCount;

  Future<void> getAndSetNotificationCount() async {
    int count = await SharedRef.getNotificationCount();
    setNotificationCount(count);
  }

  void setNotificationCount(int count) {
    _notificationCount = count;
    notifyListeners();
  }
}
