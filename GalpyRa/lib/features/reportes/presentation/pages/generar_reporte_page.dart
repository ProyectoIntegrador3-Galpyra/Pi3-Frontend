import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/loading.dart';
import '../../domain/entities/reporte.dart';
import '../controllers/reportes_controller.dart';

/// Página para generar un nuevo reporte
class GenerarReportePage extends ConsumerStatefulWidget {
  const GenerarReportePage({super.key});

  @override
  ConsumerState<GenerarReportePage> createState() => _GenerarReportePageState();
}

class _GenerarReportePageState extends ConsumerState<GenerarReportePage> {
  TipoReporte _tipoSeleccionado = TipoReporte.produccion;
  FormatoExportacion _formatoSeleccionado = FormatoExportacion.pdf;
  DateTime _fechaInicio = DateTime.now().subtract(const Duration(days: 7));
  DateTime _fechaFin = DateTime.now();
  String? _galponIdSeleccionado;

  Future<void> _generarReporte() async {
    if (_fechaInicio.isAfter(_fechaFin)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La fecha de inicio debe ser anterior a la fecha fin'),
        ),
      );
      return;
    }

    final parametros = ParametrosReporte(
      tipo: _tipoSeleccionado,
      fechaInicio: _fechaInicio,
      fechaFin: _fechaFin,
      galponId: _galponIdSeleccionado,
      formato: _formatoSeleccionado,
    );

    final reporte = await ref
        .read(reportesControllerProvider.notifier)
        .generarReporte(parametros);

    if (reporte != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reporte generado exitosamente')),
      );
      context.pop();
    }
  }

  Future<void> _seleccionarFecha(bool esInicio) async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: esInicio ? _fechaInicio : _fechaFin,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );

    if (fecha != null) {
      setState(() {
        if (esInicio) {
          _fechaInicio = fecha;
        } else {
          _fechaFin = fecha;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reportesControllerProvider);

    return AppScaffold(
      title: 'Generar Reporte',
      body: state.isGenerando
          ? const Loading(message: 'Generando reporte...')
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Tipo de reporte
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tipo de Reporte',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: TipoReporte.values.map((tipo) {
                              return ChoiceChip(
                                label: Text(_getTipoLabel(tipo)),
                                avatar: Icon(
                                  _getTipoIcon(tipo),
                                  size: 18,
                                ),
                                selected: _tipoSeleccionado == tipo,
                                onSelected: (selected) {
                                  if (selected) {
                                    setState(() => _tipoSeleccionado = tipo);
                                  }
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Rango de fechas
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Rango de Fechas',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _buildFechaSelector(
                                  'Desde',
                                  _fechaInicio,
                                  () => _seleccionarFecha(true),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildFechaSelector(
                                  'Hasta',
                                  _fechaFin,
                                  () => _seleccionarFecha(false),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Atajos de fechas
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _buildAtajo('Última semana', 7),
                                _buildAtajo('Último mes', 30),
                                _buildAtajo('Últimos 3 meses', 90),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Formato de exportación
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Formato de Exportación',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            children: FormatoExportacion.values.map((formato) {
                              return ChoiceChip(
                                label: Text(formato.name.toUpperCase()),
                                selected: _formatoSeleccionado == formato,
                                onSelected: (selected) {
                                  if (selected) {
                                    setState(() => _formatoSeleccionado = formato);
                                  }
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Error
                  if (state.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        state.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  // Botón generar
                  AppButton(
                    text: 'Generar Reporte',
                    onPressed: _generarReporte,
                    icon: Icons.description,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildFechaSelector(
    String label,
    DateTime fecha,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 8),
                Text(
                  '${fecha.day}/${fecha.month}/${fecha.year}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAtajo(String label, int dias) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(label),
        onPressed: () {
          setState(() {
            _fechaFin = DateTime.now();
            _fechaInicio = _fechaFin.subtract(Duration(days: dias));
          });
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

  IconData _getTipoIcon(TipoReporte tipo) {
    switch (tipo) {
      case TipoReporte.produccion:
        return Icons.egg;
      case TipoReporte.mortalidad:
        return Icons.warning;
      case TipoReporte.alimentacion:
        return Icons.restaurant;
      case TipoReporte.sanitario:
        return Icons.local_hospital;
      case TipoReporte.inventario:
        return Icons.inventory;
      case TipoReporte.financiero:
        return Icons.attach_money;
    }
  }
}
