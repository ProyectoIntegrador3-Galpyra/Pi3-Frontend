import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../config/routes/route_paths.dart';
import '../../config/theme/colors.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';

const _kGalpyraPrefix = 'GALPYRA:';

class QrScannerPage extends ConsumerStatefulWidget {
  const QrScannerPage({super.key});

  @override
  ConsumerState<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends ConsumerState<QrScannerPage> {
  bool _handled = false;

  void _onDetect(BarcodeCapture capture) {
    if (_handled) return;
    final raw = capture.barcodes.firstOrNull?.rawValue;
    if (raw == null || raw.isEmpty) return;

    _handled = true;

    final isLoggedIn =
        ref.read(authControllerProvider).isAuthenticated;

    if (raw.startsWith(_kGalpyraPrefix)) {
      final galponId = raw.substring(_kGalpyraPrefix.length);
      if (!isLoggedIn) {
        _showLoginRequired(context);
        _handled = false;
        return;
      }
      context.go(RoutePaths.galponDetailPath(galponId));
    } else {
      _showUnknownQr(context, raw);
      _handled = false;
    }
  }

  void _showLoginRequired(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sesión requerida'),
        content: const Text(
          'Debes iniciar sesión para ver la información del galpón.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go(RoutePaths.login);
            },
            child: const Text('Iniciar sesión'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  void _showUnknownQr(BuildContext context, String value) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('QR no reconocido'),
        content: Text('El código escaneado no corresponde a un galpón GALPyra.\n\nContenido: $value'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Escanear QR de Galpón'),
      ),
      body: Stack(
        children: [
          MobileScanner(onDetect: _onDetect),
          // Guía visual
          Center(
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primary,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: const Text(
              'Apunta al QR del galpón',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
