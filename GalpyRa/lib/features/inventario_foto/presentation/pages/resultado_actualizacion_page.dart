import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/loading.dart';
import '../controllers/inventario_foto_controller.dart';

/// Página de resultado de actualización de inventario
class ResultadoActualizacionPage extends ConsumerStatefulWidget {
  final String galponId;

  const ResultadoActualizacionPage({super.key, required this.galponId});

  @override
  ConsumerState<ResultadoActualizacionPage> createState() =>
      _ResultadoActualizacionPageState();
}

class _ResultadoActualizacionPageState
    extends ConsumerState<ResultadoActualizacionPage> {
  bool _confirmado = false;

  Future<void> _confirmarActualizacion() async {
    final conteo = ref.read(inventarioFotoControllerProvider).conteoActual;
    if (conteo == null) return;

    final cantidadFinal = conteo.conteoFinal ?? conteo.conteoAutomatico ?? 0;
    final success = await ref
        .read(inventarioFotoControllerProvider.notifier)
        .confirmarInventario(cantidadFinal);

    if (success && mounted) {
      setState(() => _confirmado = true);
    }
  }

  void _finalizarProceso() {
    // Reset state and go back to galpones
    ref.read(inventarioFotoControllerProvider.notifier).reiniciarConteo();
    context.go(RoutePaths.galpones);
  }

  void _realizarOtroConteo() {
    ref.read(inventarioFotoControllerProvider.notifier).reiniciarConteo();
    context.pop();
    context.pop(); // Back to captura page
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inventarioFotoControllerProvider);
    final conteo = state.conteoActual;

    if (conteo == null) {
      return AppScaffold(
        title: 'Resultado',
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text('No hay datos de conteo'),
              const SizedBox(height: 24),
              AppButton(
                text: 'Volver',
                onPressed: () => context.go(RoutePaths.galpones),
              ),
            ],
          ),
        ),
      );
    }

    return AppScaffold(
      title: 'Resultado',
      body: state.isLoading
          ? const Loading(message: 'Actualizando inventario...')
          : _confirmado
              ? _buildSuccessView(context)
              : _buildConfirmationView(context, state, conteo),
    );
  }

  Widget _buildConfirmationView(
    BuildContext context,
    InventarioFotoState state,
    dynamic conteo,
  ) {
    final conteoFinal = conteo.conteoFinal ?? conteo.conteoManual ?? conteo.conteoAutomatico ?? 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Summary card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(
                    Icons.fact_check,
                    size: 64,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Resumen del Conteo',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildInfoRow(
                    'Galpón',
                    widget.galponId,
                    Icons.home_work,
                  ),
                  const Divider(),
                  _buildInfoRow(
                    'Conteo Automático',
                    '${conteo.conteoAutomatico ?? "-"} aves',
                    Icons.auto_fix_high,
                  ),
                  if (conteo.conteoManual != null &&
                      conteo.conteoManual != conteo.conteoAutomatico) ...[
                    const Divider(),
                    _buildInfoRow(
                      'Conteo Manual',
                      '${conteo.conteoManual} aves',
                      Icons.edit,
                    ),
                  ],
                  const Divider(),
                  _buildInfoRow(
                    'Conteo Final',
                    '$conteoFinal aves',
                    Icons.check_circle,
                    highlight: true,
                  ),
                  if (conteo.confianza != null) ...[
                    const Divider(),
                    _buildInfoRow(
                      'Confianza',
                      '${(conteo.confianza * 100).toStringAsFixed(1)}%',
                      Icons.analytics,
                    ),
                  ],
                  const Divider(),
                  _buildInfoRow(
                    'Fecha',
                    _formatDate(conteo.fechaConteo),
                    Icons.calendar_today,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Warning if difference is significant
          if (conteo.conteoManual != null &&
              conteo.conteoAutomatico != null &&
              _getDiferenciaPorcentaje(conteo) > 10)
            Card(
              color: Colors.orange.withValues(alpha: 0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.warning, color: Colors.orange),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'La diferencia entre el conteo automático y manual es significativa (${_getDiferenciaPorcentaje(conteo).toStringAsFixed(1)}%). Verifique los datos antes de confirmar.',
                        style: const TextStyle(color: Colors.orange),
                      ),
                    ),
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
          AppButton(
            text: 'Confirmar y Actualizar Inventario',
            onPressed: _confirmarActualizacion,
            icon: Icons.update,
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => context.pop(),
            child: const Text('Revisar Nuevamente'),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                size: 80,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              '¡Inventario Actualizado!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'El inventario del galpón ${widget.galponId} ha sido actualizado correctamente.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                text: 'Finalizar',
                onPressed: _finalizarProceso,
                icon: Icons.done_all,
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _realizarOtroConteo,
              child: const Text('Realizar Otro Conteo'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    IconData icon, {
    bool highlight = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: highlight ? FontWeight.bold : FontWeight.w500,
              fontSize: highlight ? 18 : 14,
              color: highlight ? Theme.of(context).primaryColor : null,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  double _getDiferenciaPorcentaje(dynamic conteo) {
    if (conteo.conteoAutomatico == null ||
        conteo.conteoManual == null ||
        conteo.conteoAutomatico == 0) {
      return 0;
    }
    final diferencia = (conteo.conteoManual - conteo.conteoAutomatico).abs();
    return (diferencia / conteo.conteoAutomatico) * 100;
  }
}
