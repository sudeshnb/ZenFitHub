import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'src/core/config/config.dart';
import 'zen.dart';

class AppRun {
  ///
  static Future<void> boot(Environment env) async {
    await runZonedGuarded<Future<void>>(
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        await DependencyInjection.init();
        flutterLogError();
        runApp(const RootApp());
      },
      (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
    );
  }

  static void flutterLogError() {
    FlutterError.onError = (details) {
      log(details.exceptionAsString(), stackTrace: details.stack);
    };
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('An error occurred'),
        ),
        body: Center(child: Text(details.toString())),
      );
    };
    Logger.root.level = Level.INFO;
    Logger.root.onRecord.listen((record) {
      if (kDebugMode) {
        print('${record.level.name}: ${record.time}: ${record.message}');
      }
    });
  }
}

enum Environment { dev, prod, test }
