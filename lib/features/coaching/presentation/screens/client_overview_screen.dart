import 'package:flutter/material.dart';
import 'package:pump/core/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:pump/core/presentation/widgets/custom_scaffold.dart';
import 'package:pump/features/coaching/presentation/screens/client_info_screen.dart';
import 'package:pump/features/coaching/presentation/screens/client_progress_screen.dart';
import 'package:pump/features/coaching/presentation/screens/training_block_screen.dart';

import '../../../../core/constants/app/app_strings.dart';
import '../../../../core/presentation/theme/app_colors.dart';

class ClientOverviewScreen extends StatefulWidget {
  const ClientOverviewScreen({super.key});

  @override
  State<ClientOverviewScreen> createState() => _ClientOverviewScreenState();
}

class _ClientOverviewScreenState extends State<ClientOverviewScreen> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget get _currentScreen {
    switch (_selectedIndex) {
      case 0:
        return ClientInfoScreen(onTileTap: _onTap);
      case 1:
        return const ClientProgressScreen();
      case 2:
        return const TrainingBlockScreen();
      default:
        return const SizedBox();
    }
  }

  late final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Client Info",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.show_chart),
      label: "Progress",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.fitness_center),
      label: "Training Block",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(AppStrings.clientInfo),
      ),
      body: _currentScreen,
      bottomNavigationBar: CustomBottomNavigationBar(
        items: _items,
        selectedIndex: _selectedIndex,
        onItemTapped: (int index) => _onTap(index),
      ),
    );
  }
}
