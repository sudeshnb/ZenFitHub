import 'package:cloud_firestore/cloud_firestore.dart';

class AppDB {
  static final instance = FirebaseFirestore.instance;

  static CollectionReference users = instance.collection('users');

  ///
  static CollectionReference categories = instance.collection('categories');

  ///
  static CollectionReference exercise = instance.collection('exercise');

  ///
  static CollectionReference meals = instance.collection('meals');

  static CollectionReference onboard = instance.collection('onboard');
}
