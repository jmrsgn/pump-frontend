import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/app/app_strings.dart';
import '../routes.dart';

enum AppMenuItem {
  coaching(
    title: AppStrings.coaching,
    icon: Icon(FontAwesomeIcons.bolt),
    route: AppRoutes.coaching,
  ),
  profile(
    title: AppStrings.profile,
    icon: Icon(FontAwesomeIcons.user),
    route: AppRoutes.userProfile,
  ),
  messages(
    title: AppStrings.messages,
    icon: Icon(FontAwesomeIcons.message),
    route: AppRoutes.messages,
  ),
  favorites(
    title: AppStrings.likedPosts,
    icon: Icon(FontAwesomeIcons.thumbsUp),
    route: AppRoutes.likedPosts,
  ),
  contact(
    title: AppStrings.contact,
    icon: Icon(FontAwesomeIcons.envelope),
    route: AppRoutes.contact,
  ),
  feedback(
    title: AppStrings.feedback,
    icon: Icon(FontAwesomeIcons.comments),
    route: AppRoutes.feedback,
  ),
  about(
    title: AppStrings.about,
    icon: Icon(FontAwesomeIcons.circleQuestion),
    route: AppRoutes.about,
  );

  final String title;
  final Widget icon;
  final String route;

  const AppMenuItem({
    required this.title,
    required this.icon,
    required this.route,
  });
}
