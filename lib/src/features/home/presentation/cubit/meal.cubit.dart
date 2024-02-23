import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:uuid/uuid.dart';
import 'package:zen_fit_hub/src/core/services/navigator.service.dart';
import 'package:zen_fit_hub/src/features/home/data/models/models.dart';
import 'package:zen_fit_hub/src/features/home/domain/usecases/usecases.dart';

class MealCubit extends Cubit<MealState> {
  MealCubit() : super(const MealState());

  HomeUseCase useCase = HomeUseCase();

  getTitle(String? value) {
    emit(state.copyWith(title: value));
  }

  getdescription(String? value) {
    emit(state.copyWith(description: value));
  }

  getfat(String? value) {
    emit(state.copyWith(fat: value));
  }

  getcarbs(String? value) {
    emit(state.copyWith(carbs: value));
  }

  getkcal(String? value) {
    emit(state.copyWith(kcal: value));
  }

  getmin(String? value) {
    emit(state.copyWith(min: value));
  }

  getprotein(String? value) {
    emit(state.copyWith(protein: value));
  }

  Future<void> pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    emit(state.copyWith(image: image.path, file: File(image.path)));
  }

  Future<void> create(BuildContext context) async {
    final id = const Uuid().v1();

    final mealModel = MealModel(
      image: state.image,
      name: state.title,
      kcal: state.kcal,
      min: state.min,
      fat: state.fat,
      carbs: state.carbs,
      protein: state.protein,
      discription: state.description,
      id: id,
    );

    await useCase.createMeals(mealModel).then((response) {
      response.fold(
        (l) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Added successfully...!',
            autoCloseDuration: const Duration(seconds: 3),
            showConfirmBtn: false,
          ).then((value) {
            // clear();
            NavigatorService.goBack();
          });
        },
        (r) => QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Sorry, something went wrong',
          autoCloseDuration: const Duration(seconds: 3),
          showConfirmBtn: false,
        ),
      );
    });
  }
}

class MealState extends Equatable {
  final String title;

  final String description;

  final String fat;

  final String carbs;

  final String min;

  final String kcal;

  final String protein;

  final String image;

  final File? file;

  const MealState({
    this.title = '',
    this.description = '',
    this.fat = '',
    this.carbs = '',
    this.min = '',
    this.kcal = '',
    this.protein = '',
    this.file,
    this.image = '',
  });

  @override
  List<Object?> get props => [
        title,
        description,
        fat,
        carbs,
        protein,
        kcal,
        image,
        min,
        file,
      ];

  MealState copyWith({
    String? title,
    String? description,
    String? fat,
    String? carbs,
    String? protein,
    String? min,
    String? kcal,
    String? image,
    File? file,
  }) {
    return MealState(
      title: title ?? this.title,
      description: description ?? this.description,
      fat: fat ?? this.fat,
      carbs: carbs ?? this.carbs,
      min: min ?? this.min,
      kcal: kcal ?? this.kcal,
      protein: protein ?? this.protein,
      image: image ?? this.image,
      file: file ?? this.file,
    );
  }
}
