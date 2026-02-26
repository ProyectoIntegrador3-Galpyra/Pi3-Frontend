import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/empty_state.dart';
import '../controllers/alimentacion_controller.dart';
import '../widgets/alimentacion_card.dart';

/// Página de alimentación
class AlimentacionPage extends ConsumerStatefulWidget {
  final String galponId;

  const AlimentacionPage({super.key, required this.galponId});

  @override
  ConsumerState<AlimentacionPage> createState() => _AlimentacionPageState();
}

class _AlimentacionPageState extends ConsumerState<AlimentacionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(alimentacionControllerProvider.notifier).obtenerHistorial(widget.galponId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(alimentacionControllerProvider);

    return AppScaffold(
      title: 'Alimentación',
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            ref.read(alimentacionControllerProvider.notifier).obtenerHistorial(widget.galponId);
          },
        ),
      ],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(RoutePaths.alimentacionFormPath(widget.galponId)),
        icon: const Icon(Icons.add),
        label: const Text('Registrar'),
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(AlimentacionState state) {
    if (state.isLoading && state.historial.isEmpty) {
      return const Loading();
    }

    if (state.errorMessage != null && state.historial.isEmpty) {
      return ErrorView(
        message: state.errorMessage!,
        onRetry: () {
          ref.read(alimentacionControllerProvider.notifier).obtenerHistorial(widget.galponId);
        },
      );
    }

    if (state.historial.isEmpty) {
      return EmptyState(
        icon: Icons.restaurant_outlined,
        title: 'Sin registros',
        message: 'Registra la alimentación del día',
        actionText: 'Registrar Alimentación',
        action: () => context.push(RoutePaths.alimentacionFormPath(widget.galponId)),
      );
    }

    final controller = ref.read(alimentacionControllerProvider.notifier);

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(alimentacionControllerProvider.notifier).obtenerHistorial(widget.galponId);
      },
      child: Column(
        children: [
          // Summary card
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
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
                          '${controller.totalKgConsumidos.toStringAsFixed(0)} kg',
                          Icons.inventory_2,
                        ),
                        _buildSummaryItem(
                          'Promedio/día',
                          '${controller.promedioDiario.toStringAsFixed(0)} kg',
                          Icons.trending_up,
                        ),
                        _buildSummaryItem(
                          'Costo Total',
                          '\$${controller.costoTotal.toStringAsFixed(2)}',
                          Icons.attach_money,
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
                return AlimentacionCard(
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
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
