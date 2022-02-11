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

/*
https://api.spotify.com/v1/playlists/37i9dQZF1DXarRysLJmuju/tracks?fields=items(added_at%2Ctrack(id%2Cname%2Curi%2Cduration_ms%2Cartists(name)))%2Cprevious%2Cnext&limit=5&offset=5
{
  "items": [
    {
      "added_at": "2022-02-11T06:50:15Z",
      "track": {
        "artists": [
          {
            "name": "Michael Bublé"
          }
        ],
        "duration_ms": 218390,
        "id": "3tKggonCKJgCG7nroEH2np",
        "name": "I'll Never Not Love You",
        "uri": "spotify:track:3tKggonCKJgCG7nroEH2np"
      }
    },
    {
      "added_at": "2022-02-11T06:50:15Z",
      "track": {
        "artists": [
          {
            "name": "Elton John"
          },
          {
            "name": "Dua Lipa"
          },
          {
            "name": "PNAU"
          }
        ],
        "duration_ms": 202735,
        "id": "7rglLriMNBPAyuJOMGwi39",
        "name": "Cold Heart - PNAU Remix",
        "uri": "spotify:track:7rglLriMNBPAyuJOMGwi39"
      }
    },
    {
      "added_at": "2022-02-11T06:50:15Z",
      "track": {
        "artists": [
          {
            "name": "Tiësto"
          },
          {
            "name": "Ava Max"
          }
        ],
        "duration_ms": 164818,
        "id": "18asYwWugKjjsihZ0YvRxO",
        "name": "The Motto",
        "uri": "spotify:track:18asYwWugKjjsihZ0YvRxO"
      }
    },
    {
      "added_at": "2022-02-11T06:50:15Z",
      "track": {
        "artists": [
          {
            "name": "Tyler Shaw"
          }
        ],
        "duration_ms": 192560,
        "id": "6OFXDyfd3QB3DhXGfSBZUY",
        "name": "I See You",
        "uri": "spotify:track:6OFXDyfd3QB3DhXGfSBZUY"
      }
    },
    {
      "added_at": "2022-02-11T06:50:15Z",
      "track": {
        "artists": [
          {
            "name": "Em Beihold"
          }
        ],
        "duration_ms": 169237,
        "id": "3o9kpgkIcffx0iSwxhuNI2",
        "name": "Numb Little Bug",
        "uri": "spotify:track:3o9kpgkIcffx0iSwxhuNI2"
      }
    }
  ],
  "next": "https://api.spotify.com/v1/playlists/37i9dQZF1DXarRysLJmuju/tracks?offset=10&limit=5&fields=items(added_at,track(id,name,uri,duration_ms,artists(name))),previous,next&locale=fr-CA,fr;q=0.9,en-CA;q=0.8,en;q=0.7,pt-BR;q=0.6,pt;q=0.5,en-US;q=0.4",
  "previous": "https://api.spotify.com/v1/playlists/37i9dQZF1DXarRysLJmuju/tracks?offset=0&limit=5&fields=items(added_at,track(id,name,uri,duration_ms,artists(name))),previous,next&locale=fr-CA,fr;q=0.9,en-CA;q=0.8,en;q=0.7,pt-BR;q=0.6,pt;q=0.5,en-US;q=0.4"
}
*/
