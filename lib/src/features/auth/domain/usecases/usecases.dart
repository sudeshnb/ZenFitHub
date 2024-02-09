import 'package:zen_fit_hub/src/core/error/error.dart';
import 'package:zen_fit_hub/src/features/auth/data/implements/implements.dart';
import 'package:zen_fit_hub/src/features/auth/data/models/models.dart';

import '../repositories/repositories.dart';

class GetAuthUseCase {
  final AuthRepository repository = AuthRepositoryImp();

  EitherString<UserModel> getUser(String id) {
    return repository.getUser(id);
  }

  EitherString<bool> addUser(UserModel user) {
    return repository.addUser(user);
  }

  EitherString<String> login(String email, String pass) {
    return repository.login(email, pass);
  }

  EitherString<String> register(String email, String pass) {
    return repository.register(email, pass);
  }

  EitherString<bool> loginWithFacebook() {
    return repository.loginWithFacebook();
  }

  EitherString<bool> loginwithGoogle() {
    return repository.loginwithGoogle();
  }

  EitherString<bool> forgotPassword(String email) {
    return repository.forgotPassword(email);
  }
}
