import 'dart:convert';

class MealModel {
  final String image;
  final String name;
  final String kcal;
  final String min;
  final String fat;
  final String carbs;
  final String protein;
  final String discription;
  final String id;

  MealModel({
    required this.image,
    required this.name,
    required this.kcal,
    required this.min,
    required this.fat,
    required this.carbs,
    required this.protein,
    required this.discription,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'name': name,
      'kcal': kcal,
      'min': min,
      'fat': fat,
      'carbs': carbs,
      'protein': protein,
      'discription': discription,
      'id': id,
    };
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      image: map['image'] as String,
      name: map['name'] as String,
      kcal: map['kcal'] as String,
      min: map['min'] as String,
      fat: map['fat'] as String,
      carbs: map['carbs'] as String,
      protein: map['protein'] as String,
      discription: map['discription'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MealModel.fromJson(String source) =>
      MealModel.fromMap(json.decode(source) as Map<String, dynamic>);

  MealModel copyWith({
    String? image,
    String? name,
    String? kcal,
    String? min,
    String? fat,
    String? carbs,
    String? protein,
    String? discription,
    String? id,
  }) {
    return MealModel(
      image: image ?? this.image,
      name: name ?? this.name,
      kcal: kcal ?? this.kcal,
      min: min ?? this.min,
      fat: fat ?? this.fat,
      carbs: carbs ?? this.carbs,
      protein: protein ?? this.protein,
      discription: discription ?? this.discription,
      id: id ?? this.id,
    );
  }
}

// List<MealModel> cate = [
//   MealModel(
//     image: 'image',
//     name: 'Healthy balanced vegetarian food',
//     kcal: '110',
//     min: '10',
//     fat: '1.5 g',
//     protein: '10.9 g',
//     carbs: '13.5 g',
//     discription:
//         'There are many variations of passages of Lorem Im available, but the majority have suffered alteration in some form, by injected humour,',
//     id: 'DGdU3HPlrfJrXyorIwBG',
//   ),
//   MealModel(
//     image: 'image',
//     name: 'Healthy balanced vegetarian food',
//     kcal: '135',
//     min: '8',
//     fat: '1.5 g',
//     protein: '10.9 g',
//     carbs: '13.5 g',
//     discription:
//         'There are many variations of passages of Lorem Im available, but the majority have suffered alteration in some form, by injected humour,',
//     id: 'DGdU3HPlrfJrXyorIwBW',
//   ),
//   MealModel(
//     image: 'image',
//     name: 'Healthy balanced vegetarian food',
//     kcal: '135',
//     min: '5',
//     fat: '1.5 g',
//     protein: '10.9 g',
//     carbs: '13.5 g',
//     discription:
//         'There are many variations of passages of Lorem Im available, but the majority have suffered alteration in some form, by injected humour,',
//     id: 'DGdU3HPlrfJrXyorIwBA',
//   ),
//   MealModel(
//     image: 'image',
//     name: 'Healthy balanced vegetarian food',
//     kcal: '185',
//     min: '8',
//     fat: '1.5 g',
//     protein: '10.9 g',
//     carbs: '13.5 g',
//     discription:
//         'There are many variations of passages of Lorem Im available, but the majority have suffered alteration in some form, by injected humour,',
//     id: 'DGdU3HPlrfJrXyorIwBR',
//   ),
// ];
