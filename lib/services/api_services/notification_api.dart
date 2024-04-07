import 'dart:convert';

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
}
