import 'package:flutter/material.dart';
import 'package:pump/core/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:pump/core/presentation/widgets/custom_scaffold.dart';
import 'package:pump/features/coaching/presentation/screens/client_info_screen.dart';
import 'package:pump/features/coaching/presentation/screens/client_progress_screen.dart';
import 'package:pump/features/coaching/presentation/screens/training_block_screen.dart';

import '../../../../core/constants/app/app_strings.dart';

class ClientOverviewScreen extends StatefulWidget {
  const ClientOverviewScreen({super.key});

  @override
  State<ClientOverviewScreen> createState() => _ClientOverviewScreenState();
}

enum ClientOverviewTab { clientInfo, progress, trainingBlock }

extension ClientOverviewTabExtension on ClientOverviewTab {
  String get title {
    switch (this) {
      case ClientOverviewTab.clientInfo:
        return AppStrings.clientInfo;
      case ClientOverviewTab.progress:
        return AppStrings.progressAndAnalytics;
      case ClientOverviewTab.trainingBlock:
        return AppStrings.trainingBlock;
    }
  }
}

class _ClientOverviewScreenState extends State<ClientOverviewScreen> {
  ClientOverviewTab _selectedTab = ClientOverviewTab.clientInfo;

  void _onTap(int index) {
    setState(() {
      _selectedTab = ClientOverviewTab.values[index];
    });
  }

  Widget get _currentScreen {
    switch (_selectedTab) {
      case ClientOverviewTab.clientInfo:
        return ClientInfoScreen(onTileTap: _onTap);
      case ClientOverviewTab.progress:
        return const ClientProgressScreen();
      case ClientOverviewTab.trainingBlock:
        return const TrainingBlockScreen();
    }
  }

  late final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: AppStrings.clientInfo,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.show_chart),
      label: AppStrings.progressAndAnalytics,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.fitness_center),
      label: AppStrings.trainingBlock,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: _selectedTab.title,
      body: _currentScreen,
      bottomNavigationBar: CustomBottomNavigationBar(
        items: _items,
        selectedIndex: _selectedTab.index,
        onItemTapped: (int index) => _onTap(index),
      ),
    );
  }
}
