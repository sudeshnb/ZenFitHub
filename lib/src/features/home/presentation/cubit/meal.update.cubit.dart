import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:uuid/uuid.dart';
import 'package:zen_fit_hub/src/core/services/services.dart';
import 'package:zen_fit_hub/src/features/home/data/models/models.dart';
import 'package:zen_fit_hub/src/features/home/domain/usecases/usecases.dart';

class MealUpdateCubit extends Cubit<MealUpdateState> {
  MealUpdateCubit() : super(const MealUpdateState());

  static TextEditingController title = TextEditingController();

  static TextEditingController description = TextEditingController();

  static TextEditingController fat = TextEditingController();

  static TextEditingController carbs = TextEditingController();

  static TextEditingController min = TextEditingController();

  static TextEditingController kcal = TextEditingController();

  static TextEditingController protein = TextEditingController();

  HomeUseCase useCase = HomeUseCase();

  Future<void> init(MealModel meal) async {
    title.text = meal.name;
    description.text = meal.discription;
    fat.text = meal.fat;
    carbs.text = meal.carbs;
    min.text = meal.min;
    kcal.text = meal.kcal;
    protein.text = meal.protein;

    emit(
      state.copyWith(
        title: title,
        description: description,
        fat: fat,
        carbs: carbs,
        min: min,
        kcal: kcal,
        protein: protein,
        image: meal.image,
      ),
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

  Future<void> update(BuildContext context, String id) async {
    final response = await useCase.updateMeals(mealModel.copyWith(id: id));
    response.fold(
      (l) => NavigatorService.goBack(),
      (r) => QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Sorry, something went wrong',
      ),
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

class MealUpdateState extends Equatable {
  final TextEditingController? title;

  final TextEditingController? description;

  final TextEditingController? fat;

  final TextEditingController? carbs;

  final TextEditingController? min;

  final TextEditingController? kcal;

  final TextEditingController? protein;

  final String? image;

  const MealUpdateState({
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

  MealUpdateState copyWith({
    TextEditingController? title,
    TextEditingController? description,
    TextEditingController? fat,
    TextEditingController? carbs,
    TextEditingController? protein,
    TextEditingController? min,
    TextEditingController? kcal,
    String? image,
  }) {
    return MealUpdateState(
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
