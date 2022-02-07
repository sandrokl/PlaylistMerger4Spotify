// ignore_for_file: constant_identifier_names

class WorkManagerHelper {
  static const TAG_DO_MERGING_NOW = "doMergingNow";
  static const TAG_DO_MERGING_SCHEDULED = "doMergingScheculed";

  static const TASK_DO_MERGING_NOW_ALL = "mergeNowAll";
  static const TASK_DO_MERGING_NOW_SPECIFIC = "mergeNowSpecific";
  static const TASK_DO_MERGING_SCHEDULED_ALL = "mergeScheduledAll";

  static Future<bool> handleTaskRequest(String task, Map<String, dynamic>? inputData) async {
    if (task == TASK_DO_MERGING_NOW_ALL) {
    } else if (task == TASK_DO_MERGING_NOW_SPECIFIC) {
      final String playlistId = inputData?["playlistId"];
    }

// TODO : use the notification below as model
    // await AwesomeNotifications().createNotification(
    //   content: NotificationContent(
    //     id: Random().nextInt(999999),
    //     channelKey: NotificationsHelper.CHANNEL_KEY_MERGING_RESULTS,
    //     body: 'Simple body',
    //   ),
    // );

    return true;
  }
}
