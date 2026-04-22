import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading.dart';
import '../controllers/reportes_admin_controller.dart';

class AdminReportesPage extends ConsumerStatefulWidget {
  const AdminReportesPage({super.key});

  @override
  ConsumerState<AdminReportesPage> createState() => _AdminReportesPageState();
}

class _AdminReportesPageState extends ConsumerState<AdminReportesPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final TextEditingController _anioController;
  int? _mes;
  String? _galponId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    final year = DateTime.now().year;
    _anioController = TextEditingController(text: '$year');

    Future.microtask(() {
      ref.read(reportesAdminControllerProvider.notifier).cargarReportes();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _anioController.dispose();
    super.dispose();
  }

  Future<void> _aplicarFiltros() async {
    final year = int.tryParse(_anioController.text.trim());
    if (year == null) return;

    final notifier = ref.read(reportesAdminControllerProvider.notifier);
    notifier.actualizarFiltros(
      anio: year,
      mes: _mes,
      galponId: _galponId,
      limpiarGalpon: _galponId == null || _galponId!.trim().isEmpty,
    );
    await notifier.cargarReportes();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reportesAdminControllerProvider);

    return AppScaffold(
      title: 'Reportes Admin',
      body: Column(
        children: [
          _buildFiltros(),
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(text: 'Produccion'),
              Tab(text: 'Alimentacion'),
              Tab(text: 'Mortalidad'),
              Tab(text: 'Inventario'),
            ],
          ),
          Expanded(
            child: state.isLoading
                ? const Loading(message: 'Cargando reportes...')
                : state.error != null
                    ? ErrorView(
                        message: state.error!,
                        onRetry: _aplicarFiltros,
                      )
                    : TabBarView(
                        controller: _tabController,
                        children: [
                          _tablaProduccion(state),
                          _tablaAlimentacion(state),
                          _tablaMortalidad(state),
                          _tablaInventario(state),
                        ],
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltros() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: TextFormField(
              controller: _anioController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ano',
              ),
            ),
          ),
          SizedBox(
            width: 180,
            child: DropdownButtonFormField<int?>(
              value: _mes,
              decoration: const InputDecoration(labelText: 'Mes'),
              items: [
                const DropdownMenuItem<int?>(
                  value: null,
                  child: Text('Todos'),
                ),
                ...List.generate(
                  12,
                  (index) => DropdownMenuItem<int?>(
                    value: index + 1,
                    child: Text('Mes ${index + 1}'),
                  ),
                ),
              ],
              onChanged: (value) => setState(() => _mes = value),
            ),
          ),
          SizedBox(
            width: 180,
            child: DropdownButtonFormField<String?>(
              value: _galponId,
              decoration: const InputDecoration(labelText: 'Galpon'),
              items: const [
                DropdownMenuItem<String?>(
                  value: null,
                  child: Text('Todos'),
                ),
                DropdownMenuItem<String?>(
                  value: 'galpon-a',
                  child: Text('Galpon A'),
                ),
                DropdownMenuItem<String?>(
                  value: 'galpon-b',
                  child: Text('Galpon B'),
                ),
              ],
              onChanged: (value) => setState(() => _galponId = value),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _aplicarFiltros,
            icon: const Icon(Icons.search),
            label: const Text('Aplicar'),
          ),
        ],
      ),
    );
  }

  Widget _tablaProduccion(ReportesAdminState state) {
    final totalHuevos =
        state.produccion.fold<int>(0, (sum, item) => sum + item.totalHuevos);
    final promedio = state.produccion.isEmpty
        ? 0.0
        : state.produccion
                .fold<double>(0, (sum, item) => sum + item.promedioDiario) /
            state.produccion.length;

    return _tableWrapper(
      columns: const ['Periodo', 'Total huevos', 'Promedio diario'],
      rows: state.produccion
          .map(
            (item) => [
              item.periodo,
              '${item.totalHuevos}',
              item.promedioDiario.toStringAsFixed(2),
            ],
          )
          .toList(),
      resumen: 'Total huevos: $totalHuevos | Promedio diario: ${promedio.toStringAsFixed(2)}',
    );
  }

  Widget _tablaAlimentacion(ReportesAdminState state) {
    final totalKg =
        state.alimentacion.fold<double>(0, (sum, item) => sum + item.totalKg);
    final totalCosto = state.alimentacion
        .fold<double>(0, (sum, item) => sum + item.costoTotal);

    return _tableWrapper(
      columns: const ['Periodo', 'Total kg', 'Costo total'],
      rows: state.alimentacion
          .map(
            (item) => [
              item.periodo,
              item.totalKg.toStringAsFixed(2),
              item.costoTotal.toStringAsFixed(2),
            ],
          )
          .toList(),
      resumen:
          'Total kg: ${totalKg.toStringAsFixed(2)} | Costo total: ${totalCosto.toStringAsFixed(2)}',
    );
  }

  Widget _tablaMortalidad(ReportesAdminState state) {
    final totalBajas =
        state.mortalidad.fold<int>(0, (sum, item) => sum + item.totalBajas);
    final tasaPromedio = state.mortalidad.isEmpty
        ? 0.0
        : state.mortalidad
                .fold<double>(0, (sum, item) => sum + item.tasaMortalidad) /
            state.mortalidad.length;

    return _tableWrapper(
      columns: const ['Periodo', 'Total bajas', 'Tasa mortalidad'],
      rows: state.mortalidad
          .map(
            (item) => [
              item.periodo,
              '${item.totalBajas}',
              item.tasaMortalidad.toStringAsFixed(2),
            ],
          )
          .toList(),
      resumen:
          'Total bajas: $totalBajas | Tasa promedio: ${tasaPromedio.toStringAsFixed(2)}',
    );
  }

  Widget _tablaInventario(ReportesAdminState state) {
    final avesActuales = state.inventario
        .fold<int>(0, (sum, item) => sum + item.avesActuales);

    return _tableWrapper(
      columns: const ['Galpon', 'Aves iniciales', 'Bajas', 'Aves actuales'],
      rows: state.inventario
          .map(
            (item) => [
              item.galpon,
              '${item.avesIniciales}',
              '${item.bajas}',
              '${item.avesActuales}',
            ],
          )
          .toList(),
      resumen: 'Aves actuales totales: $avesActuales',
    );
  }

  Widget _tableWrapper({
    required List<String> columns,
    required List<List<String>> rows,
    required String resumen,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: columns
                  .map((title) => DataColumn(label: Text(title)))
                  .toList(),
              rows: rows
                  .map(
                    (items) => DataRow(
                      cells: items.map((item) => DataCell(Text(item))).toList(),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            resumen,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
