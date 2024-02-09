part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

final class AppState extends Equatable {
  const AppState._({
    required this.status,
    required this.user,
  });

  const AppState.authenticated(UserModel user)
      : this._(status: AppStatus.authenticated, user: user);

  AppState.unauthenticated(UserModel? user)
      : this._(
          status: AppStatus.unauthenticated,
          user: user ?? UserModel.empty,
        );

  final AppStatus status;
  final UserModel? user;

  @override
  List<Object?> get props => [status, user];
}
