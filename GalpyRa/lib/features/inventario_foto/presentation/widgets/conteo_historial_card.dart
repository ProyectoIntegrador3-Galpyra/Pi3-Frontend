import 'package:flutter/material.dart';
import '../../domain/entities/conteo_foto.dart';
import '../../../../core/utils/date_utils.dart' as app_date;
import '../../../../config/theme/colors.dart';

/// Card para mostrar historial de conteos por foto
class ConteoHistorialCard extends StatelessWidget {
  final ConteoFoto conteo;
  final VoidCallback? onTap;

  const ConteoHistorialCard({
    super.key,
    required this.conteo,
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
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:
                          _getEstadoColor(conteo.estado).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getEstadoIcon(conteo.estado),
                      color: _getEstadoColor(conteo.estado),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Galpón ${conteo.galponId}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          app_date.AppDateUtils.formatDateTime(
                              conteo.fechaCaptura),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildEstadoBadge(conteo.estado),
                ],
              ),
              const SizedBox(height: 16),

              // Conteo numbers
              Row(
                children: [
                  Expanded(
                    child: _buildConteoItem(
                      'Automático',
                      conteo.conteoAutomatico,
                      Icons.auto_fix_high,
                      Colors.blue,
                    ),
                  ),
                  if (conteo.conteoManual != null) ...[
                    Expanded(
                      child: _buildConteoItem(
                        'Manual',
                        conteo.conteoManual,
                        Icons.edit,
                        Colors.orange,
                      ),
                    ),
                  ],
                  Expanded(
                    child: _buildConteoItem(
                      'Final',
                      conteo.conteoFinal ??
                          conteo.conteoManual ??
                          conteo.conteoAutomatico,
                      Icons.check_circle,
                      AppColors.success,
                      isHighlighted: true,
                    ),
                  ),
                ],
              ),

              // Confidence bar
              if (conteo.confianza != null) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text(
                      'Confianza: ',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: conteo.confianza!,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getConfianzaColor(conteo.confianza!),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${(conteo.confianza! * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _getConfianzaColor(conteo.confianza!),
                      ),
                    ),
                  ],
                ),
              ],

              // Difference warning
              if (conteo.conteoManual != null &&
                  conteo.conteoAutomatico != null &&
                  conteo.conteoManual != conteo.conteoAutomatico) ...[
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.info_outline,
                          size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        'Ajustado manualmente (${_getDiferencia()})',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConteoItem(
    String label,
    int? value,
    IconData icon,
    Color color, {
    bool isHighlighted = false,
  }) {
    return Column(
      children: [
        Icon(icon, size: 16, color: color.withValues(alpha: 0.7)),
        const SizedBox(height: 4),
        Text(
          value?.toString() ?? '-',
          style: TextStyle(
            fontSize: isHighlighted ? 20 : 16,
            fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w600,
            color: isHighlighted ? color : null,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildEstadoBadge(EstadoConteo estado) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getEstadoColor(estado),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _getEstadoText(estado),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getEstadoColor(EstadoConteo estado) {
    switch (estado) {
      case EstadoConteo.pendiente:
        return Colors.orange;
      case EstadoConteo.procesando:
        return Colors.blue;
      case EstadoConteo.completado:
        return AppColors.success;
      case EstadoConteo.error:
        return Colors.red;
    }
  }

  IconData _getEstadoIcon(EstadoConteo estado) {
    switch (estado) {
      case EstadoConteo.pendiente:
        return Icons.pending;
      case EstadoConteo.procesando:
        return Icons.hourglass_top;
      case EstadoConteo.completado:
        return Icons.check_circle;
      case EstadoConteo.error:
        return Icons.error;
    }
  }

  String _getEstadoText(EstadoConteo estado) {
    switch (estado) {
      case EstadoConteo.pendiente:
        return 'Pendiente';
      case EstadoConteo.procesando:
        return 'Procesando';
      case EstadoConteo.completado:
        return 'Completado';
      case EstadoConteo.error:
        return 'Error';
    }
  }

  Color _getConfianzaColor(double confianza) {
    if (confianza >= 0.9) return AppColors.success;
    if (confianza >= 0.8) return Colors.amber;
    return Colors.orange;
  }

  String _getDiferencia() {
    if (conteo.conteoAutomatico == null || conteo.conteoManual == null) {
      return '0';
    }
    final dif = conteo.conteoManual! - conteo.conteoAutomatico!;
    return dif >= 0 ? '+$dif' : '$dif';
  }
}
