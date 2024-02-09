import 'package:dartz/dartz.dart';
import 'package:zen_fit_hub/src/core/constants/database.dart';
import 'package:zen_fit_hub/src/core/error/error.dart';
import 'package:zen_fit_hub/src/core/network/network_info.dart';
import 'package:zen_fit_hub/src/core/services/services.dart';
import 'package:zen_fit_hub/src/features/auth/data/models/models.dart';
import 'package:zen_fit_hub/src/features/auth/data/sources/auth.sources.dart';

class ProfileRemoteDataSource {
  EitherString<bool> delete() async {
    try {
      if (await NetworkInfo.isConnected) {
        final userID = StorageService.userID;
        await AppDB.users.doc(userID).delete();

        await AuthRemoteDataSource().delete();

        return const Left(true);
      }
      return const Right('Please check your internet connection and try.');
    } catch (e) {
      return const Right('Somethings went wrong.');
    }
  }

  EitherString<bool> update(UserModel user) async {
    try {
      if (await NetworkInfo.isConnected) {
        await AppDB.users.doc(user.id).update(user.toMap());
        return const Left(true);
      }
      return const Right('Please check your internet connection and try.');
    } catch (e) {
      return const Right('Somethings went wrong.');
    }
  }
}
