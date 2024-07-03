import 'package:alxify/models/alxify_music_model.dart';
import 'package:alxify/network_util/network_exceptions.dart';
import 'package:alxify/services/music_service.dart';
import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier {
  MusicService musicService = MusicService();
  bool isLoading = true;
  bool isSuccess = false;
  String? errorMessage;
  AlxifyMusicModel? data;

  Future<void> getHomeData() async {
    try {
      data = await musicService.getDataForAlixify();
      isSuccess = true;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      isSuccess = false;
      if (e is NetworkExceptions) {
        errorMessage = e.message;
      } else {
        errorMessage = "Unknown error";
      }
      notifyListeners();
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
