import 'dart:io';
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

  @override
  void initState() {
    super.initState();
    final conteo = ref.read(inventarioFotoControllerProvider).conteoActual;
    if (conteo?.conteoAutomatico != null) {
      _conteoManualController.text = conteo!.conteoAutomatico.toString();
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
      await ref.read(inventarioFotoControllerProvider.notifier)
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

    return AppScaffold(
      title: 'Revisión de Conteo',
      body: state.isLoading
          ? const Loading()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image preview
                  if (state.imagePath != null)
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(state.imagePath!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),

                  // Automatic count result
                  Card(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
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
                            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
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
                                color: _getConfianzaColor(conteo.confianza!).withValues(alpha: 0.1),
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
                              _usarConteoAutomatico
                                  ? 'El conteo automático se usará como final'
                                  : 'Ingrese el conteo manual corregido',
                            ),
                            value: _usarConteoAutomatico,
                            onChanged: (value) {
                              setState(() {
                                _usarConteoAutomatico = value;
                                if (value && conteo.conteoAutomatico != null) {
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
                            if (conteo.conteoAutomatico != null)
                              Builder(
                                builder: (context) {
                                  final manual = int.tryParse(_conteoManualController.text) ?? 0;
                                  final diferencia = manual - conteo.conteoAutomatico!;
                                  final porcentaje = conteo.conteoAutomatico! > 0
                                      ? (diferencia.abs() / conteo.conteoAutomatico!) * 100
                                      : 0.0;
                                  return Text(
                                    'Diferencia: ${diferencia >= 0 ? '+' : ''}$diferencia (${porcentaje.toStringAsFixed(1)}%)',
                                    style: TextStyle(
                                      color: porcentaje > 10 ? Colors.orange : Colors.grey,
                                      fontWeight: porcentaje > 10 ? FontWeight.bold : null,
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
