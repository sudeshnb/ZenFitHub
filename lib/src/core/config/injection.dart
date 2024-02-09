import 'package:firebase_core/firebase_core.dart';
import 'package:zen_fit_hub/src/core/services/storage.dart';
import 'firebase.options.dart';

class DependencyInjection {
  static Future<void> init() async {
    //
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await StorageService().init();
  }
}
