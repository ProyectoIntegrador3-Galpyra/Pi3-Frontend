import 'package:flutter/material.dart';
import '../../domain/entities/produccion_huevos.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../config/theme/colors.dart';

/// Card para mostrar registro de producción
class ProduccionCard extends StatelessWidget {
  final ProduccionHuevos registro;
  final bool isToday;
  final VoidCallback? onTap;

  const ProduccionCard({
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: isToday ? Theme.of(context).primaryColor : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isToday ? 'Hoy' : AppDateUtils.formatDate(registro.fecha),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: isToday ? Theme.of(context).primaryColor : null,
                              fontWeight: isToday ? FontWeight.bold : null,
                            ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getPosturaColor(registro.porcentajePostura).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${registro.porcentajePostura.toStringAsFixed(1)}%',
                      style: TextStyle(
                        color: _getPosturaColor(registro.porcentajePostura),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Main stat
              Row(
                children: [
                  Expanded(
                    child: _buildMainStat(
                      context,
                      'Total',
                      registro.cantidadTotal.toString(),
                      Icons.egg,
                      Colors.amber,
                    ),
                  ),
                  Expanded(
                    child: _buildMainStat(
                      context,
                      'Aptos',
                      registro.huevosAptos.toString(),
                      Icons.check_circle,
                      AppColors.success,
                    ),
                  ),
                  Expanded(
                    child: _buildMainStat(
                      context,
                      'Merma',
                      '${(registro.huevosRotos + registro.huevosSucios)}',
                      Icons.warning,
                      Colors.orange,
                    ),
                  ),
                ],
              ),

              // Classification breakdown (if available)
              if (registro.huevosGrandeAA > 0 ||
                  registro.huevosGrandeA > 0 ||
                  registro.huevosMediano > 0 ||
                  registro.huevosPequeno > 0) ...[
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    if (registro.huevosGrandeAA > 0)
                      _buildClassificationChip('AA', registro.huevosGrandeAA),
                    if (registro.huevosGrandeA > 0)
                      _buildClassificationChip('A', registro.huevosGrandeA),
                    if (registro.huevosMediano > 0)
                      _buildClassificationChip('M', registro.huevosMediano),
                    if (registro.huevosPequeno > 0)
                      _buildClassificationChip('P', registro.huevosPequeno),
                  ],
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

  Widget _buildMainStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
    );
  }

  Widget _buildClassificationChip(String label, int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$label: $count',
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  Color _getPosturaColor(double porcentaje) {
    if (porcentaje >= 85) return AppColors.success;
    if (porcentaje >= 75) return Colors.amber;
    return Colors.red;
  }
}
