abstract class Failure {}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {}

class UnexpectedFailure extends Failure {}

class UserNotFindFailure extends Failure {}

class FirebaseFailure extends Failure {
  final String code;
  FirebaseFailure({required this.code});
}

class FailuresToString {
  ///
  static String message(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return 'Please check your internet connection and try again.';
      case UnexpectedFailure _:
        return 'Unknown error. Please try again.';
      case const (CacheFailure):
        return 'Cache Failure';
      case UserNotFindFailure _:
        return "Can't find the user. Please try again.";
      case FirebaseFailure _:
        return 'Server-side error. Please try again.';
      default:
        return 'Unexpected error';
    }
  }
}
