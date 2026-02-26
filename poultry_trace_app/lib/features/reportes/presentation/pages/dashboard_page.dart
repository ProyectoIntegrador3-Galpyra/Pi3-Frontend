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

            // Producción
            const Text(
              'Producción de Huevos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildProduccionCard(datos['produccionHuevos'] as Map<String, dynamic>?),
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
          '${datos['totalAves'] ?? 0}',
          Icons.opacity,
          Colors.blue,
        ),
        _buildMetricaCard(
          'Prod. Huevos',
          '${(datos['produccionHuevos'] as Map?)?['total'] ?? 0}',
          Icons.egg,
          Colors.orange,
        ),
        _buildMetricaCard(
          'Mortalidad',
          '${(datos['mortalidad'] as Map?)?['total'] ?? 0}',
          Icons.warning_amber,
          Colors.red,
        ),
        _buildMetricaCard(
          'Consumo Alim.',
          '${(datos['alimentacion'] as Map?)?['consumoTotal'] ?? 0} kg',
          Icons.restaurant,
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

  Widget _buildProduccionCard(Map<String, dynamic>? produccion) {
    if (produccion == null) return const SizedBox.shrink();

    final tendencia = (produccion['tendencia'] as num?)?.toDouble() ?? 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Promedio Diario',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '${produccion['promedioDiario'] ?? 0} huevos',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: tendencia >= 0
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        tendencia >= 0 ? Icons.trending_up : Icons.trending_down,
                        color: tendencia >= 0 ? Colors.green : Colors.red,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${tendencia >= 0 ? '+' : ''}${tendencia.toStringAsFixed(1)}%',
                        style: TextStyle(
                          color: tendencia >= 0 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Mock chart placeholder
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Gráfico de producción semanal',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertasCard(Map<String, dynamic> datos) {
    final sanidad = datos['sanidad'] as Map<String, dynamic>?;
    final vacunacionesPendientes = (sanidad?['vacunacionesPendientes'] as int?) ?? 0;
    final mortalidad = datos['mortalidad'] as Map<String, dynamic>?;
    final tasaMortalidad = (mortalidad?['tasa'] as num?)?.toDouble() ?? 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (vacunacionesPendientes > 0)
              _buildAlertaItem(
                'Vacunaciones pendientes',
                '$vacunacionesPendientes programadas',
                Icons.vaccines,
                Colors.orange,
              ),
            if (tasaMortalidad > 0.15)
              _buildAlertaItem(
                'Tasa de mortalidad alta',
                '${(tasaMortalidad * 100).toStringAsFixed(1)}% - Revisar',
                Icons.warning,
                Colors.red,
              ),
            if (vacunacionesPendientes == 0 && tasaMortalidad <= 0.15)
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
