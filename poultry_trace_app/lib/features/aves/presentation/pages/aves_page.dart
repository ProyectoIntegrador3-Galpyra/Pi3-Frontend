import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/gradient_fab.dart';
import '../controllers/aves_controller.dart';
import '../widgets/aves_summary_card.dart';

/// Página principal de inventario de aves
class AvesPage extends ConsumerStatefulWidget {
  final String galponId;

  const AvesPage({super.key, required this.galponId});

  @override
  ConsumerState<AvesPage> createState() => _AvesPageState();
}

class _AvesPageState extends ConsumerState<AvesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(avesControllerProvider.notifier).consultarInventario(widget.galponId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(avesControllerProvider);

    return AppScaffold(
      title: 'Inventario de Aves',
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            ref.read(avesControllerProvider.notifier).consultarInventario(widget.galponId);
          },
        ),
      ],
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GradientFABWarning(
            heroTag: 'mortalidad',
            onPressed: () => context.push(RoutePaths.mortalidadFormPath(widget.galponId)),
            icon: Icons.warning_amber_outlined,
            label: 'Mortalidad',
          ),
          const SizedBox(height: 12),
          GradientFAB(
            heroTag: 'ingreso',
            onPressed: () => context.push(RoutePaths.ingresoAvesForm(widget.galponId)),
            icon: Icons.add,
            label: 'Nuevo Ingreso',
          ),
        ],
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(AvesState state) {
    if (state.isLoading && state.lotes.isEmpty) {
      return const Loading();
    }

    if (state.errorMessage != null && state.lotes.isEmpty) {
      return ErrorView(
        message: state.errorMessage!,
        onRetry: () {
          ref.read(avesControllerProvider.notifier).consultarInventario(widget.galponId);
        },
      );
    }

    if (state.lotes.isEmpty) {
      return EmptyState(
        icon: Icons.egg_outlined,
        title: 'Sin aves registradas',
        message: 'Registra el primer ingreso de aves para este galpón',
        actionText: 'Registrar Ingreso',
        action: () => context.push(RoutePaths.ingresoAvesForm(widget.galponId)),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(avesControllerProvider.notifier).consultarInventario(widget.galponId);
      },
      child: Column(
        children: [
          // Summary card
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryItem(
                      'Total Aves',
                      ref.read(avesControllerProvider.notifier).totalAves.toString(),
                      Icons.pets,
                    ),
                    _buildSummaryItem(
                      'Lotes',
                      state.lotes.length.toString(),
                      Icons.inventory_2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // List of lotes
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.lotes.length,
              itemBuilder: (context, index) {
                final lote = state.lotes[index];
                return AvesSummaryCard(lote: lote);
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
        Icon(icon, size: 32, color: Theme.of(context).primaryColor),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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
