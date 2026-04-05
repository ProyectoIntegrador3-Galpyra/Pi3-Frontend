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
import '../controllers/galpones_controller.dart';
import '../widgets/galpon_card.dart';

/// Galpones list page
class GalponesListPage extends ConsumerStatefulWidget {
  const GalponesListPage({super.key});

  @override
  ConsumerState<GalponesListPage> createState() => _GalponesListPageState();
}

class _GalponesListPageState extends ConsumerState<GalponesListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(galponesControllerProvider.notifier).cargarGalpones();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(galponesControllerProvider);

    return AppScaffold(
      title: 'Galpones',
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            ref.read(galponesControllerProvider.notifier).cargarGalpones();
          },
        ),
      ],
      floatingActionButton: GradientFABSecondary(
        onPressed: () => context.push(RoutePaths.galponForm),
        icon: Icons.add,
        label: 'Nuevo',
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(GalponesState state) {
    if (state.isLoading && state.galpones.isEmpty) {
      return const Loading(message: 'Cargando galpones...');
    }

    if (state.error != null && state.galpones.isEmpty) {
      return ErrorView.generic(
        message: state.error,
        onRetry: () {
          ref.read(galponesControllerProvider.notifier).cargarGalpones();
        },
      );
    }

    if (state.galpones.isEmpty) {
      return EmptyState.galpones(
        onCreate: () => context.push(RoutePaths.galponForm),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(galponesControllerProvider.notifier).cargarGalpones();
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSummary(context, state),
          const SizedBox(height: 16),
          ...state.galpones.map((galpon) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GalponCard(
                galpon: galpon,
                onTap: () {
                  context.push(RoutePaths.galponDetailPath(galpon.id));
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSummary(BuildContext context, GalponesState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.home_work_outlined, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total de galpones',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${state.galpones.length}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryDark,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
