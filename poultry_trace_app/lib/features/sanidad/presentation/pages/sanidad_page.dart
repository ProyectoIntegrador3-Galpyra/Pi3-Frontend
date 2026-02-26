import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../domain/entities/registro_sanitario.dart';
import '../controllers/sanidad_controller.dart';
import '../widgets/registro_sanitario_card.dart';

/// Página de sanidad
class SanidadPage extends ConsumerStatefulWidget {
  final String galponId;

  const SanidadPage({super.key, required this.galponId});

  @override
  ConsumerState<SanidadPage> createState() => _SanidadPageState();
}

class _SanidadPageState extends ConsumerState<SanidadPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sanidadControllerProvider.notifier).obtenerHistorial(widget.galponId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sanidadControllerProvider);

    return AppScaffold(
      title: 'Control Sanitario',
      actions: [
        PopupMenuButton<TipoEventoSanitario?>(
          icon: const Icon(Icons.filter_list),
          onSelected: (tipo) {
            if (tipo == null) {
              ref.read(sanidadControllerProvider.notifier).limpiarFiltro();
            } else {
              ref.read(sanidadControllerProvider.notifier).filtrarPorTipo(tipo);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: null, child: Text('Todos')),
            const PopupMenuDivider(),
            ...TipoEventoSanitario.values.map(
              (tipo) => PopupMenuItem(
                value: tipo,
                child: Text(_getTipoNombre(tipo)),
              ),
            ),
          ],
        ),
      ],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(RoutePaths.sanidadFormPath(widget.galponId)),
        icon: const Icon(Icons.add),
        label: const Text('Registrar'),
      ),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(SanidadState state) {
    if (state.isLoading && state.historial.isEmpty) {
      return const Loading();
    }

    if (state.errorMessage != null && state.historial.isEmpty) {
      return ErrorView(
        message: state.errorMessage!,
        onRetry: () {
          ref.read(sanidadControllerProvider.notifier).obtenerHistorial(widget.galponId);
        },
      );
    }

    if (state.historial.isEmpty) {
      return EmptyState(
        icon: Icons.medical_services_outlined,
        title: 'Sin registros sanitarios',
        message: 'Registra el primer evento sanitario',
        actionText: 'Registrar Evento',
        action: () => context.push(RoutePaths.sanidadFormPath(widget.galponId)),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(sanidadControllerProvider.notifier).obtenerHistorial(widget.galponId);
      },
      child: Column(
        children: [
          // Filtro activo
          if (state.filtroTipo != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              child: Row(
                children: [
                  const Icon(Icons.filter_alt, size: 16),
                  const SizedBox(width: 8),
                  Text('Filtrado: ${_getTipoNombre(state.filtroTipo!)}'),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      ref.read(sanidadControllerProvider.notifier).limpiarFiltro();
                    },
                    child: const Text('Limpiar'),
                  ),
                ],
              ),
            ),
          // Lista de registros
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.historial.length,
              itemBuilder: (context, index) {
                final registro = state.historial[index];
                return RegistroSanitarioCard(registro: registro);
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getTipoNombre(TipoEventoSanitario tipo) {
    switch (tipo) {
      case TipoEventoSanitario.vacunacion:
        return 'Vacunación';
      case TipoEventoSanitario.tratamiento:
        return 'Tratamiento';
      case TipoEventoSanitario.inspeccion:
        return 'Inspección';
      case TipoEventoSanitario.cuarentena:
        return 'Cuarentena';
      case TipoEventoSanitario.desparasitacion:
        return 'Desparasitación';
    }
  }
}
