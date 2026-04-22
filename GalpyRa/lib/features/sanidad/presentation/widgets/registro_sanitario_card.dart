import 'package:flutter/material.dart';
import '../../domain/entities/registro_sanitario.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../config/theme/colors.dart';

/// Card para mostrar registro sanitario
class RegistroSanitarioCard extends StatelessWidget {
  final RegistroSanitario registro;
  final VoidCallback? onTap;

  const RegistroSanitarioCard({
    super.key,
    required this.registro,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
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
                          _getTipoColor(registro.tipo).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getTipoIcon(registro.tipo),
                      color: _getTipoColor(registro.tipo),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          registro.descripcion,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          registro.tipoNombre,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: _getTipoColor(registro.tipo),
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    AppDateUtils.formatDate(registro.fecha),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),

              // Details
              if (registro.medicamento != null ||
                  registro.veterinario != null) ...[
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    if (registro.medicamento != null)
                      _buildDetailChip(
                        context,
                        Icons.medical_services,
                        registro.medicamento!,
                        registro.dosis != null ? ' (${registro.dosis})' : '',
                      ),
                    if (registro.veterinario != null)
                      _buildDetailChip(
                          context, Icons.person, registro.veterinario!),
                    if (registro.avesAfectadas != null)
                      _buildDetailChip(
                        context,
                        Icons.pets,
                        '${registro.avesAfectadas} aves afectadas',
                      ),
                  ],
                ),
              ],

              // Próxima aplicación
              if (registro.tienePendiente) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: Colors.amber.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.event_repeat,
                          size: 16, color: Colors.amber),
                      const SizedBox(width: 8),
                      Text(
                        'Próxima: ${AppDateUtils.formatDate(registro.fechaProximaAplicacion!)}',
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Observaciones
              if (registro.observaciones != null &&
                  registro.observaciones!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  registro.observaciones!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailChip(BuildContext context, IconData icon, String text,
      [String? suffix]) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          '$text${suffix ?? ''}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Color _getTipoColor(TipoEventoSanitario tipo) {
    switch (tipo) {
      case TipoEventoSanitario.vacunacion:
        return Colors.blue;
      case TipoEventoSanitario.tratamiento:
        return Colors.red;
      case TipoEventoSanitario.inspeccion:
        return AppColors.success;
      case TipoEventoSanitario.cuarentena:
        return Colors.orange;
      case TipoEventoSanitario.desparasitacion:
        return Colors.purple;
    }
  }

  IconData _getTipoIcon(TipoEventoSanitario tipo) {
    switch (tipo) {
      case TipoEventoSanitario.vacunacion:
        return Icons.vaccines;
      case TipoEventoSanitario.tratamiento:
        return Icons.healing;
      case TipoEventoSanitario.inspeccion:
        return Icons.search;
      case TipoEventoSanitario.cuarentena:
        return Icons.warning;
      case TipoEventoSanitario.desparasitacion:
        return Icons.bug_report;
    }
  }
}
