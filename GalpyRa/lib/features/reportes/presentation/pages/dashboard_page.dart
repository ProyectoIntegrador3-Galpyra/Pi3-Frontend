import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/error_view.dart';
import '../controllers/reportes_controller.dart';

/// Página de dashboard con métricas generales
class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(reportesControllerProvider.notifier).cargarDatosDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reportesControllerProvider);

    return AppScaffold(
      title: 'Dashboard',
      body: _buildContent(state),
    );
  }

  Widget _buildContent(ReportesState state) {
    if (state.isLoading && state.datosDashboard == null) {
      return const Loading();
    }

    if (state.errorMessage != null && state.datosDashboard == null) {
      return ErrorView(
        message: state.errorMessage!,
        onRetry: () =>
            ref.read(reportesControllerProvider.notifier).cargarDatosDashboard(),
      );
    }

    final datos = state.datosDashboard;
    if (datos == null) {
      return const Center(child: Text('No hay datos disponibles'));
    }

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(reportesControllerProvider.notifier).cargarDatosDashboard(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Métricas principales
            _buildMetricasGrid(datos),
            const SizedBox(height: 24),

            // Alertas
            const Text(
              'Alertas y Pendientes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildAlertasCard(datos),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricasGrid(Map<String, dynamic> datos) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: [
        _buildMetricaCard(
          'Total Aves',
          '${datos['total_aves_activas'] ?? 0}',
          Icons.opacity,
          Colors.blue,
        ),
        _buildMetricaCard(
          'Prod. 7 Dias',
          '${datos['produccion_ultimos_7_dias'] ?? 0}',
          Icons.egg,
          Colors.orange,
        ),
        _buildMetricaCard(
          'Mortalidad %',
          '${((datos['tasa_mortalidad_porcentaje'] as num?) ?? 0).toStringAsFixed(2)}%',
          Icons.warning_amber,
          Colors.red,
        ),
        _buildMetricaCard(
          'Alertas',
          '${(datos['alertas'] as List?)?.length ?? 0}',
          Icons.notifications_active,
          Colors.green,
        ),
      ],
    );
  }

  Widget _buildMetricaCard(
    String titulo,
    String valor,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 24),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  valor,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertasCard(Map<String, dynamic> datos) {
    final alertas = (datos['alertas'] as List?)?.map((e) => e.toString()).toList() ?? <String>[];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (alertas.isNotEmpty)
              ...alertas.map(
                (alerta) => _buildAlertaItem(
                  'Alerta',
                  alerta,
                  Icons.warning,
                  Colors.orange,
                ),
              ),
            if (alertas.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(Icons.check_circle, size: 48, color: Colors.green),
                      SizedBox(height: 8),
                      Text(
                        'Todo en orden',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertaItem(
    String titulo,
    String subtitulo,
    IconData icon,
    Color color,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(titulo),
      subtitle: Text(subtitulo),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
