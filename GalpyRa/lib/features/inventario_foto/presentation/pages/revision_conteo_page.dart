import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';
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

    final success = await ref
        .read(inventarioFotoControllerProvider.notifier)
        .confirmarInventario(conteoFinal);

    if (!mounted) return;

    if (success) {
      context.pushReplacement(RoutePaths.resultadoActualizacionPath(widget.galponId));
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

    final content = state.isLoading
        ? const Loading()
        : SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image preview (web-safe)
                if (state.imagePath != null || state.imageBytes != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.memory(
                      state.imageBytes!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 24),

                // Automatic count result
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A).withOpacity(0.88),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        color: Color(0xFFF5C842),
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${conteo.conteoAutomatico ?? 0}',
                        style: const TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFF5C842),
                        ),
                      ),
                      const Text(
                        'aves detectadas',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Estimación por IA · puede no ser exacto',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white38,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
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
                          TextFormField(
                            controller: _conteoManualController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFD4920A),
                            ),
                            decoration: InputDecoration(
                              labelText: 'Conteo final confirmado',
                              helperText:
                                  'Ajusta si el conteo automático no es exacto',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFFD4920A),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFFD4920A),
                                  width: 2,
                                ),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 20),
                            ),
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
                                final porcentaje = conteo.conteoAutomatico! > 0
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
                      child: ElevatedButton.icon(
                        onPressed: _confirmarConteo,
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text('Confirmar conteo'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );

    return AppScaffold(
      title: 'Revisión de Conteo',
      body: content
          .animate()
          .fadeIn(duration: 200.ms)
          .slideY(begin: 0.04, end: 0, duration: 200.ms, curve: Curves.easeOut),
    );
  }
}
