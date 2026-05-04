import 'package:flutter/material.dart';
import '../../../../config/theme/colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../domain/entities/galpon.dart';

/// Card widget for displaying galpon info
class GalponCard extends StatelessWidget {
  const GalponCard({
    super.key,
    required this.galpon,
    this.onTap,
  });

  final Galpon galpon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.home_work_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          galpon.nombre,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        if (galpon.ubicacion != null)
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 14,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  galpon.ubicacion!,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getOccupancyColor().withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      Formatters.formatPercentage(galpon.porcentajeOcupacion, decimalPlaces: 0),
                      style: TextStyle(
                        color: _getOccupancyColor(),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: galpon.porcentajeOcupacion / 100,
                backgroundColor: AppColors.surfaceVariant,
                valueColor: AlwaysStoppedAnimation(_getOccupancyColor()),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${Formatters.formatNumber(galpon.cantidadActual)} / ${Formatters.formatNumber(galpon.capacidadMaxima)} aves',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (!galpon.activo)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Inactivo',
                        style: TextStyle(
                          color: AppColors.error,
                          fontSize: 10,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getOccupancyColor() {
    if (galpon.porcentajeOcupacion > 90) {
      return AppColors.error;
    } else if (galpon.porcentajeOcupacion > 70) {
      return AppColors.warning;
    }
    return AppColors.success;
  }
}
