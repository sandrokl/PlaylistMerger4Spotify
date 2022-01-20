class SpotifyUser {
  late String id;
  late String? name;
  late String? photoUrl;

  SpotifyUser({required this.id, this.name, this.photoUrl});

  SpotifyUser.fromJson(Map<String, dynamic> json) {
    var images = (json['images'] as List<dynamic>).cast<Map<String, dynamic>>();

    id = json['id'];
    name = json['display_name'];
    photoUrl = images.isNotEmpty ? images[0]['url'] : null;
  }
}
