// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:playlistmerger4spotify/helpers/notifications_helper.dart';

class WorkManagerHelper {
  static const TAG_DO_MERGING_NOW = "doMergingNow";
  static const TAG_DO_MERGING_SCHEDULED = "doMergingScheculed";

  static const TASK_DO_MERGING_NOW_ALL = "mergeNowAll";
  static const TASK_DO_MERGING_NOW_SPECIFIC = "mergeNowSpecific";
  static const TASK_DO_MERGING_SCHEDULED_ALL = "mergeScheduledAll";

  static Future<bool> handleTaskRequest(String task, Map<String, dynamic>? inputData) async {
    try {
      if (task == TASK_DO_MERGING_NOW_ALL) {
      } else if (task == TASK_DO_MERGING_NOW_SPECIFIC) {
        final String playlistId = inputData?["playlistId"];
      }

      // TODO : use the notification below as model
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: Random().nextInt(999999),
          channelKey: NotificationsHelper.CHANNEL_KEY_MERGING_RESULTS,
          body: 'Simple body',
        ),
      );

      return Future.value(true);
    } catch (_) {
      Future.error('Failed.');
    }
  }
}
