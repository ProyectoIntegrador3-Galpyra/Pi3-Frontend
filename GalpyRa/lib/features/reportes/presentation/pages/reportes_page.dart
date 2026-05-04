import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
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
          onPressed: () =>
              ref.read(reportesControllerProvider.notifier).cargarHistorial(
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
        onRetry: () =>
            ref.read(reportesControllerProvider.notifier).cargarHistorial(
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
      onRefresh: () =>
          ref.read(reportesControllerProvider.notifier).cargarHistorial(
                tipo: _filtroTipo,
              ),
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
        itemCount: state.reportes.length,
        itemBuilder: (context, index) {
          final reporte = state.reportes[index];
          return ReporteCard(
            reporte: reporte,
            onTap: () => _mostrarAccionesReporte(reporte),
            onPdfTap: () => _abrirReporte(reporte),
          );
        },
      ),
    );
  }

  Future<void> _mostrarAccionesReporte(Reporte reporte) async {
    if (!mounted) return;

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  reporte.titulo,
                  style: Theme.of(sheetContext).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  _getTipoLabel(reporte.tipo),
                  style: Theme.of(sheetContext).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 16),
                _buildActionTile(
                  icon: Icons.visibility_outlined,
                  label: 'Ver reporte',
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    _abrirReporte(reporte);
                  },
                ),
                _buildActionTile(
                  icon: Icons.download_outlined,
                  label: 'Descargar PDF',
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    _abrirReporte(reporte);
                  },
                ),
                _buildActionTile(
                  icon: Icons.open_in_new_outlined,
                  label: 'Abrir en navegador',
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    _abrirReporte(reporte);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: AppColors.surface,
        leading: Icon(icon, color: AppColors.primaryDark),
        title: Text(label),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Future<void> _abrirReporte(Reporte reporte) async {
    final String? url = reporte.archivoUrl;

    if (url != null && url.isNotEmpty) {
      try {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          return;
        }
      } catch (_) {}
    }

    if (!context.mounted) return;
    _mostrarDatosReporte(reporte);
  }

  void _mostrarDatosReporte(Reporte reporte) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final datos = reporte.datos;
        final resumen = reporte.resumen;
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (_, controller) => ListView(
            controller: controller,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            children: [
              Text(
                reporte.titulo,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${reporte.fechaInicio.day}/${reporte.fechaInicio.month}/${reporte.fechaInicio.year} — '
                '${reporte.fechaFin.day}/${reporte.fechaFin.month}/${reporte.fechaFin.year}',
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 16),
              if (resumen != null) ...[
                const Text('Resumen',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                const SizedBox(height: 8),
                ...resumen.entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.key, style: const TextStyle(color: Colors.grey)),
                        Text(
                          e.value?.toString() ?? '-',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 24),
              ],
              const Text('Datos',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              const SizedBox(height: 8),
              if (datos.isEmpty)
                const Text('Sin datos disponibles',
                    style: TextStyle(color: Colors.grey))
              else
                ...datos.entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(e.key,
                              style: const TextStyle(color: Colors.grey)),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            e.value?.toString() ?? '-',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
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
