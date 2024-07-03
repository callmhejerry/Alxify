import 'package:alxify/screens/now_playing_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const AppBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/billie.png",
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: double.infinity,
                    ),
                  ),
                  const Gap(16),
                  const Text(
                    "Purpose - Billie Eilish",
                    style: TextStyle(
                      color: Color(0xffDFDFDF),
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                ],
              ),
            ),
            SliverList.separated(
              itemBuilder: (context, index) {
                return const SizedBox();
              },
              separatorBuilder: (context, index) => const Gap(16),
              itemCount: 2,
            )
          ],
        ),
      ),
    );
  }
}
