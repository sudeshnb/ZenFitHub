part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<CategoryModel> categoryList;

  final List<ExerciseModel> exerciceList;

  const HomeState({
    this.categoryList = const [],
    this.exerciceList = const [],
  });

  @override
  List<Object?> get props => [categoryList, exerciceList];

  HomeState copyWith({
    List<CategoryModel>? categoryList,
    List<ExerciseModel>? exerciceList,
  }) {
    return HomeState(
      categoryList: categoryList ?? this.categoryList,
      exerciceList: exerciceList ?? this.exerciceList,
    );
  }
}
