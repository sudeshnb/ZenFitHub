import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  static TextEditingController title = TextEditingController();

  static TextEditingController description = TextEditingController();

  static TextEditingController fat = TextEditingController();

  static TextEditingController carbs = TextEditingController();

  static TextEditingController min = TextEditingController();

  static TextEditingController kcal = TextEditingController();

  static TextEditingController protein = TextEditingController();

  HomeUseCase useCase = HomeUseCase();

  Future<void> init() async {
    emit(
      state.copyWith(
          title: title,
          description: description,
          fat: fat,
          carbs: carbs,
          min: min,
          kcal: kcal,
          protein: protein),
    );
  }

  Future<void> pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    await uploadImage(File(image.path));
  }

  Future<void> uploadImage(File file) async {
    Reference reference =
        FirebaseStorage.instance.ref().child('meals/${file.path}');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    await snapshot.ref
        .getDownloadURL()
        .then((imageUrl) => emit(state.copyWith(image: imageUrl)));
  }

  Future<void> create(BuildContext context) async {
    final response = await useCase.createMeals(mealModel);

    response.fold(
      (l) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Added successfully...!',
          autoCloseDuration: const Duration(seconds: 3),
          showConfirmBtn: false,
        ).then((value) {
          clear();
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
  }

  void clear() {
    title.clear();
    description.clear();
    fat.clear();
    min.clear();
    carbs.clear();
    kcal.clear();
    protein.clear();
    emit(
      state.copyWith(
          title: title,
          description: description,
          fat: fat,
          carbs: carbs,
          min: min,
          kcal: kcal,
          protein: protein,
          image: ''),
    );
  }

  MealModel get mealModel => MealModel(
        image: state.image ?? '',
        name: title.text,
        kcal: kcal.text,
        min: min.text,
        fat: fat.text,
        carbs: carbs.text,
        protein: protein.text,
        discription: description.text,
        id: const Uuid().v1(),
      );
}

class MealState extends Equatable {
  final TextEditingController? title;

  final TextEditingController? description;

  final TextEditingController? fat;

  final TextEditingController? carbs;

  final TextEditingController? min;

  final TextEditingController? kcal;

  final TextEditingController? protein;

  final String? image;

  const MealState({
    this.title,
    this.description,
    this.fat,
    this.carbs,
    this.min,
    this.kcal,
    this.protein,
    this.image,
  });

  @override
  List<Object?> get props =>
      [title, description, fat, carbs, protein, kcal, image, min];

  MealState copyWith({
    TextEditingController? title,
    TextEditingController? description,
    TextEditingController? fat,
    TextEditingController? carbs,
    TextEditingController? protein,
    TextEditingController? min,
    TextEditingController? kcal,
    String? image,
  }) {
    return MealState(
      title: title ?? title,
      description: description ?? description,
      fat: fat ?? fat,
      carbs: carbs ?? carbs,
      min: min ?? min,
      kcal: kcal ?? kcal,
      protein: protein ?? protein,
      image: image ?? this.image,
    );
  }
}
