import 'dart:convert';

import 'package:capstone_ptp/services/local_variables.dart';

import '../../pages/notification_pages/notification_model.dart';
import '../shared_preferences.dart';
import 'api_services.dart';
import 'package:http/http.dart' as http;

class NotificationApi extends ApiService {
  // Create notification
  static Future<bool> createNotification({
    required String title,
    required String content,
    String? imageURL,
    required int source,
  }) async {
    final Uri apiUrl = Uri.parse('${ApiService.baseUrl}/notifications');
    final List<Map<String, dynamic>> body = [
      {
        "title": title,
        "content": content,
        "imageURL": imageURL,
        "source": source,
        "isSeen": false
      }
    ];
    String? savedToken = await SharedRef.getToken();

    final response = await http.post(
      apiUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $savedToken',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      // updated status code
      print('Notification created successfully');
      return true;
    } else {
      print('Failed to create notification: ${response.statusCode}');
      throw Exception('Failed to create notification: ${response.statusCode}');
    }
  }

  // Fetch notifications
  static Future<List<NotificationItem>> getNotifications() async {
    final Uri apiUrl = Uri.parse('${ApiService.baseUrl}/users/notifications');

    final response = await http.get(
      apiUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalVariables.jwtToken}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<NotificationItem> notifications = jsonResponse.map((item) {
        return NotificationItem(
          id: item['id'],
          title: item['title'],
          content: item['content'],
          isSeen: item['isSeen'],
          imageURL: item['imageURL'],
          source: item['source'],
          createdDate: '2024-03-26 00:06:05.9327006',
        );
      }).toList();
      return notifications;
    } else {
      print('Failed to fetch notifications: ${response.statusCode}');
      throw Exception('Failed to fetch notifications: ${response.statusCode}');
    }
  }

  // Update notification
  static Future<void> updateNotification(NotificationItem notification) async {
    final Uri apiUrl = Uri.parse('${ApiService.baseUrl}/notifications');
    final Map<String, dynamic> body = {
      "id": notification.id,
      "title": notification.title,
      "isSeen": true,
      "content": notification.content,
      "imageURL": notification.imageURL ?? "",
      "source": notification.source
    };

    final response = await http.put(
      apiUrl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalVariables.jwtToken}',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 204) {
      print('Notification updated successfully');
    } else {
      print('Failed to update notification: ${response.statusCode}');
      throw Exception('Failed to update notification: ${response.statusCode}');
    }
  }
}
