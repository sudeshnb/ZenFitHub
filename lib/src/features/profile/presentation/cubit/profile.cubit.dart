import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:zen_fit_hub/src/core/config/database.helper.dart';
import 'package:zen_fit_hub/src/core/network/network_info.dart';
import 'package:zen_fit_hub/src/core/services/services.dart';
import 'package:zen_fit_hub/src/features/auth/data/models/models.dart';
import 'package:zen_fit_hub/src/features/profile/domain/usecases/usecases.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  static TextEditingController nameController = TextEditingController();

  static TextEditingController phoneController = TextEditingController();

  static TextEditingController emailController = TextEditingController();

  static TextEditingController ageController = TextEditingController();

  static TextEditingController weightController = TextEditingController();

  static TextEditingController heightController = TextEditingController();

  GetProfileUseCase useCase = GetProfileUseCase();

  init(UserModel? userModel) async {
    if (!await NetworkInfo.isConnected) {
      userModel = await DatabaseHelper.instance.getUser();
    }

    if (userModel == null) return;
    nameController.text = userModel.name ?? '';
    phoneController.text = userModel.phone ?? '';
    emailController.text = userModel.email ?? '';
    ageController.text = (userModel.age ?? '').toString();
    weightController.text = userModel.weight ?? '';
    heightController.text = userModel.height ?? '';

    emit(
      state.copyWith(
        nameController: nameController,
        phoneController: phoneController,
        emailController: emailController,
        ageController: ageController,
        gender: userModel.gender ?? '',
        weight: weightController,
        height: heightController,
        image: userModel.image,
      ),
    );
  }

  gender(String value) {
    emit(state.copyWith(gender: value));
  }

  Future pickImageCamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    await uploadProfileImage(File(image.path));
  }

  uploadProfileImage(File file) async {
    Reference reference =
        FirebaseStorage.instance.ref().child('users/${file.path}');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    await snapshot.ref
        .getDownloadURL()
        .then((imageUrl) => emit(state.copyWith(image: imageUrl)));
  }

  Future<void> save(BuildContext context) async {
    final response = await useCase.update(userModel);

    response.fold(
      (l) async {
        await DatabaseHelper.instance.update(userModel).then(
              (value) => QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: 'Successfully...',
              ),
            );
      },
      (r) => QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Sorry, something went wrong',
      ),
    );
  }

  Future<void> delete(BuildContext context) async {
    final response = await useCase.delete();
    response.fold(
      (l) => QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Successfully...',
      ),
      (r) => QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Sorry, something went wrong...',
        text: r,
      ),
    );
  }

  UserModel get userModel => UserModel(
        id: StorageService.userID,
        age: int.tryParse(ageController.text),
        name: nameController.text,
        phone: phoneController.text,
        email: emailController.text,
        weight: weightController.text,
        height: heightController.text,
        gender: state.gender,
        image: state.image,
      );
}

class ProfileState extends Equatable {
  final TextEditingController? nameController;

  final TextEditingController? phoneController;

  final TextEditingController? emailController;

  final TextEditingController? ageController;

  final TextEditingController? weight;

  final TextEditingController? height;

  final String? gender;

  final String? image;

  const ProfileState({
    this.nameController,
    this.phoneController,
    this.emailController,
    this.ageController,
    this.weight,
    this.height,
    this.gender,
    this.image,
  });

  @override
  List<Object?> get props => [
        nameController,
        phoneController,
        emailController,
        ageController,
        gender,
        height,
        image,
        weight,
      ];

  ProfileState copyWith({
    TextEditingController? nameController,
    TextEditingController? phoneController,
    TextEditingController? emailController,
    TextEditingController? ageController,
    TextEditingController? weight,
    TextEditingController? height,
    String? gender,
    String? image,
  }) {
    return ProfileState(
      nameController: nameController ?? this.nameController,
      phoneController: phoneController ?? this.phoneController,
      emailController: emailController ?? this.emailController,
      ageController: ageController ?? this.ageController,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      gender: gender ?? this.gender,
      image: image ?? this.image,
    );
  }
}
