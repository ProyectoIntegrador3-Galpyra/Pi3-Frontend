import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../config/di/injector.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../core/network/api_response_parser.dart';
import '../../../../core/network/http_client.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading.dart';
import '../../domain/entities/dashboard_admin_data.dart';

final adminDashboardFutureProvider =
    FutureProvider<DashboardAdminData>((ref) async {
  final httpClient = getIt<HttpClient>();
  final response = await httpClient.get(ApiEndpoints.adminDashboard);
  final data = ApiResponseParser.extractDataMap(response.data);
  return DashboardAdminData.fromJson(data);
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
        data: (data) => _buildContent(context, data),
      ),
    );
  }

  Widget _buildContent(BuildContext context, DashboardAdminData data) {
    final cards = [
      _KpiItem('Aves activas', '${data.avesActivas}', Icons.pets_outlined),
      _KpiItem('Produccion hoy', '${data.produccionHoy}', Icons.egg_outlined),
      _KpiItem('Produccion mes', '${data.produccionMes}', Icons.calendar_today),
      _KpiItem('Mortalidad mes', '${data.mortalidadMes}', Icons.warning_amber),
      _KpiItem('Tasa mortalidad',
          '${data.tasaMortalidadMes.toStringAsFixed(2)}%', Icons.percent),
      _KpiItem('Gasto alimento mes', data.gastoAlimentoMes.toStringAsFixed(2),
          Icons.attach_money),
      _KpiItem('Gasto alimento ano', data.gastoAlimentoAnio.toStringAsFixed(2),
          Icons.trending_up),
      _KpiItem('Galpones activos', '${data.galponesActivos}',
          Icons.home_work_outlined),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cards.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.15,
            ),
            itemBuilder: (_, index) {
              final item = cards[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(item.icon, size: 28),
                      Text(
                        item.value,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(item.label),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
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
            icon: Icons.manage_accounts,
            onPressed: () => context.push(RoutePaths.adminUsuarios),
          ),
        ],
      ),
    );
  }
}

class _KpiItem {
  final String label;
  final String value;
  final IconData icon;

  const _KpiItem(this.label, this.value, this.icon);
}
