import 'dart:convert';

class ExerciseModel {
  final String image;
  final String name;
  final String kcal;
  final String min;
  final String level;
  final String category;
  final String weight;
  final String discription;
  final String id;

  ExerciseModel({
    required this.image,
    required this.name,
    required this.kcal,
    required this.min,
    required this.level,
    required this.category,
    required this.weight,
    required this.discription,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'name': name,
      'kcal': kcal,
      'min': min,
      'level': level,
      'category': category,
      'weight': weight,
      'discription': discription,
      'id': id,
    };
  }

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      image: map['image'] as String,
      name: map['name'] as String,
      kcal: map['kcal'] as String,
      min: map['min'] as String,
      level: map['level'] as String,
      category: map['category'] as String,
      weight: map['weight'] as String,
      discription: map['discription'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExerciseModel.fromJson(String source) =>
      ExerciseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
