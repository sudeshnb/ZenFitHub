import 'package:zen_fit_hub/src/core/error/functions.dart';

import '../../data/models/model.dart';

abstract class OnBoardRepository {
  EitherString<List<OnBoardModel>> getOnBoardData();
}
