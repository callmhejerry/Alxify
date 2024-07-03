import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../theme/colors.dart';

class AppBottomBar extends StatefulWidget {
  final List<BottomBarItemData> bottomBarItems;
  final int initialItem;
  final void Function(int) onTap;
  const AppBottomBar({
    super.key,
    required this.bottomBarItems,
    required this.initialItem,
    required this.onTap,
  });

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  late int selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initialItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 44),
      // height: 73,
      decoration: const BoxDecoration(
        color: Color(0xff343434),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          widget.bottomBarItems.length,
          (index) {
            return InkWell(
              splashFactory: NoSplash.splashFactory,
              onTap: () {
                widget.onTap(index);
                setState(() {
                  selectedItem = index;
                });
              },
              child: BottomBarItem(
                activeIcon: widget.bottomBarItems[index].activeIcon,
                inactiveIcon: widget.bottomBarItems[index].inactiveIcon,
                isSelected: index == selectedItem,
              ),
            );
          },
        ),
      ),
    );
  }
}

class BottomBarItemData {
  final Color activeColor;
  final Color inactiveColor;
  final Widget activeIcon;
  final Widget inactiveIcon;

  const BottomBarItemData({
    this.activeColor = AppColors.primaryColor,
    this.inactiveColor = const Color(0xff737373),
    required this.activeIcon,
    required this.inactiveIcon,
  });
}

class BottomBarItem extends StatefulWidget {
  final Color activeColor;
  final Color inactiveColor;
  final Widget activeIcon;
  final Widget inactiveIcon;
  final bool isSelected;
  const BottomBarItem({
    super.key,
    this.activeColor = AppColors.primaryColor,
    this.isSelected = false,
    this.inactiveColor = const Color(0xff737373),
    required this.activeIcon,
    required this.inactiveIcon,
  });

  @override
  State<BottomBarItem> createState() => _BottomBarItemState();
}

class _BottomBarItemState extends State<BottomBarItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 4,
          width: 24,
          decoration: BoxDecoration(
            color: widget.isSelected ? AppColors.primaryColor : null,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        const Gap(19),
        widget.isSelected ? widget.activeIcon : widget.inactiveIcon,
        Gap(MediaQuery.of(context).padding.bottom),
      ],
    );
  }
}
