import 'package:zen_fit_hub/src/core/error/error.dart';
import 'package:zen_fit_hub/src/features/auth/data/models/models.dart';
import 'package:zen_fit_hub/src/features/profile/data/implements/implements.dart';

import '../repositories/repositories.dart';

class GetProfileUseCase {
  final ProfileRepository repository = ProfileRepositoryImp();

  EitherString<bool> delete() {
    return repository.delete();
  }

  EitherString<bool> update(UserModel user) {
    return repository.update(user);
  }
}
