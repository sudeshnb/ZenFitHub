import 'package:zen_fit_hub/src/core/error/functions.dart';
import 'package:zen_fit_hub/src/features/home/data/models/category.dart';
import 'package:zen_fit_hub/src/features/home/data/models/exercise.dart';
import 'package:zen_fit_hub/src/features/home/data/models/meal.dart';

import '../sources/sources.dart';
import '../../domain/repositories/repositories.dart';

class HomeRepositoryImp implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource = HomeRemoteDataSource();

  @override
  EitherString<List<CategoryModel>> getCategories() {
    return remoteDataSource.getCategories();
  }

  @override
  EitherString<List<ExerciseModel>> getExercises() {
    return remoteDataSource.getExercise();
  }

  @override
  EitherString<List<MealModel>> getMeals() {
    return remoteDataSource.getMeals();
  }

  @override
  EitherString<String> createMeals(MealModel model) {
    return remoteDataSource.createMeals(model);
  }

  @override
  EitherString<String> deleteMeals(String id) {
    return remoteDataSource.deleteMeals(id);
  }

  @override
  EitherString<String> updateMeals(MealModel model) {
    return remoteDataSource.updateMeals(model);
  }

  @override
  EitherString<MealModel> getMeal(String id) {
    return remoteDataSource.getMeal(id);
  }
}
