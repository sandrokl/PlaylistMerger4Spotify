import 'package:drift/drift.dart';

class Tracks extends Table {
  TextColumn get playlistId => text()();
  TextColumn get trackId => text()();
  TextColumn get name => text()();
  TextColumn get trackArtists => text()();
  TextColumn get trackUri => text()();
  IntColumn get durationMs => integer()();

  @override
  Set<Column> get primaryKey => {playlistId, trackId};
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