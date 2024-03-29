// ignore_for_file: constant_identifier_names

import 'package:playlistmerger4spotify/helpers/merging_helper.dart';
import 'package:playlistmerger4spotify/helpers/notifications_helper.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerHelper {
  WorkManagerHelper._internal();
  static final WorkManagerHelper _instance = WorkManagerHelper._internal();
  factory WorkManagerHelper() => _instance;

  static const TAG_DO_MERGING_SCHEDULED = "doMergingScheculed";

  static const TASK_DO_MERGING_NOW_ALL = "mergeNowAll";
  static const TASK_DO_MERGING_NOW_SPECIFIC = "mergeNowSpecific";
  static const TASK_DO_MERGING_SCHEDULED_ALL = "mergeScheduledAll";

  Future<void> createUpdateSchedule(
    String notificationInProgressChannelId,
    String notificationInProgressChannelName,
    String notificationInProgressMessage,
  ) async {
    try {
      await Workmanager().cancelByTag(TASK_DO_MERGING_SCHEDULED_ALL);
    } catch (_) {/* nothing to cancel */}

    await Workmanager().registerPeriodicTask(
      TASK_DO_MERGING_SCHEDULED_ALL,
      TASK_DO_MERGING_SCHEDULED_ALL,
      tag: TASK_DO_MERGING_SCHEDULED_ALL,
      initialDelay: const Duration(seconds: 30),
      frequency: const Duration(hours: 2, minutes: 30),
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: true,
      ),
      inputData: {
        "notificationInProgressChannelId": notificationInProgressChannelId,
        "notificationInProgressChannelName": notificationInProgressChannelName,
        "notificationInProgressMessage": notificationInProgressMessage,
      },
    );
  }

  Future<void> deleteUpdateSchedule() async {
    try {
      await Workmanager().cancelByTag(TASK_DO_MERGING_SCHEDULED_ALL);
    } catch (_) {/* nothing to cancel */}
  }

  Future<bool> handleTaskRequest(String task, Map<String, dynamic>? inputData) async {
    NotificationsHelper().initialize(askForPermission: false);

    final String notificationInProgressChannelId = inputData?["notificationInProgressChannelId"];
    final String notificationInProgressChannelName = inputData?["notificationInProgressChannelName"];
    final String notificationInProgressMessage = inputData?["notificationInProgressMessage"];

    if (task == TASK_DO_MERGING_SCHEDULED_ALL) {
      try {
        var result = await MergingHelper().updateAllMergedPlaylists(
          notificationInProgressChannelId,
          notificationInProgressChannelName,
          notificationInProgressMessage,
          isAutomaticUpdate: true,
        );
        if (!result) {
          throw Exception("FAILED");
        }
      } catch (_) {
        return Future.error("FAILED");
      }
    } else {
      final String notificationChannelId = inputData?["notificationChannelId"];
      final String notificationChannelName = inputData?["notificationChannelName"];
      final String successTitle = inputData?["successTitle"];
      final String successMessage = inputData?["successMessage"];
      final String failureTitle = inputData?["failureTitle"];
      final String failureMessage = inputData?["failureMessage"];

      if (task == TASK_DO_MERGING_NOW_ALL) {
        try {
          var result = await MergingHelper().updateAllMergedPlaylists(
            notificationInProgressChannelId,
            notificationInProgressChannelName,
            notificationInProgressMessage,
          );
          if (!result) {
            throw Exception("FAILED");
          }
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
          return Future.error("FAILED");
        }
      } else if (task == TASK_DO_MERGING_NOW_SPECIFIC) {
        final String playlistId = inputData?["playlistId"];
        try {
          var result = await MergingHelper().updateSpecificMergedPlaylist(
            playlistId,
            notificationInProgressChannelId,
            notificationInProgressChannelName,
            notificationInProgressMessage,
          );
          if (!result) {
            throw Exception("FAILED");
          }
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
          return Future.error("FAILED");
        }
      }
    }
    return Future.value(true);
  }
}
