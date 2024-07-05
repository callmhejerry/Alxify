import 'package:alxify/models/alxify_music_model.dart';
import 'package:alxify/providers/album_provider.dart';
import 'package:alxify/providers/home_provider.dart';
import 'package:alxify/providers/track_player_provider.dart';
import 'package:alxify/screens/album_screen.dart';
import 'package:alxify/screens/now_playing_screen.dart';
import 'package:alxify/theme/colors.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../components/new_album_banner.dart';
import '../components/play_button.dart';
import '../components/track_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeProvider>().getHomeData();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.appBackgroundColor,
        actions: const [
          Icon(Icons.more_vert),
          Gap(10),
        ],
        leading: SvgPicture.asset(
          "assets/icons/search.svg",
          fit: BoxFit.scaleDown,
        ),
        title: SvgPicture.asset(
          "assets/images/alxify.svg",
          height: 150,
        ),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, _) {
          if (homeProvider.isSuccess && homeProvider.data != null) {
            return HomeSuccessScreen(data: homeProvider.data!);
          } else {
            if (homeProvider.isLoading) {
              return const Center(
                child: SpinKitFadingFour(
                  size: 25,
                  color: Color(0xff959595),
                ),
              );
            } else {
              return Center(
                child: Text(
                  homeProvider.errorMessage ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffE1E1E1),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}

class HomeSuccessScreen extends StatelessWidget {
  final AlxifyMusicModel data;
  const HomeSuccessScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            const SliverGap(20),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: NewAlbumBanner(
                  name: data.albums[0]['data']['name'],
                  albumImageUrl: data.albums[0]['data']['coverArt']['sources']
                      [0]['url'],
                  artist: data.albums[0]['data']['artists']['items'][0]
                      ['profile']['name'],
                ),
              ),
            ),
            const SliverGap(40),
            const SliverToBoxAdapter(child: Categories()),
            const SliverGap(28),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 250,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      splashFactory: NoSplash.splashFactory,
                      splashColor: Colors.transparent,
                      onTap: () {
                        String albumId = data.albums[index]['data']['uri'];
                        albumId = albumId.split(":").last;
                        debugPrint(albumId);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider.value(
                              value: AlbumProvider(),
                              child: AlbumScreen(
                                albumCoverArt: data.albums[index]['data']
                                    ['coverArt']['sources'][0]['url'],
                                name: data.albums[index]['data']['name'],
                                albumId: albumId,
                                owner: data.albums[index]['data']['artists']
                                    ['items'][0]['profile']['name'],
                              ),
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: 147,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.network(
                                    data.albums[index]['data']['coverArt']
                                        ['sources'][0]['url'],
                                    height: 185,
                                    width: 147,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: -9,
                                  right: 11,
                                  child: PlayButton(
                                    height: 29,
                                    width: 29,
                                    playOrPause: SvgPicture.asset(
                                      "assets/icons/play.svg",
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const Gap(4),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                data.albums[index]['data']['name'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xffE1E1E1),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Gap(3),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                data.albums[index]['data']['artists']['items']
                                    [0]['profile']['name'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xffE1E1E1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Gap(14);
                  },
                  itemCount: data.albums.take(5).length,
                ),
              ),
            ),
            const SliverGap(25),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tracks",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xffDBDBDB),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See More",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xffC6C6C6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverGap(23),
            SliverList.separated(
              itemCount: data.tracks.take(10).length,
              itemBuilder: (context, index) {
                final track = data.tracks[index];
                debugPrint(track['data']['albumOfTrack']["coverArt"]["sources"]
                    [0]['url']);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: TrackTile(
                    trackId: track['data']['id'],
                    name: track['data']['name'],
                    trackImage: track['data']['albumOfTrack']["coverArt"]
                        ["sources"][0]['url'],
                    duration: Duration(
                      milliseconds: track['data']['duration']
                          ['totalMilliseconds'],
                    ),
                    artist: (track['data']['artists']['items'] as List)
                        .map((artist) => artist['profile']['name'])
                        .join(', '),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Gap(19);
              },
            ),
            if (context.read<TrackPlayerProvider>().currentPlayingTrack == null)
              const SliverGap(16),
            if (context.read<TrackPlayerProvider>().currentPlayingTrack != null)
              const SliverGap(70),
          ],
        ),
        StreamBuilder(
          stream: context
              .read<TrackPlayerProvider>()
              .audioPlayer
              .onPlayerStateChanged,
          builder: (context, playState) {
            final currentPlayingTrack =
                context.read<TrackPlayerProvider>().currentPlayingTrack;
            switch (playState.data) {
              case PlayerState.paused:
              case PlayerState.completed:
              case PlayerState.playing:
                return Positioned(
                  bottom: 5,
                  left: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      context
                          .read<TrackPlayerProvider>()
                          .playMusic(trackId: currentPlayingTrack!.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NowPlayingScreen(
                            trackImage: currentPlayingTrack.trackImage,
                            artist: currentPlayingTrack.artists,
                            trackName: currentPlayingTrack.trackName,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFF4D4D4D),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  currentPlayingTrack?.trackImage ?? "",
                                  height: 47,
                                  width: 42,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentPlayingTrack?.trackName ?? "",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const Gap(2),
                                    Text(
                                      currentPlayingTrack?.artists ?? "",
                                      style: const TextStyle(
                                        color: Color(0xffF2F2F2),
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Gap(10),
                              if (playState.data == PlayerState.playing)
                                InkWell(
                                  onTap: () async {
                                    context
                                        .read<TrackPlayerProvider>()
                                        .pauseMusic();
                                  },
                                  child: const Icon(
                                    Icons.pause,
                                    size: 30,
                                    color: Color(0xFF969696),
                                  ),
                                ),
                              if (playState.data == PlayerState.completed ||
                                  playState.data == PlayerState.paused)
                                InkWell(
                                  onTap: () async {
                                    context
                                        .read<TrackPlayerProvider>()
                                        .resumeMusic();
                                  },
                                  child: const Icon(
                                    Icons.play_arrow_rounded,
                                    size: 30,
                                    color: Color(0xFF969696),
                                  ),
                                ),
                              const Gap(10)
                            ],
                          ),
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
                                valueColor:
                                    const AlwaysStoppedAnimation(Colors.white),
                                value: value,
                                color: Colors.amber,
                                minHeight: 3,
                                borderRadius: BorderRadius.circular(50),
                                backgroundColor: const Color(0xFF969696),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int selectedCategory = 0;

  List<String> categories = ["Albums", "Podcasts", "Episodes", "Audio Books"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const Gap(47),
        itemBuilder: (context, index) {
          return IntrinsicWidth(
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              onTap: () {
                setState(() {
                  selectedCategory = index;
                });
              },
              child: Column(
                children: [
                  Text(
                    categories[index],
                    style: TextStyle(
                      color: selectedCategory == index
                          ? const Color(0xffDBDBDB)
                          : const Color(0xff616161),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(2),
                  if (selectedCategory == index)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.5),
                      child: Container(
                        height: 3,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
