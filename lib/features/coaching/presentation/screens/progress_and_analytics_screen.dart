import 'package:flutter/material.dart';

import '../../../../core/presentation/theme/app_colors.dart';

class ProgressAndAnalyticsScreen extends StatelessWidget {
  const ProgressAndAnalyticsScreen({super.key});

  final int totalWeeks = 12;
  final double rowHeight = 50; // Fixed height for all rows

  List<String> get weekdays => [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          // Fixed header
          Container(
            color: AppColors.primary,
            child: Row(
              children: const [
                _cell("WEEK", bold: true, width: 120),
                _cell("DATE", bold: true, width: 180),
                _cell("WEIGHT (lbs)", bold: true, width: 120),
                _cell("WEEKLY AVG", bold: true, width: 120),
                _cell("WEEKLY RATE", bold: true, width: 120),
                _cell("NOTE / ADJUSTMENT", bold: true, width: 180),
              ].map((c) => SizedBox(height: 50, child: c)).toList(),
            ),
          ),

          // Scrollable table body
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: _buildAllWeekRows()),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAllWeekRows() {
    List<Widget> rows = [];

    for (int week = 1; week <= totalWeeks; week++) {
      rows.addAll(_buildWeekRows(week));
    }

    return rows;
  }

  List<Widget> _buildWeekRows(int weekNumber) {
    List<Widget> weekRows = [];

    for (int i = 0; i < 7; i++) {
      final dayName = weekdays[i];
      final isFirstRow = i == 0;

      weekRows.add(
        Row(
          children: [
            _cell(isFirstRow ? weekNumber.toString() : "", width: 120),
            _cell("$dayName, October XX, 2025", width: 180),
            _cell(i == 0 ? "###" : "", width: 120),
            _cell(isFirstRow ? "###" : "", width: 120),
            _cell(isFirstRow ? "###" : "", width: 120),
            _cell("", width: 180),
          ].map((c) => SizedBox(height: rowHeight, child: c)).toList(),
        ),
      );
    }

    return weekRows;
  }
}

class _cell extends StatelessWidget {
  final String text;
  final bool bold;
  final double width;

  const _cell(this.text, {this.bold = false, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      alignment: Alignment.center,
      // Center text vertically & horizontally
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade700),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
