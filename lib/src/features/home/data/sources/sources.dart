import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
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
}
