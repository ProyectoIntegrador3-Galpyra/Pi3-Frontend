import 'package:flutter/material.dart';
import '../../domain/entities/reporte.dart';
import '../../../../core/utils/date_utils.dart' as app_date;
import '../../../../config/theme/colors.dart';

/// Card para mostrar un reporte en la lista
class ReporteCard extends StatelessWidget {
  final Reporte reporte;
  final VoidCallback? onTap;

  const ReporteCard({
    super.key,
    required this.reporte,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _getTipoColor(reporte.tipo).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getTipoIcon(reporte.tipo),
                      color: _getTipoColor(reporte.tipo),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reporte.titulo,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getTipoLabel(reporte.tipo),
                          style: TextStyle(
                            color: _getTipoColor(reporte.tipo),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 16),

              // Info
              Row(
                children: [
                  _buildInfoChip(
                    Icons.calendar_today,
                    '${_formatDate(reporte.fechaInicio)} - ${_formatDate(reporte.fechaFin)}',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildInfoChip(
                    Icons.access_time,
                    'Generado: ${app_date.AppDateUtils.formatDateTime(reporte.fechaGeneracion)}',
                  ),
                  if (reporte.formato != null) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        reporte.formato!.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),

              // Resumen si está disponible
              if (reporte.resumen != null) ...[
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildResumenItem(
                      'Indicador',
                      reporte.resumen!['indicadorPrincipal']?.toString() ?? '-',
                    ),
                    _buildResumenItem(
                      'Tendencia',
                      reporte.resumen!['tendencia']?.toString() ?? '-',
                    ),
                    if ((reporte.resumen!['alertas'] as int?) != null &&
                        (reporte.resumen!['alertas'] as int) > 0)
                      _buildResumenItem(
                        'Alertas',
                        '${reporte.resumen!['alertas']}',
                        isAlert: true,
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildResumenItem(String label, String value, {bool isAlert = false}) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isAlert ? Colors.red : null,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Color _getTipoColor(TipoReporte tipo) {
    switch (tipo) {
      case TipoReporte.produccion:
        return Colors.orange;
      case TipoReporte.mortalidad:
        return Colors.red;
      case TipoReporte.alimentacion:
        return AppColors.success;
      case TipoReporte.sanitario:
        return Colors.blue;
      case TipoReporte.inventario:
        return Colors.purple;
      case TipoReporte.financiero:
        return Colors.teal;
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
