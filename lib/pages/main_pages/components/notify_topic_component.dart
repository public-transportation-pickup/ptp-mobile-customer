import 'package:capstone_ptp/services/local_variables.dart';
import 'package:flutter/material.dart';

class NotificationItem {
  final String image;
  final String title;
  final String subTitle;

  NotificationItem(
      {required this.image, required this.title, required this.subTitle});
}

class NotifyTopicComponent extends StatelessWidget {
  final List<NotificationItem> notificationList;

  NotifyTopicComponent()
      : notificationList = [
          NotificationItem(
            image: LocalVariables.photoURL ?? '',
            title: 'Title 1',
            subTitle: 'Subtitle 1',
          ),
          NotificationItem(
            image: LocalVariables.photoURL ?? '',
            title: 'Title 2',
            subTitle: 'Subtitle 2',
          ),
          NotificationItem(
            image: LocalVariables.photoURL ?? '',
            title: 'Title 3',
            subTitle: 'Subtitle 3',
          ),
        ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: notificationList.length,
      itemBuilder: (context, index) {
        return _buildNotificationItem(notificationList[index]);
      },
    );
  }

  Widget _buildNotificationItem(NotificationItem item) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              item.image,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.title,
            style: const TextStyle(
              color: Color(0xFF353434),
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.subTitle,
            style: const TextStyle(
              color: Color(0xFF353434),
              fontSize: 14,
              fontFamily: 'Montserrat',
              //fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}
