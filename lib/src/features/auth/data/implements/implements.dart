import 'package:zen_fit_hub/src/core/error/functions.dart';
import 'package:zen_fit_hub/src/features/auth/data/models/models.dart';

import '../sources/auth.sources.dart';
import '../sources/db.sources.dart';
import '../../domain/repositories/repositories.dart';

class AuthRepositoryImp implements AuthRepository {
  final UserRemoteDataSource userRemoteDataSource = UserRemoteDataSource();
  final AuthRemoteDataSource remoteDataSource = AuthRemoteDataSource();

  @override
  EitherString<bool> forgotPassword(String email) {
    return remoteDataSource.forgotPassword(email);
  }

  @override
  EitherString<UserModel> getUser(String id) {
    return userRemoteDataSource.getUser(id);
  }

  @override
  EitherString<String> login(String email, String pass) {
    return remoteDataSource.logIn(email, pass);
  }

  @override
  EitherString<bool> loginWithFacebook() {
    return remoteDataSource.loginWithFacebook();
  }

  @override
  EitherString<bool> loginwithGoogle() {
    return remoteDataSource.loginwithGoogle();
  }

  @override
  EitherString<String> register(String email, String pass) {
    return remoteDataSource.register(email, pass);
  }

  @override
  EitherString<bool> addUser(UserModel user) {
    return userRemoteDataSource.addUser(user);
  }
}
