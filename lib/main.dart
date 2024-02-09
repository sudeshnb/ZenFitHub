import 'dart:async';
import 'boot.dart';

Future<void> main() async {
  await AppRun.boot(Environment.dev);
}
