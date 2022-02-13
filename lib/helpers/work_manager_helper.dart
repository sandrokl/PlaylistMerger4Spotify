// ignore_for_file: constant_identifier_names

import 'package:playlistmerger4spotify/helpers/merging_helper.dart';
import 'package:playlistmerger4spotify/helpers/notifications_helper.dart';

class WorkManagerHelper {
  WorkManagerHelper._internal();
  static final WorkManagerHelper _instance = WorkManagerHelper._internal();
  factory WorkManagerHelper() => _instance;

  static const TAG_DO_MERGING_NOW = "doMergingNow";
  static const TAG_DO_MERGING_SCHEDULED = "doMergingScheculed";

  static const TASK_DO_MERGING_NOW_ALL = "mergeNowAll";
  static const TASK_DO_MERGING_NOW_SPECIFIC = "mergeNowSpecific";
  static const TASK_DO_MERGING_SCHEDULED_ALL = "mergeScheduledAll";

  Future<bool> handleTaskRequest(String task, Map<String, dynamic>? inputData) async {
    final String notificationChannelId = inputData?["notificationChannelId"];
    final String notificationChannelName = inputData?["notificationChannelName"];
    final String successTitle = inputData?["successTitle"];
    final String successMessage = inputData?["successMessage"];
    final String failureTitle = inputData?["failureTitle"];
    final String failureMessage = inputData?["failureMessage"];

    if (task == TASK_DO_MERGING_NOW_ALL) {
      try {
        await MergingHelper().updateAllMergedPlaylists();
        await NotificationsHelper().showNotification(
          notificationChannelId,
          notificationChannelName,
          successTitle,
          successMessage,
        );
      } catch (_) {
        await NotificationsHelper().showNotification(
          notificationChannelId,
          notificationChannelName,
          failureTitle,
          failureMessage,
        );
        return Future.error("Failed");
      }
    } else if (task == TASK_DO_MERGING_NOW_SPECIFIC) {
      final String playlistId = inputData?["playlistId"];
      try {
        await MergingHelper().updateSpecificMergedPlaylist(playlistId);
        await NotificationsHelper().showNotification(
          notificationChannelId,
          notificationChannelName,
          successTitle,
          successMessage,
        );
      } catch (_) {
        await NotificationsHelper().showNotification(
          notificationChannelId,
          notificationChannelName,
          failureTitle,
          failureMessage,
        );
        return Future.error("Failed");
      }
    }
    return Future.value(true);
  }
}
