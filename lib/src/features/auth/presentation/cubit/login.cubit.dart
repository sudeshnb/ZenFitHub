import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zen_fit_hub/src/features/auth/domain/usecases/usecases.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());
  final GetAuthUseCase _authRepo = GetAuthUseCase();
  void email(String? value) {
    emit(state.copyWith(email: value));
  }

  void password(String? value) {
    emit(state.copyWith(password: value));
  }

  void changeVisibility() {
    emit(state.copyWith(isShowPassword: !state.isShowPassword));
  }

  Future<void> login() async {
    emit(state.copyWith(status: LoginStatus.loading));

    final response = await _authRepo.login(state.email, state.password);

    response.fold(
      (id) async {
        final user = await _authRepo.getUser(id);
        user.fold(
          (l) => emit(state.copyWith(status: LoginStatus.done)),
          (r) => emit(state.copyWith(err: (r), status: LoginStatus.error)),
        );
      },
      (failure) {
        emit(state.copyWith(err: (failure), status: LoginStatus.error));
      },
    );
  }

  Future<void> loginWithGoogle() async {
    emit(state.copyWith(status: LoginStatus.loading));
    final response = await _authRepo.loginwithGoogle();
    response.fold(
      (success) => emit(state.copyWith(status: LoginStatus.done)),
      (failure) {
        emit(state.copyWith(err: (failure), status: LoginStatus.error));
      },
    );
  }

  Future<void> loginWithFacebook() async {
    emit(state.copyWith(status: LoginStatus.loading));

    final response = await _authRepo.loginWithFacebook();
    response.fold(
      (success) => emit(state.copyWith(status: LoginStatus.done)),
      (failure) =>
          emit(state.copyWith(err: failure, status: LoginStatus.error)),
    );
  }

  Future<void> restPassword() async {
    emit(state.copyWith(status: LoginStatus.loading));
    final response = await _authRepo.forgotPassword(state.email);
    response.fold(
      (success) => emit(state.copyWith(status: LoginStatus.reset)),
      (failure) =>
          emit(state.copyWith(err: failure, status: LoginStatus.error)),
    );
  }
}

class LoginState extends Equatable {
  final String email;
  final String password;
  final String err;
  final bool isShowPassword;
  final LoginStatus status;

  const LoginState({
    this.email = '',
    this.password = '',
    this.err = '',
    this.isShowPassword = true,
    this.status = LoginStatus.init,
  });
  @override
  List<Object> get props => [email, password, status, err, isShowPassword];

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    String? err,
    bool? isShowPassword,
  }) {
    return LoginState(
      email: email ?? this.email,
      err: err ?? this.err,
      password: password ?? this.password,
      status: status ?? this.status,
      isShowPassword: isShowPassword ?? this.isShowPassword,
    );
  }
}

enum LoginStatus {
  init,
  loading,
  done,
  error,
  reset,
}

extension LoginStatusX on LoginStatus {
  bool get done => this == LoginStatus.done;
  bool get error => this == LoginStatus.error;
  bool get loading => this == LoginStatus.loading;
  bool get reset => this == LoginStatus.reset;
}
