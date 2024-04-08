import 'dart:convert';

import 'package:capstone_ptp/services/local_variables.dart';
import 'package:capstone_ptp/pages/main_pages/notification_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';
import 'api_services/notification_api.dart';

class FirebaseMessageService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );
  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState?.pushNamed(
      NotificationPage.route,
      arguments: message,
    );
    // Call your API to create a notification
    _createNotificationFromMessage(message);
  }

  void handleForegroundMessage(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    // Show local notification when the app is in the foreground
    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          icon: '@drawable/ic_launcher',
        ),
      ),
      payload: jsonEncode(message.toMap()),
    );
    // Call your API to create a notification
    _createNotificationFromMessage(message);
  }

  Future initLocalNotifications() async {
    // const iOS = IOSInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _localNotifications.initialize(
      settings,
      onSelectNotification: (payload) {
        final message =
            RemoteMessage.fromMap(jsonEncode(payload!) as Map<String, dynamic>);
        handleMessage(message);
      },
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    // Handle message when the app is in the foreground
    FirebaseMessaging.onMessage.listen((message) {
      print("HELP: $message");
      handleForegroundMessage(message);
    });
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print("FCM Token: ${fcmToken} ");
    LocalVariables.fcmToken = fcmToken;
    initPushNotifications();
    initLocalNotifications();
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Title: ${message.notification?.title} ");
  print("Body: ${message.notification?.body} ");
  print("Payload: ${message.data} ");
  // Call your API to create a notification
  _createNotificationFromMessage(message);
}

Future<void> _createNotificationFromMessage(RemoteMessage message) async {
  try {
    // Extract necessary information from the FCM message
    final notification = message.notification;
    if (notification == null) return;

    // Create a notification using the API
    await NotificationApi.createNotification(
      title: notification.title ?? "",
      content: notification.body ?? "",
      imageURL: "",
      source: 1,
    );

    print('Notification created successfully from FCM message');
  } catch (e) {
    print('Failed to create notification from FCM message: $e');
  }
}
