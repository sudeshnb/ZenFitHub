import 'package:zen_fit_hub/src/core/error/functions.dart';
import 'package:zen_fit_hub/src/features/home/data/models/models.dart';

abstract class HomeRepository {
  EitherString<List<CategoryModel>> getCategories();

  EitherString<List<ExerciseModel>> getExercises();

  EitherString<List<MealModel>> getMeals();

  EitherString<String> createMeals(MealModel model);

  EitherString<String> updateMeals(MealModel model);

  EitherString<MealModel> getMeal(String id);

  EitherString<String> deleteMeals(String id);
}
