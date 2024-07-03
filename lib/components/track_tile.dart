import 'package:alxify/providers/track_player_provider.dart';
import 'package:alxify/screens/now_playing_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'play_button.dart';

class TrackTile extends StatelessWidget {
  final String name;
  final String artist;
  final Duration duration;
  final String trackImage;
  final String trackId;

  const TrackTile({
    super.key,
    required this.trackImage,
    required this.artist,
    required this.name,
    required this.duration,
    required this.trackId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      onTap: () {
        context.read<TrackPlayerProvider>().playMusic(trackId: trackId);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NowPlayingScreen(
              artist: artist,
              trackImage: trackImage,
              trackName: name,
            ),
          ),
        );
      },
      child: Row(
        children: [
          Consumer<TrackPlayerProvider>(
            builder: (context, trackProvider, _) {
              return StreamBuilder(
                stream: trackProvider.audioPlayer.onPlayerStateChanged,
                builder: (context, playerState) {
                  if (trackId == trackProvider.currentPlayingTrack?.id) {
                    if (playerState.data == PlayerState.playing) {
                      return PlayButton(
                        height: 37,
                        playOrPause: const Icon(
                          Icons.pause,
                          color: Color(0xFF969696),
                          size: 20,
                        ),
                        width: 37,
                        onTap: () {
                          trackProvider.pauseMusic();
                        },
                      );
                    } else {
                      return PlayButton(
                        height: 37,
                        playOrPause: SvgPicture.asset(
                          "assets/icons/play.svg",
                        ),
                        width: 37,
                        onTap: () {
                          trackProvider.resumeMusic();
                        },
                      );
                    }
                  } else {
                    return PlayButton(
                      height: 37,
                      playOrPause: SvgPicture.asset(
                        "assets/icons/play.svg",
                      ),
                      width: 37,
                      onTap: () {
                        trackProvider.playMusic(trackId: trackId);
                      },
                    );
                  }
                },
              );
            },
          ),
          const Gap(23),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffD6D6D6),
                  ),
                ),
                const Gap(5),
                Text(
                  artist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xffD6D6D6),
                  ),
                )
              ],
            ),
          ),
          const Gap(10),
          Text(
            "${duration.inMinutes}:${duration.inSeconds - (duration.inMinutes * 60)}",
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xffD6D6D6),
            ),
          ),
          const Gap(49),
          SvgPicture.asset("assets/icons/fave_filled.svg"),
        ],
      ),
    );
  }
}
