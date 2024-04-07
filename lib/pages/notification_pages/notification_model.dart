class NotificationItem {
  final String id;
  final String title;
  final String content;
  final bool isSeen;
  final String? imageURL;
  final int source;
  final String createdDate;

  NotificationItem({
    required this.id,
    required this.title,
    required this.content,
    required this.isSeen,
    this.imageURL,
    required this.source,
    required this.createdDate,
  });
}
