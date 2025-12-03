import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/app/ui_constants.dart';

class TimeUtils {
  TimeUtils._();

  // Converts a DateTime to a relative time string (e.g., 15m, 2d)
  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }

  static String timeAgoFromString(String isoDate) {
    return timeAgo(DateTime.parse(isoDate));
  }
}

mixin RebuildEveryMinute<T extends StatefulWidget> on State<T> {
  late Timer _timer;

  void startMinuteRebuild() {
    _timer = Timer.periodic(Duration(minutes: UIConstants.minute1), (_) {
      if (mounted) setState(() {});
    });
  }

  void stopMinuteRebuild() {
    _timer.cancel();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
