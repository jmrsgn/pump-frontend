class Exercise {
  String name;
  int sets;
  String reps;
  List<double> weight; // one entry per set
  String? notes;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'sets': sets,
    'reps': reps,
    'weight': weight,
    'notes': notes,
  };

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    name: json['name'],
    sets: json['sets'],
    reps: json['reps'],
    weight: List<double>.from(json['weight']),
    notes: json['notes'],
  );
}
