import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../components/track_tile.dart';
import 'now_playing_screen.dart';

class ArtistProfileScreen extends StatelessWidget {
  const ArtistProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> albums = [
      {
        "image": "assets/images/billie_eilish.png",
        "name": "Lilbubblegum",
      },
      {
        "image": "assets/images/happier.png",
        "name": "Happier Than Ever",
      },
      {
        "image": "assets/images/smile.png",
        "name": "Dont Smile",
      },
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverGap(MediaQuery.of(context).padding.top),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  child: Image.asset(
                    "assets/images/billie_eilish.png",
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    // alignment: Alignment.center,
                  ),
                ),
                const Positioned(
                  left: 22,
                  right: 22,
                  top: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppBackButton(),
                      Icon(
                        Icons.more_vert,
                        color: Color(0xffdddddd),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SliverGap(12),
          const SliverToBoxAdapter(
            child: Column(
              children: [
                Text(
                  "Billie Eilish",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffE3E3E3),
                  ),
                ),
                Gap(6),
                Text(
                  "2 Albums, 67 Tracks",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xffD3D3D3),
                  ),
                ),
                Gap(10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 64),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Turpis adipiscing vestibulum orci enim, nascetur vitae ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xffA7A7A7),
                    ),
                  ),
                ),
                Gap(2),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28),
                    child: Text(
                      "Albums",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffDDDDDD),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SliverGap(17),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          albums[index]["image"]!,
                          height: 135,
                          width: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Gap(18),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          albums[index]["name"]!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xffD1D1D1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const Gap(16);
                },
                itemCount: albums.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Text(
                "Songs",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffCBCBCB),
                ),
              ),
            ),
          ),
          const SliverGap(14),
          SliverList.separated(
            itemCount: 5,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: TrackTile(
                  artist: "",
                  trackImage: "",
                  name: "",
                  trackId: '',
                  duration: Duration.zero,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Gap(19);
            },
          ),
        ],
      ),
    );
  }
}
