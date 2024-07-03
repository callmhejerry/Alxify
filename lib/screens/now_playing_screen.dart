import 'package:alxify/theme/colors.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../providers/track_player_provider.dart';

class NowPlayingScreen extends StatelessWidget {
  final String trackImage;
  final String artist;
  final String trackName;
  const NowPlayingScreen({
    super.key,
    required this.trackImage,
    required this.artist,
    required this.trackName,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("Now playing $trackImage");
    return Scaffold(
      body: Consumer<TrackPlayerProvider>(
        builder: (context, trackPlayerProvider, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27),
            child: Column(
              children: [
                Gap(MediaQuery.of(context).padding.top + 36),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppBackButton(),
                    Text(
                      "Now playing",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffDDDDDD),
                      ),
                    ),
                    Icon(
                      Icons.more_vert,
                      color: Color(0xffdddddd),
                    ),
                  ],
                ),
                const Gap(29),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    trackPlayerProvider.currentPlayingTrack?.trackImage ??
                        trackImage,
                    height: 370,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const Gap(17),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trackName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffDFDFDF),
                            ),
                          ),
                          const Gap(6),
                          Text(
                            artist,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xffBABABA),
                            ),
                          )
                        ],
                      ),
                    ),
                    SvgPicture.asset("assets/icons/fave.svg"),
                  ],
                ),
                const Gap(52),
                StreamBuilder(
                  stream: context
                      .read<TrackPlayerProvider>()
                      .audioPlayer
                      .onPositionChanged,
                  builder: (context, position) {
                    double value;
                    if (context
                                .read<TrackPlayerProvider>()
                                .currentPlayingTrack
                                ?.durationInMs ==
                            null ||
                        position.data == null) {
                      value = 0;
                    } else {
                      value = position.data!.inMilliseconds /
                          context
                              .read<TrackPlayerProvider>()
                              .currentPlayingTrack!
                              .durationInMs;
                    }
                    return LinearProgressIndicator(
                      backgroundColor:
                          const Color(0xff888888).withOpacity(30 / 100),
                      borderRadius: BorderRadius.circular(2),
                      value: value,
                      valueColor: const AlwaysStoppedAnimation(
                        Color(0xffB7B7B7),
                      ),
                    );
                  },
                ),
                const Gap(12),
                StreamBuilder(
                    stream: trackPlayerProvider.audioPlayer.onPositionChanged,
                    builder: (context, position) {
                      final totalPlayDuration = Duration(
                          milliseconds: trackPlayerProvider
                                  .currentPlayingTrack?.durationInMs ??
                              0);
                      final currentPlayDuration = position.data;
                      final totalPlayMinutes = totalPlayDuration.inMinutes;
                      final totalPlaySeconds = totalPlayDuration.inSeconds;
                      final currentPlayMinutes =
                          currentPlayDuration?.inMinutes ?? 0;
                      final currentPlaySeconds =
                          currentPlayDuration?.inSeconds ?? 00;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$currentPlayMinutes:$currentPlaySeconds",
                            style: const TextStyle(
                              color: Color(0xff878787),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "$totalPlayMinutes:${totalPlaySeconds - (totalPlayMinutes * 60)}",
                            style: const TextStyle(
                              color: Color(0xff878787),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          )
                        ],
                      );
                    }),
                const Gap(46),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset("assets/icons/repeat.svg"),
                    SvgPicture.asset("assets/icons/previous.svg"),
                    Container(
                      height: 72,
                      width: 72,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                      child: Center(
                        child: StreamBuilder(
                            stream: context
                                .read<TrackPlayerProvider>()
                                .audioPlayer
                                .onPlayerStateChanged,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data == PlayerState.completed ||
                                    snapshot.data == PlayerState.paused) {
                                  return InkWell(
                                    onTap: () {
                                      context
                                          .read<TrackPlayerProvider>()
                                          .resumeMusic();
                                    },
                                    child: const Icon(
                                      Icons.play_arrow_rounded,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  );
                                }
                                return InkWell(
                                  onTap: () {
                                    context
                                        .read<TrackPlayerProvider>()
                                        .pauseMusic();
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/pause.svg"),
                                );
                              }
                              return SvgPicture.asset("assets/icons/pause.svg");
                            }),
                      ),
                    ),
                    SvgPicture.asset("assets/icons/next.svg"),
                    SvgPicture.asset("assets/icons/shuffle.svg"),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(4 / 100),
        ),
        height: 32,
        width: 32,
        padding: const EdgeInsets.only(left: 6),
        child: const Icon(
          Icons.arrow_back_ios,
          color: Color(0xffDDDDDD),
          size: 20,
        ),
      ),
    );
  }
}
