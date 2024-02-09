import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:zen_fit_hub/src/core/config/database.helper.dart';
import 'package:zen_fit_hub/src/core/constants/database.dart';
import 'package:zen_fit_hub/src/core/error/functions.dart';
import 'package:zen_fit_hub/src/core/network/network_info.dart';
import 'package:zen_fit_hub/src/features/auth/data/models/models.dart';

class UserRemoteDataSource {
  EitherString<bool> addUser(UserModel user) async {
    try {
      if (await NetworkInfo.isConnected) {
        if (user.id!.isNotEmpty) {
          await AppDB.users.doc(user.id).set(user.toMap());
          await DatabaseHelper.instance.insert(user.toMap());
          return const Left(true);
        }
        return const Right('Not found user.');
      }
      return const Right('Please check your internet connection and try.');
    } catch (e) {
      log(e.toString());
      return const Right('Somethings went wrong.');
    }
  }

  EitherString<UserModel> getUser(String id) async {
    try {
      if (await NetworkInfo.isConnected) {
        final doc = await AppDB.users.doc(id).get();
        Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
        return Left(UserModel.fromMap(json));
      }
      return const Right('Please check your internet connection and try.');
    } catch (e) {
      return const Right('Somethings went wrong.');
    }
  }
}
