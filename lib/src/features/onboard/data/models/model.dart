import 'dart:convert';

class OnBoardModel {
  final String first;
  final String center;
  final String end;

  final String? image;

  OnBoardModel({
    required this.first,
    required this.center,
    required this.end,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first': first,
      'center': center,
      'end': end,
      'image': image,
    };
  }

  factory OnBoardModel.fromMap(Map<String, dynamic> map) {
    return OnBoardModel(
      first: map['first'] as String,
      center: map['center'] as String,
      end: map['end'] as String,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OnBoardModel.fromJson(String source) =>
      OnBoardModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
