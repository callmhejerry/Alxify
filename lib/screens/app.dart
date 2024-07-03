import 'package:alxify/components/app_bottom_bar.dart';
import 'package:alxify/screens/discovery_screen.dart';
import 'package:alxify/screens/favorites_screen.dart';
import 'package:alxify/screens/profile_screen.dart';
import 'package:alxify/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'home_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<Widget> screens = [
    const HomeScreen(),
    const DiscoveryScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  int selectedItem = 0;

  List<BottomBarItemData> bottomBarItems = [
    BottomBarItemData(
      inactiveIcon: SvgPicture.asset("assets/icons/inactive_home.svg"),
      activeIcon: SvgPicture.asset(
        "assets/icons/home.svg",
      ),
    ),
    BottomBarItemData(
      activeIcon: SvgPicture.asset(
        "assets/icons/discover.svg",
        color: AppColors.primaryColor,
      ),
      inactiveIcon: SvgPicture.asset(
        "assets/icons/discover.svg",
      ),
    ),
    BottomBarItemData(
      inactiveIcon: SvgPicture.asset(
        "assets/icons/fave.svg",
      ),
      activeIcon: SvgPicture.asset(
        "assets/icons/fave.svg",
        color: AppColors.primaryColor,
      ),
    ),
    BottomBarItemData(
      inactiveIcon: SvgPicture.asset(
        "assets/icons/profile.svg",
      ),
      activeIcon: SvgPicture.asset(
        "assets/icons/profile.svg",
        color: AppColors.primaryColor,
      ),
    ),
  ];

  void onTap(int index) {
    setState(() {
      selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedItem],
      bottomNavigationBar: AppBottomBar(
        bottomBarItems: bottomBarItems,
        initialItem: selectedItem,
        onTap: onTap,
      ),
    );
  }
}
