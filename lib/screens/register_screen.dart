import 'package:alxify/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gap(MediaQuery.of(context).padding.top),
              Center(
                child: SvgPicture.asset(
                  "assets/images/alxify.svg",
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const Center(
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xffF2F2F2),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Gap(20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "If You Need Any Support",
                    style: TextStyle(
                      color: Color(0xffE1E1E1),
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    " Click here",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              const Gap(36),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        focusColor: AppColors.primaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                            width: 1,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 29,
                          horizontal: 27,
                        ),
                        hintText: "Full Name",
                        hintStyle: const TextStyle(
                          color: Color(0xffA7A7A7),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xffFFFFFF),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const Gap(14),
                    TextFormField(
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        focusColor: AppColors.primaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                            width: 1,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 29,
                          horizontal: 27,
                        ),
                        hintText: "Enter Email",
                        hintStyle: const TextStyle(
                          color: Color(0xffA7A7A7),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xffFFFFFF),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const Gap(14),
                    TextFormField(
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        focusColor: AppColors.primaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                            width: 1,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 29,
                          horizontal: 27,
                        ),
                        hintText: "Password",
                        hintStyle: const TextStyle(
                          color: Color(0xffA7A7A7),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xffFFFFFF),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fixedSize: const Size(147, 73),
                ),
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                    color: Color(0xffD7D7D7),
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Gap(29),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff5B5B5B),
                            Color(0xff252525),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(9),
                  const Text(
                    "Or",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xffDCDCDC),
                    ),
                  ),
                  const Gap(11),
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff252525),
                            Color(0xff5B5B5B),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/google.svg"),
                  const Gap(58),
                  SvgPicture.asset("assets/icons/apple.svg"),
                ],
              ),
              const Gap(40),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Do You Have An Account?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffDBDBDB),
                    ),
                  ),
                  Gap(4),
                  InkWell(
                    splashFactory: NoSplash.splashFactory,
                    child: Text(
                      " Sign In",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
