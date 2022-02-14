class SpotifyUri {
  String uri;

  SpotifyUri(this.uri);

  Map<String, String> toMap() {
    final Map<String, String> data = <String, String>{};
    data['uri'] = uri;
    return data;
  }
}
