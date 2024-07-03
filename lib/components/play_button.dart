import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback? onTap;
  final double padding;
  final Widget playOrPause;

  const PlayButton({
    super.key,
    required this.height,
    required this.width,
    required this.playOrPause,
    this.onTap,
    this.padding = 7,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      radius: 0,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(padding),
        decoration: const BoxDecoration(
          color: Color(0xff2C2C2C),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: playOrPause,
        ),
      ),
    );
  }
}
