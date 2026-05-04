import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../config/theme/colors.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';
import '../controllers/inventario_foto_controller.dart';
import '../../../galpones/presentation/controllers/galpones_controller.dart';

class ResultadoActualizacionPage extends ConsumerStatefulWidget {
  final String galponId;

  const ResultadoActualizacionPage({super.key, required this.galponId});

  @override
  ConsumerState<ResultadoActualizacionPage> createState() =>
      _ResultadoActualizacionPageState();
}

class _ResultadoActualizacionPageState
    extends ConsumerState<ResultadoActualizacionPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(galponesControllerProvider.notifier).obtenerGalpon(widget.galponId);
    });
  }

  void _finalizar() {
    ref.read(inventarioFotoControllerProvider.notifier).reiniciarConteo();
    context.go(RoutePaths.galponDetailPath(widget.galponId));
  }

  void _otroConteo() {
    ref.read(inventarioFotoControllerProvider.notifier).reiniciarConteo();
    context.go(RoutePaths.capturaPath(widget.galponId));
  }

  @override
  Widget build(BuildContext context) {
    final conteo = ref.watch(inventarioFotoControllerProvider).conteoActual;
    final galpon = ref.watch(galponesControllerProvider).selectedGalpon;

    final conteoFinal = conteo?.conteoFinal ?? conteo?.conteoManual ?? conteo?.conteoAutomatico ?? 0;
    final avesRegistradas = galpon?.cantidadActual ?? galpon?.cantidadAvesActuales ?? 0;
    final diferencia = avesRegistradas - conteoFinal;
    final hayDiferencia = diferencia != 0;
    final faltanAves = diferencia > 0;

    return AppScaffold(
      title: 'Resultado del Inventario',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Icono de resultado
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: (hayDiferencia ? AppColors.warning : AppColors.success)
                      .withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  hayDiferencia ? Icons.warning_amber_rounded : Icons.check_circle,
                  size: 72,
                  color: hayDiferencia ? AppColors.warning : AppColors.success,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                hayDiferencia
                    ? (faltanAves ? 'Faltan aves en el galpón' : 'Exceso detectado')
                    : '¡Conteo completo!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: hayDiferencia ? AppColors.warning : AppColors.success,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),

            // Card comparación
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      galpon?.nombre ?? 'Galpón',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _statBox(
                            'Aves registradas',
                            '$avesRegistradas',
                            Icons.spa_outlined,
                            AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _statBox(
                            'Detectadas por IA',
                            '$conteoFinal',
                            Icons.camera_alt_outlined,
                            AppColors.primaryDark,
                          ),
                        ),
                      ],
                    ),
                    if (hayDiferencia) ...[
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: (faltanAves ? AppColors.error : AppColors.warning)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: (faltanAves ? AppColors.error : AppColors.warning)
                                .withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              faltanAves ? Icons.arrow_downward : Icons.arrow_upward,
                              color: faltanAves ? AppColors.error : AppColors.warning,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              faltanAves
                                  ? 'Faltan ${diferencia.abs()} aves'
                                  : 'Exceso de ${diferencia.abs()} aves',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: faltanAves ? AppColors.error : AppColors.warning,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Detalles del conteo
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Detalle del conteo',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    if (conteo?.conteoAutomatico != null)
                      _infoRow('Conteo automático IA',
                          '${conteo!.conteoAutomatico} aves',
                          Icons.auto_fix_high),
                    if (conteo?.conteoManual != null &&
                        conteo!.conteoManual != conteo.conteoAutomatico)
                      _infoRow('Conteo manual corregido',
                          '${conteo.conteoManual} aves', Icons.edit),
                    _infoRow('Conteo final', '$conteoFinal aves',
                        Icons.check_circle, highlight: true),
                    if (conteo?.confianza != null)
                      _infoRow(
                        'Confianza IA',
                        '${((conteo!.confianza!) * 100).toStringAsFixed(1)}%',
                        Icons.analytics,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            AppButton(
              text: 'Ver detalle del galpón',
              onPressed: _finalizar,
              icon: Icons.home_work_outlined,
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _otroConteo,
              icon: const Icon(Icons.camera_alt_outlined),
              label: const Text('Realizar otro conteo'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statBox(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, IconData icon,
      {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label,
                style: const TextStyle(color: AppColors.textSecondary)),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: highlight ? FontWeight.bold : FontWeight.w500,
              fontSize: highlight ? 16 : 14,
              color: highlight ? AppColors.primaryDark : null,
            ),
          ),
        ],
      ),
    );
  }
}
