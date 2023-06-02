// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsHelper {
  NotificationsHelper._internal();
  static final NotificationsHelper _instance = NotificationsHelper._internal();
  factory NotificationsHelper() => _instance;

  static const CHANNEL_KEY_MERGING_RESULTS = "merging_results";
  static const CHANNEL_KEY_IN_PROGRESS = "in_progress";

  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  Future<void> initialize({bool askForPermission = true}) async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    if (askForPermission) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();
    }

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
      'res_ic_notif',
    );
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  int _generateId() {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  NotificationDetails _createPlatformNotificationsDetails(String channelId, String channelName) {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      color: Colors.green,
      channelShowBadge: true,
      playSound: false,
      styleInformation: const BigTextStyleInformation('', htmlFormatTitle: true, htmlFormatContent: true),
    );
    final platformNotificationsDetails = NotificationDetails(android: androidPlatformChannelSpecifics);
    return platformNotificationsDetails;
  }

  Future<void> showNotification(String channelId, String channelName, String title, String message) async {
    final platformNotificationsDetails = _createPlatformNotificationsDetails(channelId, channelName);
    await _flutterLocalNotificationsPlugin.show(_generateId(), title, message, platformNotificationsDetails,
        payload: null);
  }

  NotificationDetails _createPlatformPersistentNotificationsDetails(String channelId, String channelName) {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.low,
      color: Colors.green,
      channelShowBadge: false,
      playSound: false,
      enableVibration: false,
      autoCancel: false,
      ongoing: true,
      styleInformation: const DefaultStyleInformation(true, true),
    );
    final platformNotificationsDetails = NotificationDetails(android: androidPlatformChannelSpecifics);
    return platformNotificationsDetails;
  }

  Future<void> showPersistentNotification(
      int notificationid, String channelId, String channelName, String message) async {
    final platformNotificationsDetails = _createPlatformPersistentNotificationsDetails(channelId, channelName);
    await _flutterLocalNotificationsPlugin.show(
      notificationid,
      null,
      message,
      platformNotificationsDetails,
    );
  }

  Future<void> dismissPersistentNotification(int notificationId) async {
    await _flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
