class AlxifyMusicModel {
  final List albums;
  final List artists;
  final List tracks;

  const AlxifyMusicModel(
      {required this.albums, required this.artists, required this.tracks});

  factory AlxifyMusicModel.fromJson(Map<String, dynamic> json) {
    return AlxifyMusicModel(
      albums: json["albums"]["items"],
      artists: json['artists']['items'],
      tracks: json['tracks']['items'],
    );
  }
}
