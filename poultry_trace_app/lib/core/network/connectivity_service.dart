import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for connectivity service
final connectivityServiceProvider = Provider((ref) => ConnectivityService());

/// Provider for connectivity status stream
final connectivityStatusProvider = StreamProvider<bool>((ref) {
  return ref.watch(connectivityServiceProvider).connectionStream;
});

/// Service to check and monitor network connectivity
class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionController = StreamController<bool>.broadcast();

  Stream<bool> get connectionStream => _connectionController.stream;

  ConnectivityService() {
    _init();
  }

  void _init() {
    _connectivity.onConnectivityChanged.listen((result) {
      _connectionController.add(_isConnected(result));
    });
  }

  /// Check if there's an active internet connection
  Future<bool> hasConnection() async {
    final result = await _connectivity.checkConnectivity();
    return _isConnected(result);
  }

  bool _isConnected(ConnectivityResult result) {
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet;
  }

  /// Get current connectivity type
  Future<String> getConnectionType() async {
    final result = await _connectivity.checkConnectivity();
    
    if (result == ConnectivityResult.wifi) {
      return 'WiFi';
    } else if (result == ConnectivityResult.mobile) {
      return 'Datos móviles';
    } else if (result == ConnectivityResult.ethernet) {
      return 'Ethernet';
    } else {
      return 'Sin conexión';
    }
  }

  void dispose() {
    _connectionController.close();
  }
}
