
// class AlbumModel {
//   final String name;
//   final List<ArtistModel> artists;
//   final List<AlbumImage> coverArts;

//   const AlbumModel({
//     required this.artists,
//     required this.coverArts,
//     required this.name,
//   });

//   factory AlbumModel.fromJson(Map<String, dynamic> json){
//     json = json['data'];
//     return AlbumModel(artists: ArtistModel.fromList(json['artists']['items']), coverArts: coverArts, name: name)
//   }
// }

class ArtistModel {
  final String name;
  final String id;
  final List<AlbumImage> images;

  const ArtistModel({
    required this.id,
    required this.name,
    required this.images,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      id: json['id'],
      name: json['name'],
      images: AlbumImage.fromList(json['visuals']['avatarImage']['sources']),
    );
  }

  static List<ArtistModel> fromList(List artistList) {
    return artistList.map((artist) => ArtistModel.fromJson(artist)).toList();
  }
}

class AlbumImage {
  final int height;
  final int width;
  final String url;

  const AlbumImage(
      {required this.height, required this.url, required this.width});

  factory AlbumImage.fromJson(Map<String, dynamic> json) {
    return AlbumImage(
      height: json["height"],
      url: json["url"],
      width: json['width'],
    );
  }

  static List<AlbumImage> fromList(List images) {
    return images.map((image) => AlbumImage.fromJson(image)).toList();
  }
}
