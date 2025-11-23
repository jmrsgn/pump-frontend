import 'package:flutter/material.dart';
import 'package:pump/core/presentation/theme/app_colors.dart';

import '../../constants/app/app_dimens.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final List<BottomNavigationBarItem> items;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.bottomNav,
      items: items,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textHint,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: const IconThemeData(size: AppDimens.dimen28),
      unselectedIconTheme: const IconThemeData(size: AppDimens.dimen24),
    );
  }
}
