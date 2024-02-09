import 'package:zen_fit_hub/src/core/error/functions.dart';

import '../models/model.dart';
import '../../domain/repositories/repository.dart';
import '../sources/source.dart';

class OnBoardRepositoryImplement implements OnBoardRepository {
  OnboardLocalSource source = OnboardLocalSource();
  @override
  EitherString<List<OnBoardModel>> getOnBoardData() {
    return source.getOnBoardData();
  }
}
