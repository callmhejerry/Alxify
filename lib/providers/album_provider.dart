import 'package:alxify/services/music_service.dart';
import 'package:flutter/foundation.dart';

class AlbumProvider extends ChangeNotifier {
  MusicService musicService = MusicService();

  bool isFetchingAlbum = true;
  String? errorInFetchingAlbum;
  List<TrackModel> tracks = [];

  Future<void> getAlbumTracksById({required String albumId}) async {
    try {
      final album = await musicService.getAlbumTracks(albumId);
      isFetchingAlbum = false;
      notifyListeners();
      if (album != null) {
        final List rawtracks = album["data"]['album']['tracks']['items'];

        for (var track in rawtracks) {
          final id = (track['track']["uri"] as String).split(":").last;
          final name = track['track']["name"];
          final durationInMs = track['track']["duration"]['totalMilliseconds'];
          final List<String> artists =
              (track['track']['artists']['items'] as List)
                  .map<String>((artist) {
            return artist['profile']['name'];
          }).toList();

          tracks.add(
            TrackModel(
              artists: artists,
              durationInMs: durationInMs,
              id: id,
              name: name,
            ),
          );
        }
      } else {
        errorInFetchingAlbum = "Failed to get albums";
        isFetchingAlbum = false;
        notifyListeners();
      }
    } catch (e) {
      errorInFetchingAlbum = "failed to get tracks";
      isFetchingAlbum = false;
      if (kDebugMode) {
        print(e);
      }
      notifyListeners();
    }
  }
}

class TrackModel {
  final String id;
  final int durationInMs;
  final List<String> artists;
  final String name;

  const TrackModel({
    required this.artists,
    required this.durationInMs,
    required this.id,
    required this.name,
  });
}
