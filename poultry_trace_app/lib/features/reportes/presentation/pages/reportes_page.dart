import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/error_view.dart';
import '../../domain/entities/reporte.dart';
import '../controllers/reportes_controller.dart';
import '../widgets/reporte_card.dart';

/// Página principal de reportes
class ReportesPage extends ConsumerStatefulWidget {
  const ReportesPage({super.key});

  @override
  ConsumerState<ReportesPage> createState() => _ReportesPageState();
}

class _ReportesPageState extends ConsumerState<ReportesPage> {
  TipoReporte? _filtroTipo;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(reportesControllerProvider.notifier).cargarHistorial();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reportesControllerProvider);

    return AppScaffold(
      title: 'Reportes',
      actions: [
        IconButton(
          icon: const Icon(Icons.dashboard),
          onPressed: () => context.push(RoutePaths.dashboard),
          tooltip: 'Dashboard',
        ),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RoutePaths.generarReporte),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Filtros
          _buildFiltros(),

          // Lista de reportes
          Expanded(
            child: _buildContent(state),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltros() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildChip(null, 'Todos'),
            ...TipoReporte.values.map((tipo) => _buildChip(tipo, _getTipoLabel(tipo))),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(TipoReporte? tipo, String label) {
    final selected = _filtroTipo == tipo;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (value) {
          setState(() => _filtroTipo = value ? tipo : null);
          ref.read(reportesControllerProvider.notifier).cargarHistorial(tipo: _filtroTipo);
        },
      ),
    );
  }

  Widget _buildContent(ReportesState state) {
    if (state.isLoading && state.reportes.isEmpty) {
      return const Loading();
    }

    if (state.errorMessage != null && state.reportes.isEmpty) {
      return ErrorView(
        message: state.errorMessage!,
        onRetry: () => ref.read(reportesControllerProvider.notifier).cargarHistorial(
              tipo: _filtroTipo,
            ),
      );
    }

    if (state.reportes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assessment_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            const Text(
              'No hay reportes generados',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Genera tu primer reporte',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.push(RoutePaths.generarReporte),
              icon: const Icon(Icons.add),
              label: const Text('Generar Reporte'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(reportesControllerProvider.notifier).cargarHistorial(
            tipo: _filtroTipo,
          ),
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 80),
        itemCount: state.reportes.length,
        itemBuilder: (context, index) {
          final reporte = state.reportes[index];
          return ReporteCard(
            reporte: reporte,
            onTap: () => context.push(RoutePaths.reporteDetailPath(reporte.id)),
          );
        },
      ),
    );
  }

  String _getTipoLabel(TipoReporte tipo) {
    switch (tipo) {
      case TipoReporte.produccion:
        return 'Producción';
      case TipoReporte.mortalidad:
        return 'Mortalidad';
      case TipoReporte.alimentacion:
        return 'Alimentación';
      case TipoReporte.sanitario:
        return 'Sanitario';
      case TipoReporte.inventario:
        return 'Inventario';
      case TipoReporte.financiero:
        return 'Financiero';
    }
  }
}
