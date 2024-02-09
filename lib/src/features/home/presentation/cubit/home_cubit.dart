import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zen_fit_hub/src/features/home/data/models/models.dart';
import 'package:zen_fit_hub/src/features/home/domain/usecases/usecases.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  HomeUseCase useCase = HomeUseCase();

  Future<void> init() async {
    await getCategories();
    await getExercises();
  }

  Future<void> getCategories() async {
    final response = await useCase.getCategories();
    response.fold(
      (l) => emit(state.copyWith(categoryList: l)),
      (r) => null,
    );
  }

  Future<void> getExercises() async {
    final response = await useCase.getExersices();
    response.fold(
      (l) => emit(state.copyWith(exerciceList: l)),
      (r) => null,
    );
  }
}
