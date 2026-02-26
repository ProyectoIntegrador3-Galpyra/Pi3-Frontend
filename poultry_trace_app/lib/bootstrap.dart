import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'config/di/injector.dart';
import 'core/storage/local_db.dart';

Future<void> bootstrap() async {
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Initialize local database
  await LocalDb.init();

  // Setup dependency injection
  await setupInjector();
}
