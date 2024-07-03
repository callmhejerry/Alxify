import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D0C0C),
      body: Center(
        child: SvgPicture.asset("assets/images/alxify.svg"),
      ),
    );
  }
}
