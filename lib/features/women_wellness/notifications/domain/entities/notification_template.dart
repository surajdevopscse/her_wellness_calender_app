class NotificationTemplate {
  const NotificationTemplate({
    required this.id,
    required this.type,
    required this.privateTitle,
    required this.privateBody,
    required this.visibleTitle,
    required this.visibleBody,
  });

  final String id;
  final String type;
  final String privateTitle;
  final String privateBody;
  final String visibleTitle;
  final String visibleBody;
}
