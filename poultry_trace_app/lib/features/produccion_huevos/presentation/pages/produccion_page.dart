import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/gradient_fab.dart';
import '../controllers/produccion_huevos_controller.dart';
import '../widgets/produccion_card.dart';

/// Página de producción de huevos
class ProduccionPage extends ConsumerStatefulWidget {
  final String galponId;

  const ProduccionPage({super.key, required this.galponId});

  @override
  ConsumerState<ProduccionPage> createState() => _ProduccionPageState();
}

class _ProduccionPageState extends ConsumerState<ProduccionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(produccionHuevosControllerProvider.notifier).obtenerHistorial(widget.galponId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(produccionHuevosControllerProvider);

    return AppScaffold(
      title: 'Producción de Huevos',
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            ref.read(produccionHuevosControllerProvider.notifier).obtenerHistorial(widget.galponId);
          },
        ),
      ],
      floatingActionButton: GradientFAB(
        onPressed: () => context.push(RoutePaths.produccionFormPath(widget.galponId)),
        icon: Icons.add,
        label: 'Registrar',
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(ProduccionHuevosState state) {
    if (state.isLoading && state.historial.isEmpty) {
      return const Loading();
    }

    if (state.errorMessage != null && state.historial.isEmpty) {
      return ErrorView(
        message: state.errorMessage!,
        onRetry: () {
          ref.read(produccionHuevosControllerProvider.notifier).obtenerHistorial(widget.galponId);
        },
      );
    }

    if (state.historial.isEmpty) {
      return EmptyState(
        icon: Icons.egg_outlined,
        title: 'Sin registros',
        message: 'Registra la producción del día',
        actionText: 'Registrar Producción',
        action: () => context.push(RoutePaths.produccionFormPath(widget.galponId)),
      );
    }

    final controller = ref.read(produccionHuevosControllerProvider.notifier);

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(produccionHuevosControllerProvider.notifier).obtenerHistorial(widget.galponId);
      },
      child: Column(
        children: [
          // Summary card
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Resumen últimos ${state.historial.length} días',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSummaryItem(
                          'Total',
                          controller.totalHuevosPeriodo.toString(),
                          Icons.inventory_2,
                        ),
                        _buildSummaryItem(
                          'Promedio/día',
                          controller.promedioDiario.toStringAsFixed(0),
                          Icons.trending_up,
                        ),
                        if (state.produccionHoy != null)
                          _buildSummaryItem(
                            'Postura',
                            '${state.produccionHoy!.porcentajePostura.toStringAsFixed(1)}%',
                            Icons.percent,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // History list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.historial.length,
              itemBuilder: (context, index) {
                final registro = state.historial[index];
                return ProduccionCard(
                  registro: registro,
                  isToday: index == 0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Theme.of(context).primaryColor),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
