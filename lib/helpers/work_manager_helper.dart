// ignore_for_file: constant_identifier_names

import 'package:workmanager/workmanager.dart';

class WorkManagerHelper {
  static const TAG_DO_MERGING_NOW = "doMergingNow";
  static const TAG_DO_MERGING_SCHEDULED = "doMergingScheculed";

  static const TASK_DO_MERGING_NOW_ALL = "mergeNowAll";
  static const TASK_DO_MERGING_NOW_SPECIFIC = "mergeNowSpecific";
  static const TASK_DO_MERGING_SCHEDULED_ALL = "mergeScheduledAll";

  static Future<bool> handleTaskRequest(String task, Map<String, dynamic>? inputData) async {
    if (task == TASK_DO_MERGING_NOW_ALL) {
      await Workmanager().cancelByTag(TAG_DO_MERGING_NOW);
    } else if (task == TASK_DO_MERGING_NOW_SPECIFIC) {
      final String playlistId = inputData?["playlistId"];
      await Workmanager().cancelByTag(TAG_DO_MERGING_NOW);
    }
    return true;
  }
}
