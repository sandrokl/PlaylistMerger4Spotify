class SpotifyUri {
  String uri;

  SpotifyUri(this.uri);

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uri'] = uri;
    return data;
  }
}
