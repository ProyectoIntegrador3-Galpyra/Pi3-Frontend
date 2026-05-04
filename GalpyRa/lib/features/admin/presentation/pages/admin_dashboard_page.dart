import 'dart:math' as math;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../config/di/injector.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../config/theme/colors.dart';
import '../../../../core/network/api_response_parser.dart';
import '../../../../core/network/http_client.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading.dart';

final adminDashboardFutureProvider =
    FutureProvider<Map<String, dynamic>>((ref) async {
  final httpClient = getIt<HttpClient>();
  final response = await httpClient.get(ApiEndpoints.dashboard);
  return ApiResponseParser.extractDataMap(response.data);
});

class AdminDashboardPage extends ConsumerWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboard = ref.watch(adminDashboardFutureProvider);

    return AppScaffold(
      title: 'Dashboard Admin',
      body: dashboard.when(
        loading: () => const Loading(message: 'Cargando indicadores...'),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.refresh(adminDashboardFutureProvider),
        ),
        data: (data) => _buildContent(context, ref, data),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    Map<String, dynamic> data,
  ) {
    final avesActivas = _toInt(data['total_aves_activas']);
    final produccion = _toInt(data['produccion_ultimos_7_dias']);
    final mortalidad = _toDouble(data['tasa_mortalidad_porcentaje']);
    final alertas = (data['alertas'] as List?)?.length ?? 0;

    final metricas = [
      _MetricCardData(
        'Total aves',
        avesActivas.toString(),
        Icons.egg_alt_outlined,
        const Color(0xFFD4920A),
        emoji: '🐔',
      ),
      _MetricCardData(
        'Producción 7 días',
        produccion.toString(),
        Icons.egg,
        const Color(0xFFE67E22),
      ),
      _MetricCardData(
        'Mortalidad %',
        '${mortalidad.toStringAsFixed(2)}%',
        Icons.show_chart,
        const Color(0xFFC0392B),
      ),
      _MetricCardData(
        'Alertas',
        alertas.toString(),
        Icons.notifications_active_outlined,
        const Color(0xFF2C3E7A),
      ),
    ];

    final topValue = _maxOf([
      avesActivas.toDouble(),
      produccion.toDouble(),
      mortalidad,
      alertas.toDouble(),
    ]);

    return RefreshIndicator(
      onRefresh: () async {
        final _ = await ref.refresh(adminDashboardFutureProvider.future);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Panel administrativo',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primaryDark,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Supervisión, control y gestión centralizada',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      _buildConnectivityChip(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: metricas.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      mainAxisExtent: 130,
                    ),
                    itemBuilder: (_, index) =>
                        _buildMetricCard(metricas[index]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tendencia operativa',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryDark,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Lectura rápida de los principales indicadores',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _buildStatBar(
                    context,
                    label: 'Total aves',
                    value: avesActivas.toDouble(),
                    maxValue: topValue,
                    color: const Color(0xFFD4920A),
                  ),
                  const SizedBox(height: 12),
                  _buildStatBar(
                    context,
                    label: 'Producción 7 días',
                    value: produccion.toDouble(),
                    maxValue: topValue,
                    color: const Color(0xFFE67E22),
                  ),
                  const SizedBox(height: 12),
                  _buildStatBar(
                    context,
                    label: 'Mortalidad %',
                    value: mortalidad,
                    maxValue: math.max(100, topValue),
                    color: const Color(0xFFC0392B),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Accesos rápidos',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryDark,
                        ),
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    text: 'Ir a reportes admin',
                    isExpanded: true,
                    icon: Icons.assessment_outlined,
                    onPressed: () => context.push(RoutePaths.adminReportes),
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    text: 'Gestionar usuarios',
                    isExpanded: true,
                    type: AppButtonType.secondary,
                    icon: Icons.manage_accounts_outlined,
                    onPressed: () => context.push(RoutePaths.adminUsuarios),
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    text: 'Ver galpones',
                    isExpanded: true,
                    type: AppButtonType.secondary,
                    icon: Icons.home_work_outlined,
                    onPressed: () => context.push(RoutePaths.galpones),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(_MetricCardData item) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: item.color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: item.color.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: item.emoji != null
                ? Text(item.emoji!, style: const TextStyle(fontSize: 20))
                : Icon(item.icon, color: item.color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            item.value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: item.color,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            item.label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBar(
    BuildContext context, {
    required String label,
    required double value,
    required double maxValue,
    required Color color,
  }) {
    final normalized = maxValue <= 0 ? 0.0 : (value / maxValue).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
            ),
            Text(
              value % 1 == 0
                  ? value.toInt().toString()
                  : value.toStringAsFixed(1),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: normalized,
            minHeight: 10,
            backgroundColor: color.withValues(alpha: 0.12),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _buildConnectivityChip() {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        final isOnline =
            snapshot.hasData && snapshot.data != ConnectivityResult.none;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isOnline
                ? const Color(0xFF27AE60).withValues(alpha: 0.12)
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isOnline ? const Color(0xFF27AE60) : Colors.grey,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                isOnline ? 'En línea' : 'Sin conexión',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color:
                      isOnline ? const Color(0xFF27AE60) : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double _maxOf(List<double> values) {
    if (values.isEmpty) {
      return 0;
    }
    return values.reduce(math.max);
  }

  int _toInt(dynamic value) {
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }
}

class _MetricCardData {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final String? emoji;

  const _MetricCardData(
    this.label,
    this.value,
    this.icon,
    this.color, {
    this.emoji,
  });
}
