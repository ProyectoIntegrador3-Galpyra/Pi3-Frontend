import 'package:flutter/material.dart';
import '../../domain/entities/registro_alimentacion.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../config/theme/colors.dart';

/// Card para mostrar registro de alimentación
class AlimentacionCard extends StatelessWidget {
  final RegistroAlimentacion registro;
  final bool isToday;
  final VoidCallback? onTap;

  const AlimentacionCard({
    super.key,
    required this.registro,
    this.isToday = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isToday ? Theme.of(context).primaryColor.withValues(alpha: 0.05) : null,
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
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getTipoColor(registro.tipoAlimento).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getTipoIcon(registro.tipoAlimento),
                      color: _getTipoColor(registro.tipoAlimento),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          registro.nombreAlimento,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          registro.tipoNombre,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: _getTipoColor(registro.tipoAlimento),
                              ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${registro.cantidadKg.toStringAsFixed(0)} kg',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      Text(
                        isToday ? 'Hoy' : AppDateUtils.formatDate(registro.fecha),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                ],
              ),

              // Details
              if (registro.costoTotal != null ||
                  registro.consumoPorAve != null ||
                  registro.proveedor != null) ...[
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    if (registro.costoTotal != null)
                      _buildMetric(
                        context,
                        Icons.attach_money,
                        '\$${registro.costoTotal!.toStringAsFixed(2)}',
                        'Costo total',
                      ),
                    if (registro.consumoPorAve != null)
                      _buildMetric(
                        context,
                        Icons.pets,
                        '${(registro.consumoPorAve! * 1000).toStringAsFixed(0)}g',
                        'Por ave',
                      ),
                    if (registro.proveedor != null)
                      _buildMetric(
                        context,
                        Icons.business,
                        registro.proveedor!,
                        'Proveedor',
                      ),
                  ],
                ),
              ],

              // Lote
              if (registro.loteAlimento != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Lote: ${registro.loteAlimento}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ],

              // Observaciones
              if (registro.observaciones != null && registro.observaciones!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  registro.observaciones!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetric(BuildContext context, IconData icon, String value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getTipoColor(TipoAlimento tipo) {
    switch (tipo) {
      case TipoAlimento.concentrado:
        return Colors.amber;
      case TipoAlimento.maiz:
        return Colors.orange;
      case TipoAlimento.soya:
        return AppColors.success;
      case TipoAlimento.vitaminas:
        return Colors.blue;
      case TipoAlimento.minerales:
        return Colors.purple;
      case TipoAlimento.otro:
        return Colors.grey;
    }
  }

  IconData _getTipoIcon(TipoAlimento tipo) {
    switch (tipo) {
      case TipoAlimento.concentrado:
        return Icons.restaurant;
      case TipoAlimento.maiz:
        return Icons.grass;
      case TipoAlimento.soya:
        return Icons.eco;
      case TipoAlimento.vitaminas:
        return Icons.local_pharmacy;
      case TipoAlimento.minerales:
        return Icons.science;
      case TipoAlimento.otro:
        return Icons.inventory_2;
    }
  }
}
