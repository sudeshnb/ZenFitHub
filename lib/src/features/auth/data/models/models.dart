import 'dart:convert';

class UserModel {
  final String? id;
  final String? image;
  final String? name;
  final String? email;
  final String? phone;
  final int? age;
  final String? gender;
  final String? height;
  final String? weight;

  UserModel({
    this.id,
    this.image,
    this.name,
    this.email,
    this.phone,
    this.age,
    this.gender,
    this.height,
    this.weight,
  });

  /// Empty user which represents an unauthenticated user.
  static UserModel empty = UserModel(
    id: '',
    email: '',
    name: '',
    image: '',
    phone: '',
    age: 0,
    gender: '',
    height: '',
    weight: '',
  );

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == UserModel.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != UserModel.empty;
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'name': name,
      'email': email,
      'phone': phone,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      age: map['age'] != null ? map['age'] as int : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      height: map['height'] != null ? map['height'] as String : null,
      weight: map['weight'] != null ? map['weight'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? id,
    String? image,
    String? name,
    String? email,
    String? phone,
    int? age,
    String? gender,
    String? height,
    String? weight,
  }) {
    return UserModel(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }
}
