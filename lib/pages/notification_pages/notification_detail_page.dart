import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/api_services/notification_api.dart';
import '../../utils/custom_page_route.dart';
import '../main_pages/page_navigation.dart';
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
    // Parse createdDate string into a DateTime object
    DateTime parsedDate = DateTime.parse(widget.notification.createdDate);

    // Format createdDate to desired format
    String formattedDate = DateFormat('dd/MM/yyyy | HH:mm').format(parsedDate);
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
            // Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              SlideRightPageRoute(
                builder: (context) => PageNavigation(initialPageIndex: 1),
              ),
              (route) => false,
            );
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
            const SizedBox(height: 10),
            // Create Date
            Text(
              formattedDate,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
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
          ],
        ),
      ),
    );
  }
}
