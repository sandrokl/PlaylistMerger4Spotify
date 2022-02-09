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



// curl -X "GET" "https://api.spotify.com/v1/playlists/<playlist_id>/tracks?fields=items(track(id%2Cname%2Curi%2Cduration_ms%2Cartists(name)))&limit=10&offset=5"
// {
//   "items": [
//     {
//       "track": {
//         "artists": [
//           {
//             "name": "Haley Reinhart"
//           }
//         ],
//         "duration_ms": 173500,
//         "id": "0Rm2G83ELwkuEgpHlJcBPn",
//         "name": "Can't Help Falling in Love",
//         "uri": "spotify:track:0Rm2G83ELwkuEgpHlJcBPn"
//       }
//     },
//     {
//       "track": {
//         "artists": [
//           {
//             "name": "Olivia O'Brien"
//           }
//         ],
//         "duration_ms": 189000,
//         "id": "0jllH0usRFD4LJkJnGK9Lf",
//         "name": "Complicated",
//         "uri": "spotify:track:0jllH0usRFD4LJkJnGK9Lf"
//       }
//     },
//     {
//       "track": {
//         "artists": [
//           {
//             "name": "Alex Goot"
//           },
//           {
//             "name": "Kurt Hugo Schneider"
//           },
//           {
//             "name": "Megan Nicole"
//           }
//         ],
//         "duration_ms": 146626,
//         "id": "4Ejcw0qIiDjuaMtB5WDiBD",
//         "name": "Stand By You",
//         "uri": "spotify:track:4Ejcw0qIiDjuaMtB5WDiBD"
//       }
//     },
//     {
//       "track": {
//         "artists": [
//           {
//             "name": "Jasmine Thompson"
//           }
//         ],
//         "duration_ms": 172149,
//         "id": "5fa6CrQwHwthEoCvTtd5Ig",
//         "name": "Let Her Go",
//         "uri": "spotify:track:5fa6CrQwHwthEoCvTtd5Ig"
//       }
//     },
//     {
//       "track": {
//         "artists": [
//           {
//             "name": "The Mayries"
//           }
//         ],
//         "duration_ms": 183472,
//         "id": "5l7gQEyycQWk10yVfXspVK",
//         "name": "Don't Wanna Know - Acoustic Version",
//         "uri": "spotify:track:5l7gQEyycQWk10yVfXspVK"
//       }
//     },
//     {
//       "track": {
//         "artists": [
//           {
//             "name": "Ed Sheeran"
//           }
//         ],
//         "duration_ms": 198777,
//         "id": "73TXMz1i41sGfOuDg8gH4L",
//         "name": "Candle In The Wind - 2018 Version",
//         "uri": "spotify:track:73TXMz1i41sGfOuDg8gH4L"
//       }
//     },
//     {
//       "track": {
//         "artists": [
//           {
//             "name": "Cat Power"
//           }
//         ],
//         "duration_ms": 260760,
//         "id": "7Kx832x6sRNGRy8o40u7Mr",
//         "name": "Bad Religion",
//         "uri": "spotify:track:7Kx832x6sRNGRy8o40u7Mr"
//       }
//     },
//     {
//       "track": {
//         "artists": [
//           {
//             "name": "Hearts & Colors"
//           }
//         ],
//         "duration_ms": 211000,
//         "id": "3PEb2ARloVhBrffWcS8hyy",
//         "name": "Lego House",
//         "uri": "spotify:track:3PEb2ARloVhBrffWcS8hyy"
//       }
//     },
//     {
//       "track": {
//         "artists": [
//           {
//             "name": "Boyce Avenue"
//           },
//           {
//             "name": "Bea Miller"
//           }
//         ],
//         "duration_ms": 222146,
//         "id": "2PVU8zHILp6jK4Q7W6rkz8",
//         "name": "We Can't Stop (feat. Bea Miller)",
//         "uri": "spotify:track:2PVU8zHILp6jK4Q7W6rkz8"
//       }
//     },
//     {
//       "track": {
//         "artists": [
//           {
//             "name": "Kina Grannis"
//           }
//         ],
//         "duration_ms": 201933,
//         "id": "7uuEfUMuPeQ7RlSWa0cES2",
//         "name": "Can’t Help Falling in Love",
//         "uri": "spotify:track:7uuEfUMuPeQ7RlSWa0cES2"
//       }
//     }
//   ]
// }