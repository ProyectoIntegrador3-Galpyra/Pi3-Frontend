import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/loading.dart';
import '../controllers/inventario_foto_controller.dart';

/// Página de revisión del conteo automático
class RevisionConteoPage extends ConsumerStatefulWidget {
  final String galponId;

  const RevisionConteoPage({super.key, required this.galponId});

  @override
  ConsumerState<RevisionConteoPage> createState() => _RevisionConteoPageState();
}

class _RevisionConteoPageState extends ConsumerState<RevisionConteoPage> {
  final _conteoManualController = TextEditingController();
  bool _usarConteoAutomatico = true;

  List<Map<String, double>> _parseBoundingBoxes(dynamic raw) {
    if (raw is! List) return const [];

    final boxes = <Map<String, double>>[];
    for (final item in raw) {
      if (item is! Map) continue;
      final map = item.map((key, value) => MapEntry(key.toString(), value));

      final x = _toDouble(map['x'] ?? map['left'] ?? map['x1']);
      final y = _toDouble(map['y'] ?? map['top'] ?? map['y1']);
      final w = _toDouble(map['w'] ?? map['width']);
      final h = _toDouble(map['h'] ?? map['height']);
      final x2 = _toDouble(map['x2']);
      final y2 = _toDouble(map['y2']);

      if (x == null || y == null) continue;
      final width = (w ?? (x2 != null ? x2 - x : null));
      final height = (h ?? (y2 != null ? y2 - y : null));
      if (width == null || height == null || width <= 0 || height <= 0) {
        continue;
      }

      boxes.add({'x': x, 'y': y, 'w': width, 'h': height});
    }

    return boxes;
  }

  double? _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  bool _esConteoNoConfiable(dynamic conteo) {
    final metadatos = conteo.metadatos;
    if (metadatos == null) return false;

    final modo = (metadatos['modo'] ?? '').toString().toLowerCase();
    final boxes = metadatos['bounding_boxes'];
    final sinBoundingBoxes = boxes is List && boxes.isEmpty;

    // Cuando el backend reporta modo cloud sin detecciones, pedir revisión manual.
    return modo == 'cloud' && sinBoundingBoxes;
  }

  @override
  void initState() {
    super.initState();
    final conteo = ref.read(inventarioFotoControllerProvider).conteoActual;
    if (conteo?.conteoAutomatico != null) {
      _conteoManualController.text = conteo!.conteoAutomatico.toString();
    }
    if (conteo != null && _esConteoNoConfiable(conteo)) {
      _usarConteoAutomatico = false;
    }
  }

  @override
  void dispose() {
    _conteoManualController.dispose();
    super.dispose();
  }

  Future<void> _confirmarConteo() async {
    final conteoFinal = int.tryParse(_conteoManualController.text);
    if (conteoFinal == null || conteoFinal <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingrese un número válido')),
      );
      return;
    }

    // Actualizar conteo manual si fue modificado
    if (!_usarConteoAutomatico) {
      await ref
          .read(inventarioFotoControllerProvider.notifier)
          .actualizarConteoManual(conteoFinal);
    }

