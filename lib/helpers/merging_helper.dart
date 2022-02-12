import 'package:playlistmerger4spotify/helpers/notifications_helper.dart';
import 'package:playlistmerger4spotify/models/notification_info.dart';

class MergingHelper {
  static final MergingHelper _mergingHelper = MergingHelper._internal();
  factory MergingHelper() => _mergingHelper;
  MergingHelper._internal();

  Future<void> updateAllMergedPlaylists({bool showNotification = true, NotificationInfo? notificationInfo}) async {
    await updateSpecificMergedPlaylist("abc", showNotification: false);
    if (showNotification && notificationInfo != null) {
      NotificationsHelper.showNotification(
        notificationInfo.notificationChannelId,
        notificationInfo.notificationChannelName,
        notificationInfo.successTitle,
        notificationInfo.successMessage,
      );
    }
    return Future.value(null);
  }

  Future<void> updateSpecificMergedPlaylist(String playlistId,
      {bool showNotification = true, NotificationInfo? notificationInfo}) async {
    await Future.delayed(const Duration(seconds: 5));
    if (showNotification && notificationInfo != null) {
      NotificationsHelper.showNotification(
        notificationInfo.notificationChannelId,
        notificationInfo.notificationChannelName,
        notificationInfo.successTitle,
        notificationInfo.successMessage,
      );
    }
    return Future.value(null);
  }
}
