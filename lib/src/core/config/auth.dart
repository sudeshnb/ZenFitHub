import 'package:zen_fit_hub/src/features/auth/data/sources/auth.sources.dart';

/// Repository which manages user authentication.
/// you can call Auth.authRepo in the app any palace

class Auth {
  static final authRepo = AuthRemoteDataSource();
  static init() async {
    await authRepo.user.first;
  }
}
