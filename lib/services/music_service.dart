import 'package:alxify/models/alxify_music_model.dart';
import 'package:alxify/network_util/app_client.dart';

class MusicService {
  final client = AppClient.instance;

  Future<AlxifyMusicModel?> getDataForAlixify() async {
    const url =
        'https://spotify23.p.rapidapi.com/search/?type=multi&offset=0&limit=10&numberOfTopResults=5';
    final response =
        await client.get(url: url, queryParameters: {'q': 'Burna boy'});
    if (response != null) {
      return AlxifyMusicModel.fromJson(response);
    }
    return null;
  }

  Future<Map<String, dynamic>?> getTrack(String trackId) async {
    final url = 'https://spotify23.p.rapidapi.com/tracks/?ids=$trackId';
    final response = await client.get(url: url);
    return response;
  }

  Future<Map<String, dynamic>?> getAlbumTracks(String albumId) async {
    final url =
        'https://spotify23.p.rapidapi.com/album_tracks/?id=$albumId&offset=0&limit=300';
    final response = await client.get(url: url);
    return response;
  }
}
