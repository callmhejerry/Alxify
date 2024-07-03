import 'package:alxify/services/music_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class TrackPlayerProvider extends ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();
  final MusicService musicService = MusicService();
  bool loadingMusic = true;
  CurrentPlayingTrack? currentPlayingTrack;

  void playMusic({required String trackId}) async {
    try {
      final apiResponse = await musicService.getTrack(trackId);
      loadingMusic = false;

      if (apiResponse != null) {
        final track = apiResponse['tracks'][0];
        final musicUrl = track['preview_url'];
        final artists = (track['artists'] as List)
            .map((artist) => artist["name"])
            .join(", ");
        final durationInMs = track["duration_ms"];
        final trackImage = track['album']['images'][0]['url'];
        final trackName = track['name'];

        currentPlayingTrack = CurrentPlayingTrack(
          artists: artists,
          durationInMs: durationInMs,
          id: trackId,
          trackImage: trackImage,
          trackName: trackName,
          trackUrl: musicUrl,
        );

        notifyListeners();
        await audioPlayer.play(
          UrlSource(musicUrl),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void pauseMusic() async {
    await audioPlayer.pause();
  }

  void resumeMusic() async {
    await audioPlayer.resume();
  }
}

class CurrentPlayingTrack {
  final String id;
  final int durationInMs;
  final String trackImage;
  final String trackName;
  final String artists;
  final String trackUrl;
  const CurrentPlayingTrack({
    required this.artists,
    required this.durationInMs,
    required this.trackImage,
    required this.trackName,
    required this.id,
    required this.trackUrl,
  });
}
