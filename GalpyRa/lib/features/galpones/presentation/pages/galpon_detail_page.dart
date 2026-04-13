import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../config/theme/colors.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/utils/formatters.dart';
import '../controllers/galpones_controller.dart';

/// Galpon detail page
class GalponDetailPage extends ConsumerStatefulWidget {
  final String galponId;

  const GalponDetailPage({
    super.key,
    required this.galponId,
  });

  @override
  ConsumerState<GalponDetailPage> createState() => _GalponDetailPageState();
}

class _GalponDetailPageState extends ConsumerState<GalponDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(galponesControllerProvider.notifier)
          .obtenerGalpon(widget.galponId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(galponesControllerProvider);

    return AppScaffold(
      title: 'Detalle de Galpón',
      actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            context.push(RoutePaths.galponEditPath(widget.galponId));
          },
        ),
      ],
      body: _buildBody(state),
    );
  }

  Widget _buildBody(GalponesState state) {
    if (state.isLoading && state.selectedGalpon == null) {
      return const Loading(message: 'Cargando detalles...');
    }

    if (state.error != null && state.selectedGalpon == null) {
      return ErrorView.generic(
        message: state.error,
        onRetry: () {
          ref
              .read(galponesControllerProvider.notifier)
              .obtenerGalpon(widget.galponId);
        },
      );
    }

    final galpon = state.selectedGalpon;
    if (galpon == null) {
      return const ErrorView(message: 'Galpón no encontrado');
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          galpon.nombre,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: galpon.activo
                              ? AppColors.success.withOpacity(0.1)
                              : AppColors.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          galpon.activo ? 'Activo' : 'Inactivo',
                          style: TextStyle(
                            color: galpon.activo
                                ? AppColors.success
                                : AppColors.error,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (galpon.descripcion != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      galpon.descripcion!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                  if (galpon.ubicacion != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          galpon.ubicacion!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Occupancy card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ocupación',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatItem(
                        'Actual',
                        Formatters.formatNumber(galpon.cantidadActual),
                        'aves',
                      ),
                      _buildStatItem(
                        'Capacidad',
                        Formatters.formatNumber(galpon.capacidadMaxima),
                        'aves',
                      ),
                      _buildStatItem(
                        'Ocupación',
                        Formatters.formatPercentage(galpon.porcentajeOcupacion),
                        '',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: galpon.porcentajeOcupacion / 100,
                    backgroundColor: AppColors.surfaceVariant,
                    valueColor: AlwaysStoppedAnimation(
                      galpon.porcentajeOcupacion > 90
                          ? AppColors.error
                          : galpon.porcentajeOcupacion > 70
                              ? AppColors.warning
                              : AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Quick actions
          Text(
            'Acciones rápidas',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: 'Inventario',
                  icon: Icons.camera_alt_outlined,
                  onPressed: () {
                    context.push(RoutePaths.capturaPath(galpon.id));
                  },
                  type: AppButtonType.outline,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton(
                  text: 'Producción',
                  icon: Icons.egg_outlined,
                  onPressed: () {
                    context.push(RoutePaths.produccionFormPath(galpon.id));
                  },
                  type: AppButtonType.outline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: 'Sanidad',
                  icon: Icons.medical_services_outlined,
                  onPressed: () {
                    context.push(RoutePaths.sanidadFormPath(galpon.id));
                  },
                  type: AppButtonType.outline,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton(
                  text: 'Alimentación',
                  icon: Icons.restaurant_outlined,
                  onPressed: () {
                    context.push(RoutePaths.alimentacionFormPath(galpon.id));
                  },
                  type: AppButtonType.outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, String unit) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
        ),
        if (unit.isNotEmpty)
          Text(
            unit,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }
}
