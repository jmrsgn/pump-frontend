import 'exercise.dart';

class TrainingDay {
  String name; // e.g., "Day 1 Pull"
  List<Exercise> exercises;

  TrainingDay({
    required this.name,
    required this.exercises,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'exercises': exercises.map((e) => e.toJson()).toList(),
  };

  factory TrainingDay.fromJson(Map<String, dynamic> json) => TrainingDay(
    name: json['name'],
    exercises: (json['exercises'] as List)
        .map((e) => Exercise.fromJson(e))
        .toList(),
  );
}
