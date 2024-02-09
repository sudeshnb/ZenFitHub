import 'package:zen_fit_hub/src/core/error/functions.dart';
import 'package:zen_fit_hub/src/features/home/data/models/models.dart';

abstract class HomeRepository {
  EitherString<List<CategoryModel>> getCategories();

  EitherString<List<ExerciseModel>> getExercises();

  EitherString<List<MealModel>> getMeals();
}
