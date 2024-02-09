import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zen_fit_hub/src/features/auth/data/models/models.dart';
import 'package:zen_fit_hub/src/features/auth/data/sources/auth.sources.dart';
part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthRemoteDataSource authRepo})
      : _authRepo = authRepo,
        super(
          authRepo.currentUser.isNotEmpty
              ? AppState.authenticated(authRepo.currentUser)
              : AppState.unauthenticated(authRepo.currentUser),
        ) {
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authRepo.user.listen(
      (user) => add(_AppUserChanged(user)),
    );
  }

  final AuthRemoteDataSource _authRepo;
  late final StreamSubscription<UserModel> _userSubscription;

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : AppState.unauthenticated(event.user),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authRepo.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
