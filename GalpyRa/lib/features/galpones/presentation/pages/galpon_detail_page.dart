import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/constants/app_constants.dart';
import '../../../../config/di/injector.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../config/theme/colors.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../../../core/widgets/app_scaffold.dart';
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
  String _rol = 'PRODUCTOR';

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      ref.read(galponesControllerProvider.notifier).obtenerGalpon(widget.galponId);
      final rol = await getIt<SecureStorage>().read(AppConstants.userRoleKey) ?? 'PRODUCTOR';
      if (mounted) setState(() => _rol = rol.trim().toUpperCase());
    });
  }

  bool get _isAdmin => _rol == 'ADMIN';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(galponesControllerProvider);

    return AppScaffold(
      title: 'Detalle de Galpón',
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

          FutureBuilder<Map<String, dynamic>?>(
            future: ref
                .read(galponesControllerProvider.notifier)
                .getTurnoActivo(widget.galponId),
            builder: (context, snapshot) {
              final turno = snapshot.data;
              if (turno == null) {
                return const SizedBox.shrink();
              }

              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF3DC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE8D5A3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.person_outline,
                        color: Color(0xFFD4920A), size: 20),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Turno ${(turno['nombre'] ?? 'Sin turno').toString()}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          (turno['operario_nombre'] ??
                                  turno['operarioNombre'] ??
                                  'Sin operario asignado')
                              .toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
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
                    children: [
                      Expanded(
                          child: _buildStatItem(
                        'Actual',
                        Formatters.formatNumber(galpon.cantidadActual),
                        'aves',
                      )),
                      Expanded(
                          child: _buildStatItem(
                        'Capacidad',
                        Formatters.formatNumber(galpon.capacidadMaxima),
                        'aves',
                      )),
                      Expanded(
                          child: _buildStatItem(
                        'Ocupación',
                        Formatters.formatPercentage(galpon.porcentajeOcupacion),
                        '',
                      )),
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
          const SizedBox(height: 16),

          // QR del galpón
          Card(
            child: ListTile(
              leading: const Icon(Icons.qr_code_2,
                  color: AppColors.primaryDark, size: 32),
              title: const Text('Código QR del Galpón',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text('Ver, compartir e imprimir el QR'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(
                RoutePaths.galponQrPath(galpon.id),
                extra: {
                  'nombre': galpon.nombre,
                  'ubicacion': galpon.ubicacion,
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (_isAdmin)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                'Vista de solo lectura — panel de seguimiento del galpón.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            )
          else ...[
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
                  child: _actionButton(
                    icon: Icons.spa_outlined,
                    label: 'Aves',
                    color: AppColors.accentLime,
                    onTap: () => context.push(RoutePaths.avesPath(galpon.id)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _actionButton(
                    icon: Icons.egg_outlined,
                    label: 'Producción',
                    color: AppColors.secondaryDark,
                    onTap: () => context.push(RoutePaths.produccionPath(galpon.id)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _actionButton(
                    icon: Icons.medical_services_outlined,
                    label: 'Sanidad',
                    color: AppColors.error,
                    onTap: () => context.push(RoutePaths.sanidadPath(galpon.id)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _actionButton(
                    icon: Icons.restaurant_outlined,
                    label: 'Alimentación',
                    color: AppColors.primary,
                    onTap: () => context.push(RoutePaths.alimentacionPath(galpon.id)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: _actionButton(
                icon: Icons.camera_alt_outlined,
                label: 'Inventario por Foto',
                color: AppColors.primaryDark,
                onTap: () => context.push(RoutePaths.capturaPath(galpon.id)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
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
