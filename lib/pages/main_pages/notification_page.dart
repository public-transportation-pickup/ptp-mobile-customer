import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package

import '../../services/api_services/notification_api.dart';
import '../../utils/custom_page_route.dart';
import '../../utils/noti_count.dart';
import '../notification_pages/notification_detail_page.dart';
import '../notification_pages/notification_model.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);
  static const route = '/notifications';

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCCF59),
        title: const Text(
          'Thông báo',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Consumer<NotificationCountNotifier>(
        // Wrap with Consumer
        builder: (context, notifier, _) {
          // Access the notifier
          return FutureBuilder<List<NotificationItem>>(
            future: NotificationApi.getNotifications(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<NotificationItem> notifications = snapshot.data ?? [];
                notifications.sort((a, b) => DateTime.parse(b.createdDate)
                    .compareTo(DateTime.parse(a.createdDate)));
                return notifications.isEmpty
                    ? const Center(child: Text('Không có thông báo.'))
                    : RefreshIndicator(
                        onRefresh: () async {
                          await Provider.of<NotificationCountNotifier>(context,
                                  listen: false)
                              .getAndSetNotificationCount(); // Refresh notification count
                        },
                        child: Padding(
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
                                        SlideLeftPageRoute(
                                          builder: (context) =>
                                              NotificationDetailPage(
                                            notification: notifications[index],
                                            key: UniqueKey(),
                                            reloadCallback: () {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                      leading: notifications[index].isSeen
                                          ? const Icon(Icons.circle,
                                              color: Colors.grey)
                                          : const Icon(Icons.circle,
                                              color: Colors.red),
                                      title: Text(
                                        notifications[index].title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16),
                                      subtitle: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  notifications[index]
                                                              .content
                                                              .length >
                                                          60
                                                      ? '${notifications[index].content.substring(0, 60)}...'
                                                      : notifications[index]
                                                          .content,
                                                ),
                                              ],
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                SlideLeftPageRoute(
                                                  builder: (context) =>
                                                      NotificationDetailPage(
                                                    notification:
                                                        notifications[index],
                                                    key: UniqueKey(),
                                                    reloadCallback: () {
                                                      setState(() {});
                                                    },
                                                  ),
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
            },
          );
        },
      ),
    );
  }
}
