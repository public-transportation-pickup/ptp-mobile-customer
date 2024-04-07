import 'package:flutter/material.dart';
import '../../services/api_services/notification_api.dart';
import '../notification_pages/notification_model.dart';

class NotificationDetailPage extends StatefulWidget {
  final NotificationItem notification;
  final VoidCallback reloadCallback;

  NotificationDetailPage(
      {required this.notification, required this.reloadCallback, Key? key})
      : super(key: key);

  @override
  _NotificationDetailPageState createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  void _updateNotification() async {
    if (widget.notification.isSeen == false) {
      await NotificationApi.updateNotification(widget.notification);
    }
  }

  @override
  void initState() {
    super.initState();
    _updateNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chi tiết thông báo',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFCCF59),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            widget.reloadCallback();
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'lib/assets/images/default_food.png',
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            // Title
            Text(
              widget.notification.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            // Content
            Text(
              widget.notification.content,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            // Create Date
            Text(
              'Created on: ${widget.notification.createdDate}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
