// Poultry Trace App - Main Entry Point
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'bootstrap.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Manejo global de errores de Flutter
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('FlutterError: ${details.exception}');
    debugPrint('Stack: ${details.stack}');
  };

  // Manejo de errores asíncronos no capturados
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('PlatformDispatcher Error: $error');
    debugPrint('Stack: $stack');
    return true; // Previene que la app se cierre
  };

  await bootstrap();
  
  runApp(
    const ProviderScope(
      child: PoultryTraceApp(),
    ),
  );
}
