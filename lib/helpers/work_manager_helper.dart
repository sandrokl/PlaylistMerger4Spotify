// ignore_for_file: constant_identifier_names

import 'package:playlistmerger4spotify/helpers/merging_helper.dart';
import 'package:playlistmerger4spotify/models/notification_info.dart';

class WorkManagerHelper {
  static const TAG_DO_MERGING_NOW = "doMergingNow";
  static const TAG_DO_MERGING_SCHEDULED = "doMergingScheculed";

  static const TASK_DO_MERGING_NOW_ALL = "mergeNowAll";
  static const TASK_DO_MERGING_NOW_SPECIFIC = "mergeNowSpecific";
  static const TASK_DO_MERGING_SCHEDULED_ALL = "mergeScheduledAll";

  static Future<bool> handleTaskRequest(String task, Map<String, dynamic>? inputData) async {
    try {
      if (task == TASK_DO_MERGING_NOW_ALL) {
        final String notificationChannelId = inputData?["notificationChannelId"];
        final String notificationChannelName = inputData?["notificationChannelName"];
        final String successTitle = inputData?["successTitle"];
        final String successMessage = inputData?["successMessage"];
        final String failureTitle = inputData?["failureTitle"];
        final String failureMessage = inputData?["failureMessage"];

        await MergingHelper().updateAllMergedPlaylists(
          showNotification: true,
          notificationInfo: NotificationInfo(
              notificationChannelId: notificationChannelId,
              notificationChannelName: notificationChannelName,
              successTitle: successTitle,
              successMessage: successMessage,
              failureTitle: failureTitle,
              failureMessage: failureMessage),
        );
      } else if (task == TASK_DO_MERGING_NOW_SPECIFIC) {
        final String playlistId = inputData?["playlistId"];
        final String notificationChannelId = inputData?["notificationChannelId"];
        final String notificationChannelName = inputData?["notificationChannelName"];
        final String successTitle = inputData?["successTitle"];
        final String successMessage = inputData?["successMessage"];
        final String failureTitle = inputData?["failureTitle"];
        final String failureMessage = inputData?["failureMessage"];

        await MergingHelper().updateSpecificMergedPlaylist(
          playlistId,
          showNotification: true,
          notificationInfo: NotificationInfo(
              notificationChannelId: notificationChannelId,
              notificationChannelName: notificationChannelName,
              successTitle: successTitle,
              successMessage: successMessage,
              failureTitle: failureTitle,
              failureMessage: failureMessage),
        );
      }

      return Future.value(true);
    } catch (_) {
      return Future.error("Failed");
    }
  }
}
