import 'package:alxify/components/track_tile.dart';
import 'package:alxify/providers/album_provider.dart';
import 'package:alxify/screens/now_playing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class AlbumScreen extends StatefulWidget {
  final String albumId;
  final String name;
  final String owner;
  final String albumCoverArt;

  const AlbumScreen({
    super.key,
    required this.albumId,
    required this.name,
    required this.owner,
    required this.albumCoverArt,
  });

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  void initState() {
    super.initState();
    if (context.read<AlbumProvider>().tracks.isEmpty) {
      context.read<AlbumProvider>().getAlbumTracksById(albumId: widget.albumId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(""),
        leading: const AppBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<AlbumProvider>(
          builder: (context, albumProvider, _) {
            if (albumProvider.isFetchingAlbum) {
              return const Center(
                child: SpinKitFadingFour(
                  color: Color(0xff959595),
                  size: 25,
                ),
              );
            }
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.albumCoverArt,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: double.infinity,
                        ),
                      ),
                      const Gap(16),
                      Text(
                        "${widget.name} - ${widget.owner}",
                        style: const TextStyle(
                          color: Color(0xffDFDFDF),
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                ),
                const SliverGap(16),
                SliverList.separated(
                  itemBuilder: (context, index) {
                    return TrackTile(
                      trackImage: "",
                      artist: albumProvider.tracks[index].artists.join(", "),
                      name: albumProvider.tracks[index].name,
                      duration: Duration(
                          milliseconds:
                              albumProvider.tracks[index].durationInMs),
                      trackId: albumProvider.tracks[index].id,
                    );
                  },
                  separatorBuilder: (context, index) => const Gap(16),
                  itemCount: albumProvider.tracks.length,
                ),
                SliverGap(MediaQuery.of(context).padding.bottom),
              ],
            );
          },
        ),
      ),
    );
  }
}
