import 'training_day.dart';

class TrainingPlan {
  String planName;
  String schedule;
  List<TrainingDay> days;
  int noOfWeeks;

  TrainingPlan({
    required this.planName,
    required this.schedule,
    required this.days,
    required this.noOfWeeks,
  });

  Map<String, dynamic> toJson() => {
    'planName': planName,
    'schedule': schedule,
    'days': days.map((d) => d.toJson()).toList(),
    'noOfWeeks': noOfWeeks,
  };

  factory TrainingPlan.fromJson(Map<String, dynamic> json) => TrainingPlan(
    planName: json['planName'],
    days: (json['days'] as List).map((d) => TrainingDay.fromJson(d)).toList(),
    schedule: json['schedule'],
    noOfWeeks: json['noOfWeeks'],
  );
}
