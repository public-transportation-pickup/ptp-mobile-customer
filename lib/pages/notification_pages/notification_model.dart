class NotificationItem {
  final String title;
  final String imageURL;
  final String content;
  final String createdDate;
  final bool isRead;

  NotificationItem({
    required this.title,
    required this.content,
    required this.imageURL,
    required this.createdDate,
    required this.isRead,
  });
}
