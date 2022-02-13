import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/base/track.dart';
import 'package:playlistmerger4spotify/helpers/notifications_helper.dart';
import 'package:playlistmerger4spotify/helpers/spotify_client.dart';
import 'package:playlistmerger4spotify/models/notification_info.dart';

class MergingHelper {
  static final MergingHelper _mergingHelper = MergingHelper._internal();
  factory MergingHelper() => _mergingHelper;
  MergingHelper._internal();

  final _db = AppDatabase();
  final _databaseBatchSize = 100;

  Future<void> updateAllMergedPlaylists({bool showNotification = true, NotificationInfo? notificationInfo}) async {
    //await updateSpecificMergedPlaylist("abc", showNotification: false);
    if (showNotification && notificationInfo != null) {
      NotificationsHelper.showNotification(
        notificationInfo.notificationChannelId,
        notificationInfo.notificationChannelName,
        notificationInfo.successTitle,
        notificationInfo.successMessage,
      );
    }
  }

  Future<bool> updateSpecificMergedPlaylist(String playlistId,
      {bool showNotification = true, NotificationInfo? notificationInfo}) async {
    try {
      // STEP 0 : clean all records of tracks
      _db.tracksCurrentDao.deleteAll();

      // STEP 1 : get current tracks in merged playlist
      var tracks = <Track>[];
      await for (var track in SpotifyClient().getTracksFromPlaylist(playlistId)) {
        tracks.add(track);
        if (tracks.length == _databaseBatchSize) {
          await _db.tracksCurrentDao.insertAll(tracks);
          tracks.clear();
        }
      }
      await _db.tracksCurrentDao.insertAll(tracks);
      tracks.clear();

      if (showNotification && notificationInfo != null) {
        NotificationsHelper.showNotification(
          notificationInfo.notificationChannelId,
          notificationInfo.notificationChannelName,
          notificationInfo.successTitle,
          notificationInfo.successMessage,
        );
      }
      return true;
    } catch (_) {
      if (showNotification && notificationInfo != null) {
        NotificationsHelper.showNotification(
          notificationInfo.notificationChannelId,
          notificationInfo.notificationChannelName,
          notificationInfo.failureTitle,
          notificationInfo.failureMessage,
        );
      }
      return false;
    }
  }
}
