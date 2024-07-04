import 'package:alxify/screens/register_screen.dart';
import 'package:alxify/screens/sign_in_screen.dart';
import 'package:alxify/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class RegisterOrSignUpScreen extends StatelessWidget {
  const RegisterOrSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: SvgPicture.asset("assets/images/Union-1.svg"),
            ),
            Positioned(
              bottom: 0,
              child: SvgPicture.asset(
                "assets/images/Union-2.svg",
              ),
            ),
            Positioned(
              bottom: -95,
              left: 20,
              child: Image.asset(
                "assets/images/dinma-1.png",
                height: 453,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const Gap(175),
                  SizedBox(
                    height: 120,
                    child: SvgPicture.asset(
                      "assets/images/alxify.svg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Gap(58),
                  const Text(
                    "Enjoy Listening To Music",
                    style: TextStyle(
                      color: Color(0xffF2F2F2),
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(18),
                  const Text(
                    "Spotify is a proprietary Swedish audio\nstreaming and media services provider ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffA0A0A0),
                      fontSize: 17,
                    ),
                  ),
                  const Gap(30),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          fixedSize: const Size(147, 73),
                        ),
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Gap(88),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SigninScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            color: Color(0xffD7D7D7),
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
