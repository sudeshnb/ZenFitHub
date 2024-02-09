import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zen_fit_hub/src/core/services/services.dart';
import 'package:zen_fit_hub/src/features/auth/data/models/models.dart';
import 'package:zen_fit_hub/src/features/auth/domain/usecases/usecases.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());
  final GetAuthUseCase _authRepo = GetAuthUseCase();

  Future<void> init() async {
    final userID = StorageService.userID;
    if (userID.isNotEmpty) {
      final response = await _authRepo.getUser(userID);
      response.fold(
        (user) => emit(UserState(user: user)),
        (r) => null,
      );
    }
  }
}

class UserState extends Equatable {
  final UserModel? user;

  const UserState({this.user});

  @override
  List<Object?> get props => [user];
}
