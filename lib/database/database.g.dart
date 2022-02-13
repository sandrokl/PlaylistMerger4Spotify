// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Playlist extends DataClass implements Insertable<Playlist> {
  final String playlistId;
  final String name;
  final String ownerId;
  final String tracksUrl;
  final String playUrl;
  final bool isValidated;
  Playlist(
      {required this.playlistId,
      required this.name,
      required this.ownerId,
      required this.tracksUrl,
      required this.playUrl,
      required this.isValidated});
  factory Playlist.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Playlist(
      playlistId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}playlist_id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      ownerId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}owner_id'])!,
      tracksUrl: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tracks_url'])!,
      playUrl: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}play_url'])!,
      isValidated: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_validated'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['playlist_id'] = Variable<String>(playlistId);
    map['name'] = Variable<String>(name);
    map['owner_id'] = Variable<String>(ownerId);
    map['tracks_url'] = Variable<String>(tracksUrl);
    map['play_url'] = Variable<String>(playUrl);
    map['is_validated'] = Variable<bool>(isValidated);
    return map;
  }

  PlaylistsCompanion toCompanion(bool nullToAbsent) {
    return PlaylistsCompanion(
      playlistId: Value(playlistId),
      name: Value(name),
      ownerId: Value(ownerId),
      tracksUrl: Value(tracksUrl),
      playUrl: Value(playUrl),
      isValidated: Value(isValidated),
    );
  }

  factory Playlist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Playlist(
      playlistId: serializer.fromJson<String>(json['playlistId']),
      name: serializer.fromJson<String>(json['name']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      tracksUrl: serializer.fromJson<String>(json['tracksUrl']),
      playUrl: serializer.fromJson<String>(json['playUrl']),
      isValidated: serializer.fromJson<bool>(json['isValidated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'playlistId': serializer.toJson<String>(playlistId),
      'name': serializer.toJson<String>(name),
      'ownerId': serializer.toJson<String>(ownerId),
      'tracksUrl': serializer.toJson<String>(tracksUrl),
      'playUrl': serializer.toJson<String>(playUrl),
      'isValidated': serializer.toJson<bool>(isValidated),
    };
  }

  Playlist copyWith(
          {String? playlistId,
          String? name,
          String? ownerId,
          String? tracksUrl,
          String? playUrl,
          bool? isValidated}) =>
      Playlist(
        playlistId: playlistId ?? this.playlistId,
        name: name ?? this.name,
        ownerId: ownerId ?? this.ownerId,
        tracksUrl: tracksUrl ?? this.tracksUrl,
        playUrl: playUrl ?? this.playUrl,
        isValidated: isValidated ?? this.isValidated,
      );
  @override
  String toString() {
    return (StringBuffer('Playlist(')
          ..write('playlistId: $playlistId, ')
          ..write('name: $name, ')
          ..write('ownerId: $ownerId, ')
          ..write('tracksUrl: $tracksUrl, ')
          ..write('playUrl: $playUrl, ')
          ..write('isValidated: $isValidated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(playlistId, name, ownerId, tracksUrl, playUrl, isValidated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Playlist &&
          other.playlistId == this.playlistId &&
          other.name == this.name &&
          other.ownerId == this.ownerId &&
          other.tracksUrl == this.tracksUrl &&
          other.playUrl == this.playUrl &&
          other.isValidated == this.isValidated);
}

class PlaylistsCompanion extends UpdateCompanion<Playlist> {
  final Value<String> playlistId;
  final Value<String> name;
  final Value<String> ownerId;
  final Value<String> tracksUrl;
  final Value<String> playUrl;
  final Value<bool> isValidated;
  const PlaylistsCompanion({
    this.playlistId = const Value.absent(),
    this.name = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.tracksUrl = const Value.absent(),
    this.playUrl = const Value.absent(),
    this.isValidated = const Value.absent(),
  });
  PlaylistsCompanion.insert({
    required String playlistId,
    required String name,
    required String ownerId,
    required String tracksUrl,
    required String playUrl,
    this.isValidated = const Value.absent(),
  })  : playlistId = Value(playlistId),
        name = Value(name),
        ownerId = Value(ownerId),
        tracksUrl = Value(tracksUrl),
        playUrl = Value(playUrl);
  static Insertable<Playlist> custom({
    Expression<String>? playlistId,
    Expression<String>? name,
    Expression<String>? ownerId,
    Expression<String>? tracksUrl,
    Expression<String>? playUrl,
    Expression<bool>? isValidated,
  }) {
    return RawValuesInsertable({
      if (playlistId != null) 'playlist_id': playlistId,
      if (name != null) 'name': name,
      if (ownerId != null) 'owner_id': ownerId,
      if (tracksUrl != null) 'tracks_url': tracksUrl,
      if (playUrl != null) 'play_url': playUrl,
      if (isValidated != null) 'is_validated': isValidated,
    });
  }

  PlaylistsCompanion copyWith(
      {Value<String>? playlistId,
      Value<String>? name,
      Value<String>? ownerId,
      Value<String>? tracksUrl,
      Value<String>? playUrl,
      Value<bool>? isValidated}) {
    return PlaylistsCompanion(
      playlistId: playlistId ?? this.playlistId,
      name: name ?? this.name,
      ownerId: ownerId ?? this.ownerId,
      tracksUrl: tracksUrl ?? this.tracksUrl,
      playUrl: playUrl ?? this.playUrl,
      isValidated: isValidated ?? this.isValidated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (playlistId.present) {
      map['playlist_id'] = Variable<String>(playlistId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (tracksUrl.present) {
      map['tracks_url'] = Variable<String>(tracksUrl.value);
    }
    if (playUrl.present) {
      map['play_url'] = Variable<String>(playUrl.value);
    }
    if (isValidated.present) {
      map['is_validated'] = Variable<bool>(isValidated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistsCompanion(')
          ..write('playlistId: $playlistId, ')
          ..write('name: $name, ')
          ..write('ownerId: $ownerId, ')
          ..write('tracksUrl: $tracksUrl, ')
          ..write('playUrl: $playUrl, ')
          ..write('isValidated: $isValidated')
          ..write(')'))
        .toString();
  }
}

class $PlaylistsTable extends Playlists
    with TableInfo<$PlaylistsTable, Playlist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _playlistIdMeta = const VerificationMeta('playlistId');
  @override
  late final GeneratedColumn<String?> playlistId = GeneratedColumn<String?>(
      'playlist_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _ownerIdMeta = const VerificationMeta('ownerId');
  @override
  late final GeneratedColumn<String?> ownerId = GeneratedColumn<String?>(
      'owner_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _tracksUrlMeta = const VerificationMeta('tracksUrl');
  @override
  late final GeneratedColumn<String?> tracksUrl = GeneratedColumn<String?>(
      'tracks_url', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _playUrlMeta = const VerificationMeta('playUrl');
  @override
  late final GeneratedColumn<String?> playUrl = GeneratedColumn<String?>(
      'play_url', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _isValidatedMeta =
      const VerificationMeta('isValidated');
  @override
  late final GeneratedColumn<bool?> isValidated = GeneratedColumn<bool?>(
      'is_validated', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_validated IN (0, 1))',
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [playlistId, name, ownerId, tracksUrl, playUrl, isValidated];
  @override
  String get aliasedName => _alias ?? 'playlists';
  @override
  String get actualTableName => 'playlists';
  @override
  VerificationContext validateIntegrity(Insertable<Playlist> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('playlist_id')) {
      context.handle(
          _playlistIdMeta,
          playlistId.isAcceptableOrUnknown(
              data['playlist_id']!, _playlistIdMeta));
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(_ownerIdMeta,
          ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta));
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('tracks_url')) {
      context.handle(_tracksUrlMeta,
          tracksUrl.isAcceptableOrUnknown(data['tracks_url']!, _tracksUrlMeta));
    } else if (isInserting) {
      context.missing(_tracksUrlMeta);
    }
    if (data.containsKey('play_url')) {
      context.handle(_playUrlMeta,
          playUrl.isAcceptableOrUnknown(data['play_url']!, _playUrlMeta));
    } else if (isInserting) {
      context.missing(_playUrlMeta);
    }
    if (data.containsKey('is_validated')) {
      context.handle(
          _isValidatedMeta,
          isValidated.isAcceptableOrUnknown(
              data['is_validated']!, _isValidatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {playlistId};
  @override
  Playlist map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Playlist.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PlaylistsTable createAlias(String alias) {
    return $PlaylistsTable(attachedDatabase, alias);
  }
}

class PlaylistToMerge extends DataClass implements Insertable<PlaylistToMerge> {
  final String destinationPlaylistId;
  final String sourcePlaylistId;
  PlaylistToMerge(
      {required this.destinationPlaylistId, required this.sourcePlaylistId});
  factory PlaylistToMerge.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PlaylistToMerge(
      destinationPlaylistId: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}destination_playlist_id'])!,
      sourcePlaylistId: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}source_playlist_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['destination_playlist_id'] = Variable<String>(destinationPlaylistId);
    map['source_playlist_id'] = Variable<String>(sourcePlaylistId);
    return map;
  }

  PlaylistsToMergeCompanion toCompanion(bool nullToAbsent) {
    return PlaylistsToMergeCompanion(
      destinationPlaylistId: Value(destinationPlaylistId),
      sourcePlaylistId: Value(sourcePlaylistId),
    );
  }

  factory PlaylistToMerge.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistToMerge(
      destinationPlaylistId:
          serializer.fromJson<String>(json['destinationPlaylistId']),
      sourcePlaylistId: serializer.fromJson<String>(json['sourcePlaylistId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'destinationPlaylistId': serializer.toJson<String>(destinationPlaylistId),
      'sourcePlaylistId': serializer.toJson<String>(sourcePlaylistId),
    };
  }

  PlaylistToMerge copyWith(
          {String? destinationPlaylistId, String? sourcePlaylistId}) =>
      PlaylistToMerge(
        destinationPlaylistId:
            destinationPlaylistId ?? this.destinationPlaylistId,
        sourcePlaylistId: sourcePlaylistId ?? this.sourcePlaylistId,
      );
  @override
  String toString() {
    return (StringBuffer('PlaylistToMerge(')
          ..write('destinationPlaylistId: $destinationPlaylistId, ')
          ..write('sourcePlaylistId: $sourcePlaylistId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(destinationPlaylistId, sourcePlaylistId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistToMerge &&
          other.destinationPlaylistId == this.destinationPlaylistId &&
          other.sourcePlaylistId == this.sourcePlaylistId);
}

class PlaylistsToMergeCompanion extends UpdateCompanion<PlaylistToMerge> {
  final Value<String> destinationPlaylistId;
  final Value<String> sourcePlaylistId;
  const PlaylistsToMergeCompanion({
    this.destinationPlaylistId = const Value.absent(),
    this.sourcePlaylistId = const Value.absent(),
  });
  PlaylistsToMergeCompanion.insert({
    required String destinationPlaylistId,
    required String sourcePlaylistId,
  })  : destinationPlaylistId = Value(destinationPlaylistId),
        sourcePlaylistId = Value(sourcePlaylistId);
  static Insertable<PlaylistToMerge> custom({
    Expression<String>? destinationPlaylistId,
    Expression<String>? sourcePlaylistId,
  }) {
    return RawValuesInsertable({
      if (destinationPlaylistId != null)
        'destination_playlist_id': destinationPlaylistId,
      if (sourcePlaylistId != null) 'source_playlist_id': sourcePlaylistId,
    });
  }

  PlaylistsToMergeCompanion copyWith(
      {Value<String>? destinationPlaylistId, Value<String>? sourcePlaylistId}) {
    return PlaylistsToMergeCompanion(
      destinationPlaylistId:
          destinationPlaylistId ?? this.destinationPlaylistId,
      sourcePlaylistId: sourcePlaylistId ?? this.sourcePlaylistId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (destinationPlaylistId.present) {
      map['destination_playlist_id'] =
          Variable<String>(destinationPlaylistId.value);
    }
    if (sourcePlaylistId.present) {
      map['source_playlist_id'] = Variable<String>(sourcePlaylistId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistsToMergeCompanion(')
          ..write('destinationPlaylistId: $destinationPlaylistId, ')
          ..write('sourcePlaylistId: $sourcePlaylistId')
          ..write(')'))
        .toString();
  }
}

class $PlaylistsToMergeTable extends PlaylistsToMerge
    with TableInfo<$PlaylistsToMergeTable, PlaylistToMerge> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistsToMergeTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _destinationPlaylistIdMeta =
      const VerificationMeta('destinationPlaylistId');
  @override
  late final GeneratedColumn<String?> destinationPlaylistId = GeneratedColumn<
          String?>('destination_playlist_id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      defaultConstraints:
          'REFERENCES playlists (playlist_id) ON UPDATE CASCADE ON DELETE CASCADE');
  final VerificationMeta _sourcePlaylistIdMeta =
      const VerificationMeta('sourcePlaylistId');
  @override
  late final GeneratedColumn<String?> sourcePlaylistId = GeneratedColumn<
          String?>('source_playlist_id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      defaultConstraints:
          'REFERENCES playlists (playlist_id) ON UPDATE CASCADE ON DELETE CASCADE');
  @override
  List<GeneratedColumn> get $columns =>
      [destinationPlaylistId, sourcePlaylistId];
  @override
  String get aliasedName => _alias ?? 'playlists_to_merge';
  @override
  String get actualTableName => 'playlists_to_merge';
  @override
  VerificationContext validateIntegrity(Insertable<PlaylistToMerge> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('destination_playlist_id')) {
      context.handle(
          _destinationPlaylistIdMeta,
          destinationPlaylistId.isAcceptableOrUnknown(
              data['destination_playlist_id']!, _destinationPlaylistIdMeta));
    } else if (isInserting) {
      context.missing(_destinationPlaylistIdMeta);
    }
    if (data.containsKey('source_playlist_id')) {
      context.handle(
          _sourcePlaylistIdMeta,
          sourcePlaylistId.isAcceptableOrUnknown(
              data['source_playlist_id']!, _sourcePlaylistIdMeta));
    } else if (isInserting) {
      context.missing(_sourcePlaylistIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey =>
      {destinationPlaylistId, sourcePlaylistId};
  @override
  PlaylistToMerge map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PlaylistToMerge.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PlaylistsToMergeTable createAlias(String alias) {
    return $PlaylistsToMergeTable(attachedDatabase, alias);
  }
}

class TracksCurrentCompanion extends UpdateCompanion<Track> {
  final Value<String> playlistId;
  final Value<String> trackId;
  final Value<String> name;
  final Value<String> trackArtists;
  final Value<String> trackUri;
  final Value<int> durationMs;
  final Value<DateTime> addedAt;
  const TracksCurrentCompanion({
    this.playlistId = const Value.absent(),
    this.trackId = const Value.absent(),
    this.name = const Value.absent(),
    this.trackArtists = const Value.absent(),
    this.trackUri = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  TracksCurrentCompanion.insert({
    required String playlistId,
    required String trackId,
    required String name,
    required String trackArtists,
    required String trackUri,
    required int durationMs,
    required DateTime addedAt,
  })  : playlistId = Value(playlistId),
        trackId = Value(trackId),
        name = Value(name),
        trackArtists = Value(trackArtists),
        trackUri = Value(trackUri),
        durationMs = Value(durationMs),
        addedAt = Value(addedAt);
  static Insertable<Track> custom({
    Expression<String>? playlistId,
    Expression<String>? trackId,
    Expression<String>? name,
    Expression<String>? trackArtists,
    Expression<String>? trackUri,
    Expression<int>? durationMs,
    Expression<DateTime>? addedAt,
  }) {
    return RawValuesInsertable({
      if (playlistId != null) 'playlist_id': playlistId,
      if (trackId != null) 'track_id': trackId,
      if (name != null) 'name': name,
      if (trackArtists != null) 'track_artists': trackArtists,
      if (trackUri != null) 'track_uri': trackUri,
      if (durationMs != null) 'duration_ms': durationMs,
      if (addedAt != null) 'added_at': addedAt,
    });
  }

  TracksCurrentCompanion copyWith(
      {Value<String>? playlistId,
      Value<String>? trackId,
      Value<String>? name,
      Value<String>? trackArtists,
      Value<String>? trackUri,
      Value<int>? durationMs,
      Value<DateTime>? addedAt}) {
    return TracksCurrentCompanion(
      playlistId: playlistId ?? this.playlistId,
      trackId: trackId ?? this.trackId,
      name: name ?? this.name,
      trackArtists: trackArtists ?? this.trackArtists,
      trackUri: trackUri ?? this.trackUri,
      durationMs: durationMs ?? this.durationMs,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (playlistId.present) {
      map['playlist_id'] = Variable<String>(playlistId.value);
    }
    if (trackId.present) {
      map['track_id'] = Variable<String>(trackId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (trackArtists.present) {
      map['track_artists'] = Variable<String>(trackArtists.value);
    }
    if (trackUri.present) {
      map['track_uri'] = Variable<String>(trackUri.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TracksCurrentCompanion(')
          ..write('playlistId: $playlistId, ')
          ..write('trackId: $trackId, ')
          ..write('name: $name, ')
          ..write('trackArtists: $trackArtists, ')
          ..write('trackUri: $trackUri, ')
          ..write('durationMs: $durationMs, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }
}

class $TracksCurrentTable extends TracksCurrent
    with TableInfo<$TracksCurrentTable, Track> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TracksCurrentTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _playlistIdMeta = const VerificationMeta('playlistId');
  @override
  late final GeneratedColumn<String?> playlistId = GeneratedColumn<String?>(
      'playlist_id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      defaultConstraints:
          'REFERENCES playlists (playlist_id) ON UPDATE CASCADE ON DELETE CASCADE');
  final VerificationMeta _trackIdMeta = const VerificationMeta('trackId');
  @override
  late final GeneratedColumn<String?> trackId = GeneratedColumn<String?>(
      'track_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _trackArtistsMeta =
      const VerificationMeta('trackArtists');
  @override
  late final GeneratedColumn<String?> trackArtists = GeneratedColumn<String?>(
      'track_artists', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _trackUriMeta = const VerificationMeta('trackUri');
  @override
  late final GeneratedColumn<String?> trackUri = GeneratedColumn<String?>(
      'track_uri', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _durationMsMeta = const VerificationMeta('durationMs');
  @override
  late final GeneratedColumn<int?> durationMs = GeneratedColumn<int?>(
      'duration_ms', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _addedAtMeta = const VerificationMeta('addedAt');
  @override
  late final GeneratedColumn<DateTime?> addedAt = GeneratedColumn<DateTime?>(
      'added_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [playlistId, trackId, name, trackArtists, trackUri, durationMs, addedAt];
  @override
  String get aliasedName => _alias ?? 'tracks_current';
  @override
  String get actualTableName => 'tracks_current';
  @override
  VerificationContext validateIntegrity(Insertable<Track> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('playlist_id')) {
      context.handle(
          _playlistIdMeta,
          playlistId.isAcceptableOrUnknown(
              data['playlist_id']!, _playlistIdMeta));
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('track_id')) {
      context.handle(_trackIdMeta,
          trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta));
    } else if (isInserting) {
      context.missing(_trackIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('track_artists')) {
      context.handle(
          _trackArtistsMeta,
          trackArtists.isAcceptableOrUnknown(
              data['track_artists']!, _trackArtistsMeta));
    } else if (isInserting) {
      context.missing(_trackArtistsMeta);
    }
    if (data.containsKey('track_uri')) {
      context.handle(_trackUriMeta,
          trackUri.isAcceptableOrUnknown(data['track_uri']!, _trackUriMeta));
    } else if (isInserting) {
      context.missing(_trackUriMeta);
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
          _durationMsMeta,
          durationMs.isAcceptableOrUnknown(
              data['duration_ms']!, _durationMsMeta));
    } else if (isInserting) {
      context.missing(_durationMsMeta);
    }
    if (data.containsKey('added_at')) {
      context.handle(_addedAtMeta,
          addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta));
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {playlistId, trackId};
  @override
  Track map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Track(
      playlistId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}playlist_id'])!,
      trackId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      trackArtists: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_artists'])!,
      trackUri: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_uri'])!,
      durationMs: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}duration_ms'])!,
      addedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}added_at'])!,
    );
  }

  @override
  $TracksCurrentTable createAlias(String alias) {
    return $TracksCurrentTable(attachedDatabase, alias);
  }
}

class TracksNewAllCompanion extends UpdateCompanion<Track> {
  final Value<String> playlistId;
  final Value<String> trackId;
  final Value<String> name;
  final Value<String> trackArtists;
  final Value<String> trackUri;
  final Value<int> durationMs;
  final Value<DateTime> addedAt;
  const TracksNewAllCompanion({
    this.playlistId = const Value.absent(),
    this.trackId = const Value.absent(),
    this.name = const Value.absent(),
    this.trackArtists = const Value.absent(),
    this.trackUri = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  TracksNewAllCompanion.insert({
    required String playlistId,
    required String trackId,
    required String name,
    required String trackArtists,
    required String trackUri,
    required int durationMs,
    required DateTime addedAt,
  })  : playlistId = Value(playlistId),
        trackId = Value(trackId),
        name = Value(name),
        trackArtists = Value(trackArtists),
        trackUri = Value(trackUri),
        durationMs = Value(durationMs),
        addedAt = Value(addedAt);
  static Insertable<Track> custom({
    Expression<String>? playlistId,
    Expression<String>? trackId,
    Expression<String>? name,
    Expression<String>? trackArtists,
    Expression<String>? trackUri,
    Expression<int>? durationMs,
    Expression<DateTime>? addedAt,
  }) {
    return RawValuesInsertable({
      if (playlistId != null) 'playlist_id': playlistId,
      if (trackId != null) 'track_id': trackId,
      if (name != null) 'name': name,
      if (trackArtists != null) 'track_artists': trackArtists,
      if (trackUri != null) 'track_uri': trackUri,
      if (durationMs != null) 'duration_ms': durationMs,
      if (addedAt != null) 'added_at': addedAt,
    });
  }

  TracksNewAllCompanion copyWith(
      {Value<String>? playlistId,
      Value<String>? trackId,
      Value<String>? name,
      Value<String>? trackArtists,
      Value<String>? trackUri,
      Value<int>? durationMs,
      Value<DateTime>? addedAt}) {
    return TracksNewAllCompanion(
      playlistId: playlistId ?? this.playlistId,
      trackId: trackId ?? this.trackId,
      name: name ?? this.name,
      trackArtists: trackArtists ?? this.trackArtists,
      trackUri: trackUri ?? this.trackUri,
      durationMs: durationMs ?? this.durationMs,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (playlistId.present) {
      map['playlist_id'] = Variable<String>(playlistId.value);
    }
    if (trackId.present) {
      map['track_id'] = Variable<String>(trackId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (trackArtists.present) {
      map['track_artists'] = Variable<String>(trackArtists.value);
    }
    if (trackUri.present) {
      map['track_uri'] = Variable<String>(trackUri.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TracksNewAllCompanion(')
          ..write('playlistId: $playlistId, ')
          ..write('trackId: $trackId, ')
          ..write('name: $name, ')
          ..write('trackArtists: $trackArtists, ')
          ..write('trackUri: $trackUri, ')
          ..write('durationMs: $durationMs, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }
}

class $TracksNewAllTable extends TracksNewAll
    with TableInfo<$TracksNewAllTable, Track> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TracksNewAllTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _playlistIdMeta = const VerificationMeta('playlistId');
  @override
  late final GeneratedColumn<String?> playlistId = GeneratedColumn<String?>(
      'playlist_id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      defaultConstraints:
          'REFERENCES playlists (playlist_id) ON UPDATE CASCADE ON DELETE CASCADE');
  final VerificationMeta _trackIdMeta = const VerificationMeta('trackId');
  @override
  late final GeneratedColumn<String?> trackId = GeneratedColumn<String?>(
      'track_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _trackArtistsMeta =
      const VerificationMeta('trackArtists');
  @override
  late final GeneratedColumn<String?> trackArtists = GeneratedColumn<String?>(
      'track_artists', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _trackUriMeta = const VerificationMeta('trackUri');
  @override
  late final GeneratedColumn<String?> trackUri = GeneratedColumn<String?>(
      'track_uri', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _durationMsMeta = const VerificationMeta('durationMs');
  @override
  late final GeneratedColumn<int?> durationMs = GeneratedColumn<int?>(
      'duration_ms', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _addedAtMeta = const VerificationMeta('addedAt');
  @override
  late final GeneratedColumn<DateTime?> addedAt = GeneratedColumn<DateTime?>(
      'added_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [playlistId, trackId, name, trackArtists, trackUri, durationMs, addedAt];
  @override
  String get aliasedName => _alias ?? 'tracks_new_all';
  @override
  String get actualTableName => 'tracks_new_all';
  @override
  VerificationContext validateIntegrity(Insertable<Track> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('playlist_id')) {
      context.handle(
          _playlistIdMeta,
          playlistId.isAcceptableOrUnknown(
              data['playlist_id']!, _playlistIdMeta));
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('track_id')) {
      context.handle(_trackIdMeta,
          trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta));
    } else if (isInserting) {
      context.missing(_trackIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('track_artists')) {
      context.handle(
          _trackArtistsMeta,
          trackArtists.isAcceptableOrUnknown(
              data['track_artists']!, _trackArtistsMeta));
    } else if (isInserting) {
      context.missing(_trackArtistsMeta);
    }
    if (data.containsKey('track_uri')) {
      context.handle(_trackUriMeta,
          trackUri.isAcceptableOrUnknown(data['track_uri']!, _trackUriMeta));
    } else if (isInserting) {
      context.missing(_trackUriMeta);
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
          _durationMsMeta,
          durationMs.isAcceptableOrUnknown(
              data['duration_ms']!, _durationMsMeta));
    } else if (isInserting) {
      context.missing(_durationMsMeta);
    }
    if (data.containsKey('added_at')) {
      context.handle(_addedAtMeta,
          addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta));
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {playlistId, trackId};
  @override
  Track map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Track(
      playlistId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}playlist_id'])!,
      trackId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      trackArtists: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_artists'])!,
      trackUri: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_uri'])!,
      durationMs: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}duration_ms'])!,
      addedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}added_at'])!,
    );
  }

  @override
  $TracksNewAllTable createAlias(String alias) {
    return $TracksNewAllTable(attachedDatabase, alias);
  }
}

class TracksNewDistinctCompanion extends UpdateCompanion<Track> {
  final Value<String> playlistId;
  final Value<String> trackId;
  final Value<String> name;
  final Value<String> trackArtists;
  final Value<String> trackUri;
  final Value<int> durationMs;
  final Value<DateTime> addedAt;
  const TracksNewDistinctCompanion({
    this.playlistId = const Value.absent(),
    this.trackId = const Value.absent(),
    this.name = const Value.absent(),
    this.trackArtists = const Value.absent(),
    this.trackUri = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  TracksNewDistinctCompanion.insert({
    required String playlistId,
    required String trackId,
    required String name,
    required String trackArtists,
    required String trackUri,
    required int durationMs,
    required DateTime addedAt,
  })  : playlistId = Value(playlistId),
        trackId = Value(trackId),
        name = Value(name),
        trackArtists = Value(trackArtists),
        trackUri = Value(trackUri),
        durationMs = Value(durationMs),
        addedAt = Value(addedAt);
  static Insertable<Track> custom({
    Expression<String>? playlistId,
    Expression<String>? trackId,
    Expression<String>? name,
    Expression<String>? trackArtists,
    Expression<String>? trackUri,
    Expression<int>? durationMs,
    Expression<DateTime>? addedAt,
  }) {
    return RawValuesInsertable({
      if (playlistId != null) 'playlist_id': playlistId,
      if (trackId != null) 'track_id': trackId,
      if (name != null) 'name': name,
      if (trackArtists != null) 'track_artists': trackArtists,
      if (trackUri != null) 'track_uri': trackUri,
      if (durationMs != null) 'duration_ms': durationMs,
      if (addedAt != null) 'added_at': addedAt,
    });
  }

  TracksNewDistinctCompanion copyWith(
      {Value<String>? playlistId,
      Value<String>? trackId,
      Value<String>? name,
      Value<String>? trackArtists,
      Value<String>? trackUri,
      Value<int>? durationMs,
      Value<DateTime>? addedAt}) {
    return TracksNewDistinctCompanion(
      playlistId: playlistId ?? this.playlistId,
      trackId: trackId ?? this.trackId,
      name: name ?? this.name,
      trackArtists: trackArtists ?? this.trackArtists,
      trackUri: trackUri ?? this.trackUri,
      durationMs: durationMs ?? this.durationMs,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (playlistId.present) {
      map['playlist_id'] = Variable<String>(playlistId.value);
    }
    if (trackId.present) {
      map['track_id'] = Variable<String>(trackId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (trackArtists.present) {
      map['track_artists'] = Variable<String>(trackArtists.value);
    }
    if (trackUri.present) {
      map['track_uri'] = Variable<String>(trackUri.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TracksNewDistinctCompanion(')
          ..write('playlistId: $playlistId, ')
          ..write('trackId: $trackId, ')
          ..write('name: $name, ')
          ..write('trackArtists: $trackArtists, ')
          ..write('trackUri: $trackUri, ')
          ..write('durationMs: $durationMs, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }
}

class $TracksNewDistinctTable extends TracksNewDistinct
    with TableInfo<$TracksNewDistinctTable, Track> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TracksNewDistinctTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _playlistIdMeta = const VerificationMeta('playlistId');
  @override
  late final GeneratedColumn<String?> playlistId = GeneratedColumn<String?>(
      'playlist_id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      defaultConstraints:
          'REFERENCES playlists (playlist_id) ON UPDATE CASCADE ON DELETE CASCADE');
  final VerificationMeta _trackIdMeta = const VerificationMeta('trackId');
  @override
  late final GeneratedColumn<String?> trackId = GeneratedColumn<String?>(
      'track_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _trackArtistsMeta =
      const VerificationMeta('trackArtists');
  @override
  late final GeneratedColumn<String?> trackArtists = GeneratedColumn<String?>(
      'track_artists', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _trackUriMeta = const VerificationMeta('trackUri');
  @override
  late final GeneratedColumn<String?> trackUri = GeneratedColumn<String?>(
      'track_uri', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _durationMsMeta = const VerificationMeta('durationMs');
  @override
  late final GeneratedColumn<int?> durationMs = GeneratedColumn<int?>(
      'duration_ms', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _addedAtMeta = const VerificationMeta('addedAt');
  @override
  late final GeneratedColumn<DateTime?> addedAt = GeneratedColumn<DateTime?>(
      'added_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [playlistId, trackId, name, trackArtists, trackUri, durationMs, addedAt];
  @override
  String get aliasedName => _alias ?? 'tracks_new_distinct';
  @override
  String get actualTableName => 'tracks_new_distinct';
  @override
  VerificationContext validateIntegrity(Insertable<Track> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('playlist_id')) {
      context.handle(
          _playlistIdMeta,
          playlistId.isAcceptableOrUnknown(
              data['playlist_id']!, _playlistIdMeta));
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('track_id')) {
      context.handle(_trackIdMeta,
          trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta));
    } else if (isInserting) {
      context.missing(_trackIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('track_artists')) {
      context.handle(
          _trackArtistsMeta,
          trackArtists.isAcceptableOrUnknown(
              data['track_artists']!, _trackArtistsMeta));
    } else if (isInserting) {
      context.missing(_trackArtistsMeta);
    }
    if (data.containsKey('track_uri')) {
      context.handle(_trackUriMeta,
          trackUri.isAcceptableOrUnknown(data['track_uri']!, _trackUriMeta));
    } else if (isInserting) {
      context.missing(_trackUriMeta);
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
          _durationMsMeta,
          durationMs.isAcceptableOrUnknown(
              data['duration_ms']!, _durationMsMeta));
    } else if (isInserting) {
      context.missing(_durationMsMeta);
    }
    if (data.containsKey('added_at')) {
      context.handle(_addedAtMeta,
          addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta));
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {playlistId, trackId};
  @override
  Track map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Track(
      playlistId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}playlist_id'])!,
      trackId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      trackArtists: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_artists'])!,
      trackUri: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_uri'])!,
      durationMs: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}duration_ms'])!,
      addedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}added_at'])!,
    );
  }

  @override
  $TracksNewDistinctTable createAlias(String alias) {
    return $TracksNewDistinctTable(attachedDatabase, alias);
  }
}

class TracksToRemoveCompanion extends UpdateCompanion<Track> {
  final Value<String> playlistId;
  final Value<String> trackId;
  final Value<String> name;
  final Value<String> trackArtists;
  final Value<String> trackUri;
  final Value<int> durationMs;
  final Value<DateTime> addedAt;
  const TracksToRemoveCompanion({
    this.playlistId = const Value.absent(),
    this.trackId = const Value.absent(),
    this.name = const Value.absent(),
    this.trackArtists = const Value.absent(),
    this.trackUri = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  TracksToRemoveCompanion.insert({
    required String playlistId,
    required String trackId,
    required String name,
    required String trackArtists,
    required String trackUri,
    required int durationMs,
    required DateTime addedAt,
  })  : playlistId = Value(playlistId),
        trackId = Value(trackId),
        name = Value(name),
        trackArtists = Value(trackArtists),
        trackUri = Value(trackUri),
        durationMs = Value(durationMs),
        addedAt = Value(addedAt);
  static Insertable<Track> custom({
    Expression<String>? playlistId,
    Expression<String>? trackId,
    Expression<String>? name,
    Expression<String>? trackArtists,
    Expression<String>? trackUri,
    Expression<int>? durationMs,
    Expression<DateTime>? addedAt,
  }) {
    return RawValuesInsertable({
      if (playlistId != null) 'playlist_id': playlistId,
      if (trackId != null) 'track_id': trackId,
      if (name != null) 'name': name,
      if (trackArtists != null) 'track_artists': trackArtists,
      if (trackUri != null) 'track_uri': trackUri,
      if (durationMs != null) 'duration_ms': durationMs,
      if (addedAt != null) 'added_at': addedAt,
    });
  }

  TracksToRemoveCompanion copyWith(
      {Value<String>? playlistId,
      Value<String>? trackId,
      Value<String>? name,
      Value<String>? trackArtists,
      Value<String>? trackUri,
      Value<int>? durationMs,
      Value<DateTime>? addedAt}) {
    return TracksToRemoveCompanion(
      playlistId: playlistId ?? this.playlistId,
      trackId: trackId ?? this.trackId,
      name: name ?? this.name,
      trackArtists: trackArtists ?? this.trackArtists,
      trackUri: trackUri ?? this.trackUri,
      durationMs: durationMs ?? this.durationMs,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (playlistId.present) {
      map['playlist_id'] = Variable<String>(playlistId.value);
    }
    if (trackId.present) {
      map['track_id'] = Variable<String>(trackId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (trackArtists.present) {
      map['track_artists'] = Variable<String>(trackArtists.value);
    }
    if (trackUri.present) {
      map['track_uri'] = Variable<String>(trackUri.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TracksToRemoveCompanion(')
          ..write('playlistId: $playlistId, ')
          ..write('trackId: $trackId, ')
          ..write('name: $name, ')
          ..write('trackArtists: $trackArtists, ')
          ..write('trackUri: $trackUri, ')
          ..write('durationMs: $durationMs, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }
}

class $TracksToRemoveTable extends TracksToRemove
    with TableInfo<$TracksToRemoveTable, Track> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TracksToRemoveTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _playlistIdMeta = const VerificationMeta('playlistId');
  @override
  late final GeneratedColumn<String?> playlistId = GeneratedColumn<String?>(
      'playlist_id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      defaultConstraints:
          'REFERENCES playlists (playlist_id) ON UPDATE CASCADE ON DELETE CASCADE');
  final VerificationMeta _trackIdMeta = const VerificationMeta('trackId');
  @override
  late final GeneratedColumn<String?> trackId = GeneratedColumn<String?>(
      'track_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _trackArtistsMeta =
      const VerificationMeta('trackArtists');
  @override
  late final GeneratedColumn<String?> trackArtists = GeneratedColumn<String?>(
      'track_artists', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _trackUriMeta = const VerificationMeta('trackUri');
  @override
  late final GeneratedColumn<String?> trackUri = GeneratedColumn<String?>(
      'track_uri', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _durationMsMeta = const VerificationMeta('durationMs');
  @override
  late final GeneratedColumn<int?> durationMs = GeneratedColumn<int?>(
      'duration_ms', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _addedAtMeta = const VerificationMeta('addedAt');
  @override
  late final GeneratedColumn<DateTime?> addedAt = GeneratedColumn<DateTime?>(
      'added_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [playlistId, trackId, name, trackArtists, trackUri, durationMs, addedAt];
  @override
  String get aliasedName => _alias ?? 'tracks_to_remove';
  @override
  String get actualTableName => 'tracks_to_remove';
  @override
  VerificationContext validateIntegrity(Insertable<Track> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('playlist_id')) {
      context.handle(
          _playlistIdMeta,
          playlistId.isAcceptableOrUnknown(
              data['playlist_id']!, _playlistIdMeta));
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('track_id')) {
      context.handle(_trackIdMeta,
          trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta));
    } else if (isInserting) {
      context.missing(_trackIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('track_artists')) {
      context.handle(
          _trackArtistsMeta,
          trackArtists.isAcceptableOrUnknown(
              data['track_artists']!, _trackArtistsMeta));
    } else if (isInserting) {
      context.missing(_trackArtistsMeta);
    }
    if (data.containsKey('track_uri')) {
      context.handle(_trackUriMeta,
          trackUri.isAcceptableOrUnknown(data['track_uri']!, _trackUriMeta));
    } else if (isInserting) {
      context.missing(_trackUriMeta);
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
          _durationMsMeta,
          durationMs.isAcceptableOrUnknown(
              data['duration_ms']!, _durationMsMeta));
    } else if (isInserting) {
      context.missing(_durationMsMeta);
    }
    if (data.containsKey('added_at')) {
      context.handle(_addedAtMeta,
          addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta));
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {playlistId, trackId};
  @override
  Track map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Track(
      playlistId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}playlist_id'])!,
      trackId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      trackArtists: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_artists'])!,
      trackUri: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_uri'])!,
      durationMs: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}duration_ms'])!,
      addedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}added_at'])!,
    );
  }

  @override
  $TracksToRemoveTable createAlias(String alias) {
    return $TracksToRemoveTable(attachedDatabase, alias);
  }
}

class TracksToAddCompanion extends UpdateCompanion<Track> {
  final Value<String> playlistId;
  final Value<String> trackId;
  final Value<String> name;
  final Value<String> trackArtists;
  final Value<String> trackUri;
  final Value<int> durationMs;
  final Value<DateTime> addedAt;
  const TracksToAddCompanion({
    this.playlistId = const Value.absent(),
    this.trackId = const Value.absent(),
    this.name = const Value.absent(),
    this.trackArtists = const Value.absent(),
    this.trackUri = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  TracksToAddCompanion.insert({
    required String playlistId,
    required String trackId,
    required String name,
    required String trackArtists,
    required String trackUri,
    required int durationMs,
    required DateTime addedAt,
  })  : playlistId = Value(playlistId),
        trackId = Value(trackId),
        name = Value(name),
        trackArtists = Value(trackArtists),
        trackUri = Value(trackUri),
        durationMs = Value(durationMs),
        addedAt = Value(addedAt);
  static Insertable<Track> custom({
    Expression<String>? playlistId,
    Expression<String>? trackId,
    Expression<String>? name,
    Expression<String>? trackArtists,
    Expression<String>? trackUri,
    Expression<int>? durationMs,
    Expression<DateTime>? addedAt,
  }) {
    return RawValuesInsertable({
      if (playlistId != null) 'playlist_id': playlistId,
      if (trackId != null) 'track_id': trackId,
      if (name != null) 'name': name,
      if (trackArtists != null) 'track_artists': trackArtists,
      if (trackUri != null) 'track_uri': trackUri,
      if (durationMs != null) 'duration_ms': durationMs,
      if (addedAt != null) 'added_at': addedAt,
    });
  }

  TracksToAddCompanion copyWith(
      {Value<String>? playlistId,
      Value<String>? trackId,
      Value<String>? name,
      Value<String>? trackArtists,
      Value<String>? trackUri,
      Value<int>? durationMs,
      Value<DateTime>? addedAt}) {
    return TracksToAddCompanion(
      playlistId: playlistId ?? this.playlistId,
      trackId: trackId ?? this.trackId,
      name: name ?? this.name,
      trackArtists: trackArtists ?? this.trackArtists,
      trackUri: trackUri ?? this.trackUri,
      durationMs: durationMs ?? this.durationMs,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (playlistId.present) {
      map['playlist_id'] = Variable<String>(playlistId.value);
    }
    if (trackId.present) {
      map['track_id'] = Variable<String>(trackId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (trackArtists.present) {
      map['track_artists'] = Variable<String>(trackArtists.value);
    }
    if (trackUri.present) {
      map['track_uri'] = Variable<String>(trackUri.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TracksToAddCompanion(')
          ..write('playlistId: $playlistId, ')
          ..write('trackId: $trackId, ')
          ..write('name: $name, ')
          ..write('trackArtists: $trackArtists, ')
          ..write('trackUri: $trackUri, ')
          ..write('durationMs: $durationMs, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }
}

class $TracksToAddTable extends TracksToAdd
    with TableInfo<$TracksToAddTable, Track> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TracksToAddTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _playlistIdMeta = const VerificationMeta('playlistId');
  @override
  late final GeneratedColumn<String?> playlistId = GeneratedColumn<String?>(
      'playlist_id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      defaultConstraints:
          'REFERENCES playlists (playlist_id) ON UPDATE CASCADE ON DELETE CASCADE');
  final VerificationMeta _trackIdMeta = const VerificationMeta('trackId');
  @override
  late final GeneratedColumn<String?> trackId = GeneratedColumn<String?>(
      'track_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _trackArtistsMeta =
      const VerificationMeta('trackArtists');
  @override
  late final GeneratedColumn<String?> trackArtists = GeneratedColumn<String?>(
      'track_artists', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _trackUriMeta = const VerificationMeta('trackUri');
  @override
  late final GeneratedColumn<String?> trackUri = GeneratedColumn<String?>(
      'track_uri', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _durationMsMeta = const VerificationMeta('durationMs');
  @override
  late final GeneratedColumn<int?> durationMs = GeneratedColumn<int?>(
      'duration_ms', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _addedAtMeta = const VerificationMeta('addedAt');
  @override
  late final GeneratedColumn<DateTime?> addedAt = GeneratedColumn<DateTime?>(
      'added_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [playlistId, trackId, name, trackArtists, trackUri, durationMs, addedAt];
  @override
  String get aliasedName => _alias ?? 'tracks_to_add';
  @override
  String get actualTableName => 'tracks_to_add';
  @override
  VerificationContext validateIntegrity(Insertable<Track> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('playlist_id')) {
      context.handle(
          _playlistIdMeta,
          playlistId.isAcceptableOrUnknown(
              data['playlist_id']!, _playlistIdMeta));
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('track_id')) {
      context.handle(_trackIdMeta,
          trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta));
    } else if (isInserting) {
      context.missing(_trackIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('track_artists')) {
      context.handle(
          _trackArtistsMeta,
          trackArtists.isAcceptableOrUnknown(
              data['track_artists']!, _trackArtistsMeta));
    } else if (isInserting) {
      context.missing(_trackArtistsMeta);
    }
    if (data.containsKey('track_uri')) {
      context.handle(_trackUriMeta,
          trackUri.isAcceptableOrUnknown(data['track_uri']!, _trackUriMeta));
    } else if (isInserting) {
      context.missing(_trackUriMeta);
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
          _durationMsMeta,
          durationMs.isAcceptableOrUnknown(
              data['duration_ms']!, _durationMsMeta));
    } else if (isInserting) {
      context.missing(_durationMsMeta);
    }
    if (data.containsKey('added_at')) {
      context.handle(_addedAtMeta,
          addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta));
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {playlistId, trackId};
  @override
  Track map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Track(
      playlistId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}playlist_id'])!,
      trackId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      trackArtists: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_artists'])!,
      trackUri: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}track_uri'])!,
      durationMs: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}duration_ms'])!,
      addedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}added_at'])!,
    );
  }

  @override
  $TracksToAddTable createAlias(String alias) {
    return $TracksToAddTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $PlaylistsTable playlists = $PlaylistsTable(this);
  late final $PlaylistsToMergeTable playlistsToMerge =
      $PlaylistsToMergeTable(this);
  late final $TracksCurrentTable tracksCurrent = $TracksCurrentTable(this);
  late final $TracksNewAllTable tracksNewAll = $TracksNewAllTable(this);
  late final $TracksNewDistinctTable tracksNewDistinct =
      $TracksNewDistinctTable(this);
  late final $TracksToRemoveTable tracksToRemove = $TracksToRemoveTable(this);
  late final $TracksToAddTable tracksToAdd = $TracksToAddTable(this);
  late final PlaylistsDao playlistsDao = PlaylistsDao(this as AppDatabase);
  late final PlaylistsToMergeDao playlistsToMergeDao =
      PlaylistsToMergeDao(this as AppDatabase);
  late final TracksCurrentDao tracksCurrentDao =
      TracksCurrentDao(this as AppDatabase);
  late final TracksNewAllDao tracksNewAllDao =
      TracksNewAllDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        playlists,
        playlistsToMerge,
        tracksCurrent,
        tracksNewAll,
        tracksNewDistinct,
        tracksToRemove,
        tracksToAdd
      ];
}
