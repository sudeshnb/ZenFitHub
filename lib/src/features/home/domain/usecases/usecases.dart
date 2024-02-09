import 'package:zen_fit_hub/src/core/error/functions.dart';
import 'package:zen_fit_hub/src/features/home/data/implements/implements.dart';
import 'package:zen_fit_hub/src/features/home/data/models/models.dart';

import '../repositories/repositories.dart';

class HomeUseCase {
  final HomeRepository repository = HomeRepositoryImp();

  EitherString<List<CategoryModel>> getCategories() {
    return repository.getCategories();
  }

  EitherString<List<ExerciseModel>> getExersices() {
    return repository.getExercises();
  }

  EitherString<List<MealModel>> getMeals() {
    return repository.getMeals();
  }
}
