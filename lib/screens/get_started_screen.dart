import 'package:alxify/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/dinma.JPG",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
              child: ColoredBox(color: Colors.black.withOpacity(80 / 100))),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(
                MediaQuery.of(context).padding.top + 32,
              ),
              SvgPicture.asset("assets/images/alxify.svg"),
              const Text(
                "Enjoy Listening To Music",
                style: TextStyle(
                  color: Color(0xffDADADA),
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const Gap(21),
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis enim purus sed phasellus. Cursus ornare id scelerisque aliquam.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff797979),
                ),
              ),
              const Gap(37),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(329, 92),
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    color: Color(0xffF6F6F6),
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
