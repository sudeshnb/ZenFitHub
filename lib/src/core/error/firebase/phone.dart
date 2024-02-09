/// {@template log_in_with_email_and_password_failure}
/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
/// {@endtemplate}
class LogInWithPhoneNumberFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithPhoneNumberFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithPhoneNumberFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-phone-number':
        return const LogInWithPhoneNumberFailure(
          'The provided phone number is not valid.',
        );
      case 'user-disabled':
        return const LogInWithPhoneNumberFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithPhoneNumberFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithPhoneNumberFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithPhoneNumberFailure();
    }
  }

  /// The associated error message.
  final String message;
}
