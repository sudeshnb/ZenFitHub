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
}
