import 'package:zen_fit_hub/src/core/error/error.dart';
import 'package:zen_fit_hub/src/features/auth/data/models/models.dart';

abstract class ProfileRepository {
  EitherString<bool> delete();

  EitherString<bool> update(UserModel user);
}
