import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pump/core/presentation/theme/app_text_styles.dart';

import '../../utils/navigation_utils.dart';
import '../theme/app_colors.dart';

class CustomScaffold extends StatelessWidget {
  final bool showAppBar;
  final AppBar? appBar;
  final String? appBarTitle;
  final List<Widget>? appBarActions;
  final Widget? appBarLeadingIcon;
  final VoidCallback? onAppBarLeadingIconPressed;

  final bool isLoading;
  final Color? backgroundColor;

  final Widget body;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const CustomScaffold({
    super.key,
    this.showAppBar = true,
    this.appBar,
    this.appBarTitle,
    this.appBarActions,
    this.appBarLeadingIcon,
    this.onAppBarLeadingIconPressed,
    this.isLoading = false,
    this.backgroundColor,
    required this.body,
    this.drawer,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      backgroundColor: backgroundColor,
      appBar: showAppBar
          ? appBar ??
                AppBar(
                  scrolledUnderElevation: 0,
                  elevation: 0,
                  backgroundColor: AppColors.appBar,
                  shadowColor: Colors.transparent,
                  systemOverlayStyle: SystemUiOverlayStyle.light,
                  title: Text(
                    appBarTitle ?? "",
                    style: AppTextStyles.appBarTitle,
                  ),
                  leading:
                      appBarLeadingIcon ??
                      IconButton(
                        onPressed: () {
                          if (appBarLeadingIcon == null) {
                            NavigationUtils.handleBackNavigation(context);
                          } else {
                            onAppBarLeadingIconPressed?.call();
                          }
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                  actions: appBarActions,
                )
          : null,
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
