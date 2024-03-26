import 'package:flutter/material.dart';

import '../notification_pages/notification_detail_page.dart';
import '../notification_pages/notification_model.dart';

class NotificationPage extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: "Đơn hàng của bạn đã sẵn sàng",
      imageURL: '',
      content:
          "Đơn hàng tại cửa hàng Trà sữa APA - Lê Văn Việt, nếu quá hạn đơn bạn sẽ bị hủy.",
      createdDate: '2024-03-23 00:06:05.9327006',
      isRead: false,
    ),
    NotificationItem(
      title: "Đơn hàng của bạn đã được xác nhận",
      imageURL: '',
      content:
          "Cửa hàng Trà sữa APA - Lê Văn Việt đã nhận được yêu cầu đơn hàng của bạn.",
      createdDate: '2024-03-26 14:06:05.9327006',
      isRead: true,
    ),
    NotificationItem(
      title: "Thông báo bảo trì app ngày 31/2",
      imageURL: '',
      content:
          "PTP xin thông báo bảo trì app từ lúc 20h00 ngày 31/2 đến 4h00 ngày 32/2.",
      createdDate: '2024-03-20 12:06:05.9327006',
      isRead: false,
    ),
    // Add more notifications as needed
  ];

  @override
  Widget build(BuildContext context) {
    // Sort the notifications by their creation date
    notifications.sort((a, b) =>
        DateTime.parse(b.createdDate).compareTo(DateTime.parse(a.createdDate)));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCCF59),
        title: const Text(
          'Thông báo',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationDetailPage(
                            notification: notifications[index]),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: notifications[index].isRead
                        ? const Icon(Icons.circle, color: Colors.grey)
                        : const Icon(Icons.circle, color: Colors.red),
                    title: Text(
                      notifications[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    subtitle: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notifications[index].content.length > 60
                                    ? '${notifications[index].content.substring(0, 60)}...'
                                    : notifications[index].content,
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationDetailPage(
                                    notification: notifications[index]),
                              ),
                            );
                          },
                          child: const Text(
                            'Chi tiết >',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Color(0xFFFCCF59),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 2,
                  color: Colors.black12,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
