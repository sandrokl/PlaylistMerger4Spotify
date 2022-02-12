import 'dart:core';

class NotificationInfo {
  String notificationChannelId;
  String notificationChannelName;
  String successTitle;
  String successMessage;
  String failureTitle;
  String failureMessage;

  NotificationInfo(
      {required this.notificationChannelId,
      required this.notificationChannelName,
      required this.successTitle,
      required this.successMessage,
      required this.failureTitle,
      required this.failureMessage});
}
