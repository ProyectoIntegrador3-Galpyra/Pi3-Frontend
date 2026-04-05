import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../config/theme/colors.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/gradient_fab.dart';
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
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.read(reportesControllerProvider.notifier).cargarHistorial(
                tipo: _filtroTipo,
              ),
          tooltip: 'Actualizar',
        ),
        IconButton(
          icon: const Icon(Icons.dashboard),
          onPressed: () => context.push(RoutePaths.dashboard),
          tooltip: 'Dashboard',
        ),
      ],
      floatingActionButton: GradientFAB(
        onPressed: () => context.push(RoutePaths.generarReporte),
        icon: Icons.add_chart,
        label: 'Nuevo reporte',
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
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filtrar por tipo',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildChip(null, 'Todos'),
                ...TipoReporte.values
                    .map((tipo) => _buildChip(tipo, _getTipoLabel(tipo))),
              ],
            ),
          ),
        ],
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
        labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: selected ? AppColors.textOnPrimary : AppColors.textPrimary,
            ),
        checkmarkColor: AppColors.textOnPrimary,
        selectedColor: AppColors.primary,
        backgroundColor: AppColors.surfaceVariant,
        side: BorderSide(color: AppColors.border.withOpacity(0.8)),
        onSelected: (value) {
          setState(() => _filtroTipo = value ? tipo : null);
          ref
              .read(reportesControllerProvider.notifier)
              .cargarHistorial(tipo: _filtroTipo);
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
      return EmptyState.reportes(
        onGenerate: () => context.push(RoutePaths.generarReporte),
        fullScreen: false,
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(reportesControllerProvider.notifier).cargarHistorial(
            tipo: _filtroTipo,
          ),
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
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
