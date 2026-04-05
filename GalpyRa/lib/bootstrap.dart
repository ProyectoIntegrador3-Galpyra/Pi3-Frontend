import 'package:flutter/services.dart';
import 'config/di/injector.dart';
import 'core/storage/local_db.dart';

Future<void> bootstrap() async {
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize local database (Drift/SQLite)
  await LocalDb.init();

  // Setup dependency injection
  await setupInjector();
}
