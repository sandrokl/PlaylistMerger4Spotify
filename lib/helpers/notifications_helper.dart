// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsHelper {
  static const CHANNEL_KEY_MERGING_RESULTS = "merging_results";

  static late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  static Future<void> initialize() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
      'res_ic_notif',
    );
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static int _generateId() {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  static NotificationDetails _createPlatformNotificationsDetails(String channelId, String channelName) {
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

  static Future<void> showNotification(String channelId, String channelName, String title, String message) async {
    await initialize();
    final platformNotificationsDetails = _createPlatformNotificationsDetails(channelId, channelName);
    await _flutterLocalNotificationsPlugin.show(_generateId(), title, message, platformNotificationsDetails,
        payload: null);
  }
}
