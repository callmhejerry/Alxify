import 'package:alxify/models/album_model.dart';

class TrackModel {
  final String trackUrl;
  final int trackNumber;
  final String name;
  final String id;
  final String durationMs;
  final List<ArtistModel> artists;

  const TrackModel({
    required this.trackUrl,
    required this.trackNumber,
    required this.artists,
    required this.durationMs,
    required this.id,
    required this.name,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      trackUrl: json['preview_url'],
      trackNumber: json['track_number'],
      artists: ArtistModel.fromList(json['artists']),
      durationMs: json['duration_ms'],
      id: json['id'],
      name: json['name'],
    );
  }

  static List<TrackModel> fromList(List<Map<String, dynamic>> tracks) {
    return tracks.map((track) => TrackModel.fromJson(track)).toList();
  }
}
