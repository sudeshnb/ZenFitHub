import 'package:zen_fit_hub/src/core/error/functions.dart';

import 'package:zen_fit_hub/src/features/auth/data/models/models.dart';

import '../sources/sources.dart';
import '../../domain/repositories/repositories.dart';

class ProfileRepositoryImp implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource = ProfileRemoteDataSource();

  @override
  EitherString<bool> delete() {
    return remoteDataSource.delete();
  }

  @override
  EitherString<bool> update(UserModel user) {
    return remoteDataSource.update(user);
  }
}
