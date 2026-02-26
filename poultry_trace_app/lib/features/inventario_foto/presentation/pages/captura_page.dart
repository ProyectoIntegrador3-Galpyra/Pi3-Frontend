import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';
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
  String? _imagePath;
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    ref.read(inventarioFotoControllerProvider.notifier).setGalponId(widget.galponId);
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

      if (photo != null) {
        setState(() {
          _imagePath = photo.path;
        });
        ref.read(inventarioFotoControllerProvider.notifier).setImagePath(photo.path);
      }
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

      if (image != null) {
        setState(() {
          _imagePath = image.path;
        });
        ref.read(inventarioFotoControllerProvider.notifier).setImagePath(image.path);
      }
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
        const SnackBar(content: Text('Capture o seleccione una imagen primero')),
      );
      return;
    }

    final success = await ref.read(inventarioFotoControllerProvider.notifier).procesarImagen();

    if (success && mounted) {
      context.push(RoutePaths.revisionConteoPath(widget.galponId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inventarioFotoControllerProvider);

    return AppScaffold(
      title: 'Capturar Inventario',
      body: state.isProcesando
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
                    child: _imagePath != null
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(_imagePath!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() => _imagePath = null);
                                    ref.read(inventarioFotoControllerProvider.notifier)
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
                  AppButton(
                    text: 'Procesar Imagen',
                    onPressed: _imagePath != null ? _procesarImagen : null,
                    icon: Icons.auto_fix_high,
                  ),
                ],
              ),
            ),
    );
  }
}
