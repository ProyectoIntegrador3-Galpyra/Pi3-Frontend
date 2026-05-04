import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/loading.dart';
import '../controllers/inventario_foto_controller.dart';

/// Página de captura de foto para conteo
class CapturaPage extends ConsumerStatefulWidget {
  final String galponId;

  const CapturaPage({super.key, required this.galponId});

  @override
  ConsumerState<CapturaPage> createState() => _CapturaPageState();
}

class _CapturaPageState extends ConsumerState<CapturaPage> {
  final ImagePicker _picker = ImagePicker();
  // Guardamos los bytes para que Image.memory funcione en web y móvil
  Uint8List? _imageBytes;
  String? _imagePath;
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(inventarioFotoControllerProvider.notifier)
          .setGalponId(widget.galponId);
    });
  }

  Future<void> _setImage(XFile file) async {
    final bytes = await file.readAsBytes();
    final filename = file.name.isNotEmpty ? file.name : 'inventario.jpg';
    setState(() {
      _imageBytes = bytes;
      _imagePath = file.path;
    });
    ref.read(inventarioFotoControllerProvider.notifier).setImageData(
          file.path,
          bytes,
          filename,
        );
  }

  Future<void> _captureFromCamera() async {
    setState(() => _isCapturing = true);

    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (photo != null) await _setImage(photo);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al capturar: $e')),
        );
      }
    } finally {
      setState(() => _isCapturing = false);
    }
  }

  Future<void> _pickFromGallery() async {
    setState(() => _isCapturing = true);

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (image != null) await _setImage(image);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al seleccionar: $e')),
        );
      }
    } finally {
      setState(() => _isCapturing = false);
    }
  }

  Future<void> _procesarImagen() async {
    if (_imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Capture o seleccione una imagen primero')),
      );
      return;
    }

    final success = await ref
        .read(inventarioFotoControllerProvider.notifier)
        .procesarImagen();

    if (success && mounted) {
      context.push(RoutePaths.revisionConteoPath(widget.galponId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inventarioFotoControllerProvider);

    final body = state.isProcesando
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Loading(),
                SizedBox(height: 24),
                Text(
                  'Procesando imagen...',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  'Esto puede tomar unos segundos',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        : SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Instructions
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Instrucciones',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          '• Capture una foto clara del galpón\n'
                          '• Asegúrese de buena iluminación\n'
                          '• Incluya la mayor cantidad de aves visibles\n'
                          '• Evite fotos borrosas o con movimiento',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Image preview
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: _imageBytes != null
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              // Image.memory funciona en web y móvil sin dart:io
                              child:
                                  Image.memory(_imageBytes!, fit: BoxFit.cover),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _imageBytes = null;
                                    _imagePath = null;
                                  });
                                  ref
                                      .read(inventarioFotoControllerProvider
                                          .notifier)
                                      .reiniciarConteo();
                                },
                                icon: const Icon(Icons.close),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.black54,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Sin imagen',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                const SizedBox(height: 24),

                // Capture buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _isCapturing ? null : _captureFromCamera,
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Cámara'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _isCapturing ? null : _pickFromGallery,
                        icon: const Icon(Icons.photo_library),
                        label: const Text('Galería'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Error message
                if (state.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      state.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // Process button
                if (_imagePath == null)
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.auto_awesome,
                            color: Colors.grey.shade400, size: 22),
                        const SizedBox(width: 8),
                        Text(
                          'Selecciona una imagen primero',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ElevatedButton.icon(
                    onPressed: _procesarImagen,
                    icon: const Icon(Icons.auto_awesome,
                        color: Colors.white, size: 22),
                    label: const Text(
                      'Procesar imagen con IA',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 60),
                      backgroundColor: const Color(0xFFD4920A),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                      shadowColor: const Color(0xFFD4920A).withOpacity(0.4),
                    ),
                  ),
              ],
            ),
          );

    return AppScaffold(
      title: 'Capturar Inventario',
      body: body
          .animate()
          .fadeIn(duration: 200.ms)
          .slideY(begin: 0.04, end: 0, duration: 200.ms, curve: Curves.easeOut),
    );
  }
}
