import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:zen_fit_hub/src/core/constants/database.dart';
import 'package:zen_fit_hub/src/core/error/functions.dart';
import 'package:zen_fit_hub/src/core/network/network_info.dart';
import 'package:zen_fit_hub/src/features/home/data/models/models.dart';

class HomeRemoteDataSource {
  EitherString<List<CategoryModel>> getCategories() async {
    try {
      List<CategoryModel> list = [];
      if (await NetworkInfo.isConnected) {
        await AppDB.categories.get().then((QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            Map<String, dynamic> json = doc.data() as Map<String, dynamic>;

            list.add(CategoryModel.fromMap(json));
          }
        });
        return Left(list);
      }
      return const Right('Please check your internet connection and try.');
    } catch (e) {
      return const Right('Somethings went wrong.');
    }
  }

  EitherString<List<ExerciseModel>> getExercise() async {
    try {
      List<ExerciseModel> list = [];
      if (await NetworkInfo.isConnected) {
        await AppDB.exercise.get().then((QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            Map<String, dynamic> json = doc.data() as Map<String, dynamic>;

            list.add(ExerciseModel.fromMap(json));
          }
        });
        return Left(list);
      }
      return const Right('Please check your internet connection and try.');
    } catch (e) {
      return const Right('Somethings went wrong.');
    }
  }

  EitherString<List<MealModel>> getMeals() async {
    try {
      List<MealModel> list = [];
      if (await NetworkInfo.isConnected) {
        await AppDB.meals.get().then((QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            Map<String, dynamic> json = doc.data() as Map<String, dynamic>;

            list.add(MealModel.fromMap(json));
          }
        });
        return Left(list);
      }
      return const Right('Please check your internet connection and try.');
    } catch (e) {
      return const Right('Somethings went wrong.');
    }
  }

  EitherString<String> createMeals(MealModel model) async {
    try {
      if (await NetworkInfo.isConnected) {
        final image = await uploadImage(model.image);
        await AppDB.meals
            .doc(model.id)
            .set(model.copyWith(image: image).toMap());
        return const Left('Done');
      }
      return const Right('Please check your internet connection and try.');
    } catch (e) {
      return const Right('Somethings went wrong.');
    }
  }

  EitherString<MealModel> getMeal(String id) async {
    try {
      if (await NetworkInfo.isConnected) {
        return await AppDB.meals.doc(id).get().then((doc) {
          if (doc.exists) {
            Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
            return Left(MealModel.fromMap(json));
          }
          return const Right('Somethings went wrong.');
        });
      }
      return const Right('Please check your internet connection and try.');
    } catch (e) {
      return const Right('Somethings went wrong.');
    }
  }

  EitherString<String> updateMeals(MealModel model) async {
    try {
      if (await NetworkInfo.isConnected) {
        await AppDB.meals.doc(model.id).update(model.toMap());

        return const Left('Done');
      }
      return const Right('Please check your internet connection and try.');
    } catch (e) {
      return const Right('Somethings went wrong.');
    }
  }

  EitherString<String> deleteMeals(String id) async {
    try {
      if (await NetworkInfo.isConnected) {
        await AppDB.meals.doc(id).delete();
        return const Left('Done');
      }
      return const Right('Please check your internet connection and try.');
    } catch (e) {
      return const Right('Somethings went wrong.');
    }
  }

  Future<String> uploadImage(String path) async {
    if (path.isEmpty) return path;
    Reference reference = FirebaseStorage.instance.ref().child('meals/$path');
    UploadTask uploadTask = reference.putFile(File(path));
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }
}
