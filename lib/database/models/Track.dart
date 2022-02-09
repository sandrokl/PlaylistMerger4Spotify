import 'package:drift/drift.dart';

class Track extends DataClass implements Insertable<Track> {
  final String playlistId;
  final String trackId;
  final String name;
  final String trackArtists;
  final String trackUri;
  final int durationMs;

  Track(
      {required this.playlistId,
      required this.trackId,
      required this.name,
      required this.trackArtists,
      required this.trackUri,
      required this.durationMs});

  factory Track.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Track(
      playlistId: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}playlist_id'])!,
      trackId: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}track_id'])!,
      name: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      trackArtists: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}track_artists'])!,
      trackUri: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}track_uri'])!,
      durationMs: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}duration_ms'])!,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['playlist_id'] = Variable<String>(playlistId);
    map['track_id'] = Variable<String>(trackId);
    map['name'] = Variable<String>(name);
    map['track_artists'] = Variable<String>(trackArtists);
    map['track_uri'] = Variable<String>(trackUri);
    map['duration_ms'] = Variable<int>(durationMs);
    return map;
  }

  factory Track.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Track(
      playlistId: serializer.fromJson<String>(json['playlistId']),
      trackId: serializer.fromJson<String>(json['trackId']),
      name: serializer.fromJson<String>(json['name']),
      trackArtists: serializer.fromJson<String>(json['trackArtists']),
      trackUri: serializer.fromJson<String>(json['trackUri']),
      durationMs: serializer.fromJson<int>(json['durationMs']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'playlistId': serializer.toJson<String>(playlistId),
      'trackId': serializer.toJson<String>(trackId),
      'name': serializer.toJson<String>(name),
      'trackArtists': serializer.toJson<String>(trackArtists),
      'trackUri': serializer.toJson<String>(trackUri),
      'durationMs': serializer.toJson<int>(durationMs),
    };
  }

  @override
  String toString() {
    return (StringBuffer('Track(')
          ..write('playlistId: $playlistId, ')
          ..write('trackId: $trackId, ')
          ..write('name: $name, ')
          ..write('trackArtists: $trackArtists, ')
          ..write('trackUri: $trackUri, ')
          ..write('durationMs: $durationMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(playlistId, trackId, name, trackArtists, trackUri, durationMs);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Track &&
          other.playlistId == playlistId &&
          other.trackId == trackId &&
          other.name == name &&
          other.trackArtists == trackArtists &&
          other.trackUri == trackUri &&
          other.durationMs == durationMs);
}