    // Navegar a página de resultado
    if (mounted) {
      context.push(RoutePaths.resultadoActualizacionPath(widget.galponId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inventarioFotoControllerProvider);
    final conteo = state.conteoActual;

    if (conteo == null) {
      return AppScaffold(
        title: 'Revisión de Conteo',
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text('No hay conteo para revisar'),
              const SizedBox(height: 24),
              AppButton(
                text: 'Volver a capturar',
                onPressed: () => context.pop(),
              ),
            ],
          ),
        ),
      );
    }

    final conteoNoConfiable = _esConteoNoConfiable(conteo);

    return AppScaffold(
      title: 'Revisión de Conteo',
      body: state.isLoading
          ? const Loading()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image preview (web-safe)
                  if (state.imagePath != null || state.imageBytes != null)
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final boxes = _parseBoundingBoxes(
                            conteo.metadatos?['bounding_boxes'],
                          );

                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                if (state.imageBytes != null)
                                  Image.memory(state.imageBytes!,
                                      fit: BoxFit.cover)
                                else
                                  Container(
                                    color: Colors.grey[100],
                                    alignment: Alignment.center,
                                    child: const Text(
                                        'Vista previa no disponible'),
                                  ),
                                ...boxes.map((box) {
                                  final isNormalized =
                                      box['x']! <= 1.0 && box['y']! <= 1.0;
                                  final left = isNormalized
                                      ? box['x']! * constraints.maxWidth
                                      : box['x']!;
                                  final top = isNormalized
                                      ? box['y']! * constraints.maxHeight
                                      : box['y']!;
                                  final width = isNormalized
                                      ? box['w']! * constraints.maxWidth
                                      : box['w']!;
                                  final height = isNormalized
                                      ? box['h']! * constraints.maxHeight
                                      : box['h']!;

                                  return Positioned(
                                    left: left,
                                    top: top,
                                    width: width,
                                    height: height,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.redAccent,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 24),

                  // Automatic count result
                  Card(
                    color:
                        Theme.of(context).primaryColor.withValues(alpha: 0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.auto_fix_high,
                            size: 40,
                            color: Colors.blue,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Conteo Automático',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${conteo.conteoAutomatico ?? 0}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                          const SizedBox(height: 8),
                          if (conteo.confianza != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getConfianzaColor(conteo.confianza!)
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Confianza: ${(conteo.confianza! * 100).toStringAsFixed(1)}%',
                                style: TextStyle(
                                  color: _getConfianzaColor(conteo.confianza!),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  if (conteoNoConfiable)
                    Card(
                      color: Colors.orange.withValues(alpha: 0.1),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(Icons.warning_amber_rounded,
                                color: Colors.orange),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Conteo automático no confiable para esta imagen. Revise y confirme manualmente.',
                                style: TextStyle(color: Colors.orange),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (conteoNoConfiable) const SizedBox(height: 12),

                  // Manual adjustment toggle
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SwitchListTile(
                            title: const Text('Usar conteo automático'),
                            subtitle: Text(
                              conteoNoConfiable
                                  ? 'Desactivado: requiere revisión manual'
                                  : _usarConteoAutomatico
                                      ? 'El conteo automático se usará como final'
                                      : 'Ingrese el conteo manual corregido',
                            ),
                            value: _usarConteoAutomatico,
                            onChanged: conteoNoConfiable
                                ? null
                                : (value) {
                                    setState(() {
                                      _usarConteoAutomatico = value;
                                      if (value &&
                                          conteo.conteoAutomatico != null) {
                                        _conteoManualController.text =
                                            conteo.conteoAutomatico.toString();
                                      }
                                    });
                                  },
                          ),
                          if (!_usarConteoAutomatico) ...[
                            const Divider(),
                            const SizedBox(height: 12),
                            AppTextField(
                              controller: _conteoManualController,
                              label: 'Conteo Manual',
                              hint: 'Ingrese el conteo corregido',
                              keyboardType: TextInputType.number,
                              prefixIcon: Icons.edit,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    final current = int.tryParse(
                                            _conteoManualController.text) ??
                                        0;
                                    final next = current > 0 ? current - 1 : 0;
                                    setState(() =>
                                        _conteoManualController.text = '$next');
                                  },
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: () {
                                    final current = int.tryParse(
                                            _conteoManualController.text) ??
                                        0;
                                    final next = current + 1;
                                    setState(() =>
                                        _conteoManualController.text = '$next');
                                  },
                                  icon: const Icon(Icons.add_circle_outline),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            if (conteo.conteoAutomatico != null)
                              Builder(
                                builder: (context) {
                                  final manual = int.tryParse(
                                          _conteoManualController.text) ??
                                      0;
                                  final diferencia =
                                      manual - conteo.conteoAutomatico!;
                                  final porcentaje =
                                      conteo.conteoAutomatico! > 0
                                          ? (diferencia.abs() /
                                                  conteo.conteoAutomatico!) *
                                              100
                                          : 0.0;
                                  return Text(
                                    'Diferencia: ${diferencia >= 0 ? '+' : ''}$diferencia (${porcentaje.toStringAsFixed(1)}%)',
                                    style: TextStyle(
                                      color: porcentaje > 10
                                          ? Colors.orange
                                          : Colors.grey,
                                      fontWeight: porcentaje > 10
                                          ? FontWeight.bold
                                          : null,
                                    ),
                                  );
                                },
                              ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Error
                  if (state.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        state.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.pop(),
                          child: const Text('Volver'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: AppButton(
                          text: 'Confirmar Conteo',
                          onPressed: _confirmarConteo,
                          icon: Icons.check,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Color _getConfianzaColor(double confianza) {
    if (confianza >= 0.9) return Colors.green;
    if (confianza >= 0.8) return Colors.amber;
    return Colors.orange;
  }
}
