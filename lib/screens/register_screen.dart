import 'package:alxify/providers/auth_provider.dart';
import 'package:alxify/screens/sign_in_screen.dart';
import 'package:alxify/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController fullNameController;
  late final AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    fullNameController = TextEditingController();
    authProvider = context.read<AuthProvider>();
    authProvider.addListener(listenForErrorInAuthentication);
  }

  void listenForErrorInAuthentication() {
    final authProvider = context.read<AuthProvider>();
    if (authProvider.createUserError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.createUserError!),
        ),
      );
    }
  }

  @override
  void dispose() {
    authProvider.removeListener(listenForErrorInAuthentication);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Center(
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              return Column(
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
                          style: const TextStyle(
                            color: Color(0xffF2F2F2),
                          ),
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
                          controller: emailController,
                          style: const TextStyle(
                            color: Color(0xffF2F2F2),
                          ),
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
                          style: const TextStyle(
                            color: Color(0xffF2F2F2),
                          ),
                          controller: passwordController,
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
                    onPressed: () async {
                      authProvider.createUser(
                        fullName: fullNameController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      fixedSize: const Size(147, 73),
                    ),
                    child: authProvider.isCreatingAccount
                        ? const SpinKitWave(
                            color: Color(0xffD7D7D7),
                            size: 20,
                          )
                        : const Text(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Do You Have An Account?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffDBDBDB),
                        ),
                      ),
                      const Gap(4),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SigninScreen(),
                            ),
                          );
                        },
                        splashFactory: NoSplash.splashFactory,
                        child: const Text(
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
              );
            },
          ),
        ),
      ),
    );
  }
}
