import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../theme/colors.dart';

class NewAlbumBanner extends StatelessWidget {
  final String artist;
  final String name;
  final String albumImageUrl;
  const NewAlbumBanner({
    super.key,
    required this.artist,
    required this.albumImageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
      height: 118,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.primaryColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "New Album",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Color(0xffFBFBFB),
                  ),
                ),
                const Gap(4),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 19,
                    color: Color(0xffFBFBFB),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(4),
                Text(
                  artist,
                  style: const TextStyle(
                    color: Color(0xffFBFBFB),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              albumImageUrl,
              width: 70,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
