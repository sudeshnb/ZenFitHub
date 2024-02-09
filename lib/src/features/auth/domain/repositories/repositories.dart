import 'package:zen_fit_hub/src/core/error/functions.dart';
import 'package:zen_fit_hub/src/features/auth/data/models/models.dart';

abstract class AuthRepository {
  EitherString<UserModel> getUser(String id);
  EitherString<bool> addUser(UserModel user);
  EitherString<String> login(String email, String pass);
  EitherString<String> register(String email, String pass);
  EitherString<bool> loginWithFacebook();
  EitherString<bool> loginwithGoogle();
  EitherString<bool> forgotPassword(String email);
}
