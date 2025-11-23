import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final AppBar? appBar;
  final bool isLoading;
  final Widget? drawer;
  final VoidCallback? onLeadingPressed;
  final Widget? leadingIcon;
  final Widget? bottomNavigationBar;

  const CustomScaffold({
    super.key,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.backgroundColor = AppColors.background,
    this.appBar,
    this.isLoading = false,
    this.drawer,
    this.onLeadingPressed,
    this.leadingIcon,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      backgroundColor: backgroundColor,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Stack(
        children: [
          SafeArea(child: body),

          // Loading overlay
          if (isLoading)
            Container(
              color: AppColors.overlay,
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
