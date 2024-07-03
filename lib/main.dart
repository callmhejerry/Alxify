import 'package:alxify/providers/home_provider.dart';
import 'package:alxify/providers/track_player_provider.dart';
import 'package:alxify/screens/app.dart';
import 'package:alxify/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
        )
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
        home: const App(),
      ),
    );
  }
}
