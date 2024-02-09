import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkInfo {
  static final InternetConnectionChecker connection =
      InternetConnectionChecker();

  static Future<bool> get isConnected => connection.hasConnection;
}
