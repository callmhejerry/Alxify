import 'package:alxify/providers/auth_provider.dart';
import 'package:alxify/providers/home_provider.dart';
import 'package:alxify/providers/track_player_provider.dart';
import 'package:alxify/screens/app.dart';
import 'package:alxify/screens/register_or_sign_up_screen.dart';
import 'package:alxify/theme/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Alxify());
}

class Alxify extends StatelessWidget {
  const Alxify({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TrackPlayerProvider(),
        ),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.appBackgroundColor,
          fontFamily: "Satoshi",
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthController(),
      ),
    );
  }
}

class AuthController extends StatelessWidget {
  const AuthController({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, _) {
      if (authProvider.isUserLoggedIn()) {
        return const App();
      } else {
        return const RegisterOrSignUpScreen();
      }
    });
  }
}
