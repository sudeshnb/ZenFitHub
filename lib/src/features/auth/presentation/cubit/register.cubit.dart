import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zen_fit_hub/src/core/keys/keys.dart';
import 'package:zen_fit_hub/src/core/services/storage.dart';
import 'package:zen_fit_hub/src/features/auth/data/models/models.dart';
import 'package:zen_fit_hub/src/features/auth/domain/usecases/usecases.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());
  final GetAuthUseCase _authRepo = GetAuthUseCase();
  void changeVisibility() {
    emit(state.copyWith(isShowPassword: !state.isShowPassword));
  }

  void email(String? value) {
    emit(state.copyWith(email: value));
  }

  void password(String? value) {
    emit(state.copyWith(password: value));
  }

  Future<void> register() async {
    emit(state.copyWith(status: RegisterStatus.loading));
    final response = await _authRepo.register(state.email, state.password);

    response.fold(
      (uid) async {
        await StorageService.setString(AppKey.userId, uid);

        final user =
            await _authRepo.addUser(UserModel(id: uid, email: state.email));

        user.fold((l) {
          emit(state.copyWith(status: RegisterStatus.done));
        }, (r) {
          emit(state.copyWith(err: (r), status: RegisterStatus.error));
        });
      },
      (failure) {
        emit(state.copyWith(err: (failure), status: RegisterStatus.error));
      },
    );
  }

  Future<void> loginWithGoogle() async {
    emit(state.copyWith(status: RegisterStatus.loading));
    final response = await _authRepo.loginwithGoogle();
    response.fold(
      (success) => emit(state.copyWith(status: RegisterStatus.done)),
      (failure) {
        emit(state.copyWith(err: (failure), status: RegisterStatus.error));
      },
    );
  }

  Future<void> loginWithFacebook() async {
    emit(state.copyWith(status: RegisterStatus.loading));

    final response = await _authRepo.loginWithFacebook();
    response.fold(
      (success) => emit(state.copyWith(status: RegisterStatus.done)),
      (failure) =>
          emit(state.copyWith(err: failure, status: RegisterStatus.error)),
    );
  }
}

class RegisterState extends Equatable {
  final String email;
  final bool isShowPassword;
  final String password;
  final RegisterStatus status;
  final String err;

  const RegisterState({
    this.email = '',
    this.password = '',
    this.err = '',
    this.isShowPassword = true,
    this.status = RegisterStatus.init,
  });
  @override
  List<Object> get props => [err, email, password, status, isShowPassword];

  RegisterState copyWith({
    String? email,
    bool? isShowPassword,
    String? password,
    RegisterStatus? status,
    String? err,
  }) {
    return RegisterState(
      email: email ?? this.email,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      password: password ?? this.password,
      status: status ?? this.status,
      err: err ?? this.err,
    );
  }
}

enum RegisterStatus { init, loading, done, error }

extension RegisterStatusX on RegisterStatus {
  bool get isDone => this == RegisterStatus.done;
  bool get error => this == RegisterStatus.error;
  bool get loading => this == RegisterStatus.loading;
}
