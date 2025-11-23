import 'package:flutter/material.dart';
import 'package:pump/core/utils/ui_utils.dart';

import '../../../../../core/constants/app/app_dimens.dart';
import '../../../../../core/presentation/theme/app_colors.dart';
import '../../../../../core/presentation/theme/app_text_styles.dart';
import '../../../domain/entities/exercise.dart';
import '../../../domain/entities/training_day.dart';
import '../../../domain/entities/training_plan.dart';

class TrainingBlockContent extends StatefulWidget {
  final int week;

  const TrainingBlockContent({super.key, required this.week});

  @override
  State<TrainingBlockContent> createState() => _TrainingBlockContentState();
}

class _TrainingBlockContentState extends State<TrainingBlockContent> {
  late TrainingPlan _trainingPlan;
  late Map<String, List<List<TextEditingController>>> weightControllers;
  late Map<String, List<List<TextEditingController>>> repsControllers;

  @override
  void initState() {
    super.initState();
    _trainingPlan = _createTrainingPlan();
    _initControllers();
  }

  void _initControllers() {
    weightControllers = {};
    repsControllers = {};

    for (var day in _trainingPlan.days) {
      weightControllers[day.name] = [];
      repsControllers[day.name] = [];

      for (var exercise in day.exercises) {
        weightControllers[day.name]!.add(
          List.generate(
            exercise.sets,
            (i) => TextEditingController(text: exercise.weight[i].toString()),
          ),
        );
        repsControllers[day.name]!.add(
          List.generate(
            exercise.sets,
            (i) => TextEditingController(text: exercise.reps),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    for (var dayControllers in weightControllers.values) {
      for (var row in dayControllers) {
        for (var c in row) c.dispose();
      }
    }
    for (var dayControllers in repsControllers.values) {
      for (var row in dayControllers) {
        for (var c in row) c.dispose();
      }
    }
    super.dispose();
  }

  TrainingPlan _createTrainingPlan() {
    return TrainingPlan(
      planName: 'PPL-Full Body 4-Day Split',
      schedule: "D1-D2-D3-REST-D4",
      noOfWeeks: 12,
      days: [
        TrainingDay(
          name: "Day 1 Pull",
          exercises: [
            Exercise(
              name: "Chest Supported Upperback Rows",
              sets: 3,
              reps: "8-10",
              weight: [55, 55, 52.5],
            ),
            Exercise(
              name: "Upperback Pulldown",
              sets: 3,
              reps: "8-10",
              weight: [25, 21.25, 21.25],
            ),
            Exercise(
              name: "Single Arm Cable Rows",
              sets: 3,
              reps: "8-10",
              weight: [17.5, 17.5, 17.5],
            ),
            Exercise(
              name: "Single Arm Pulldown",
              sets: 3,
              reps: "8-10",
              weight: [17.5, 17.5, 17.5],
            ),
            Exercise(
              name: "Cable Lat Prayers",
              sets: 3,
              reps: "10-12",
              weight: [15, 15, 12.5],
            ),
          ],
        ),
        TrainingDay(
          name: "Day 2 Legs",
          exercises: [
            Exercise(
              name: "Leg Curls",
              sets: 3,
              reps: "10-12",
              weight: [35, 35, 32.5],
            ),
            Exercise(
              name: "Pause Rep Leg Press",
              sets: 3,
              reps: "10-12",
              weight: [127, 127, 127],
            ),
          ],
        ),
      ],
    );
  }

  void _saveChanges() {
    for (var day in _trainingPlan.days) {
      for (int exIndex = 0; exIndex < day.exercises.length; exIndex++) {
        final exercise = day.exercises[exIndex];
        for (int setIndex = 0; setIndex < exercise.sets; setIndex++) {
          exercise.weight[setIndex] =
              double.tryParse(
                weightControllers[day.name]![exIndex][setIndex].text,
              ) ??
              0;
          exercise.reps = repsControllers[day.name]![exIndex][setIndex].text;
        }
      }
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Training plan saved!')));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiUtils.addVerticalSpaceL(),
              Text(
                _trainingPlan.planName,
                style: AppTextStyles.heading3.copyWith(
                  fontSize: AppDimens.textSize18,
                ),
              ),
              UiUtils.addVerticalSpaceS(),
              Text(_trainingPlan.schedule, style: AppTextStyles.bodySmall),
              UiUtils.addVerticalSpaceXL(),
              const Divider(color: AppColors.divider),
              Column(
                children: _trainingPlan.days.map((day) {
                  return _buildDaySection(day);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDaySection(TrainingDay day) {
    final exercises = day.exercises;

    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent, // removes the top border
      ),
      child: ExpansionTile(
        collapsedIconColor: AppColors.textHint,
        iconColor: AppColors.textOnPrimary,
        title: Text(
          day.name,
          style: AppTextStyles.heading3.copyWith(color: AppColors.textPrimary),
        ),
        initiallyExpanded: true,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Table(
              border: TableBorder.all(color: Colors.grey.shade700),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FixedColumnWidth(200),
                1: FixedColumnWidth(60),
                2: FixedColumnWidth(60),
                3: FixedColumnWidth(60),
                4: FixedColumnWidth(60),
                5: FixedColumnWidth(60),
                6: FixedColumnWidth(60),
                7: FixedColumnWidth(60),
              },
              children: [
                // Header
                TableRow(
                  decoration: BoxDecoration(color: AppColors.surfaceLight),
                  children: [
                    tableCell("EXERCISES"),
                    tableCell("SETS"),
                    tableCell("SET 1"),
                    tableCell("REPS"),
                    tableCell("SET 2"),
                    tableCell("REPS"),
                    tableCell("SET 3"),
                    tableCell("REPS"),
                  ],
                ),
                ...List.generate(exercises.length, (exIndex) {
                  final exercise = exercises[exIndex];
                  List<Widget> cells = [
                    tableCell(exercise.name),
                    tableCell(exercise.sets.toString()),
                  ];

                  for (int setIndex = 0; setIndex < exercise.sets; setIndex++) {
                    cells.add(
                      editableCell(
                        weightControllers[day.name]![exIndex][setIndex],
                        hint: "kg",
                      ),
                    );
                    cells.add(
                      editableCell(
                        repsControllers[day.name]![exIndex][setIndex],
                        hint: "reps",
                      ),
                    );
                  }

                  return TableRow(children: cells);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        text,
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary),
      ),
    );
  }

  Widget editableCell(TextEditingController controller, {String? hint}) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textHint,
          ),
          contentPadding: const EdgeInsets.all(4),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
