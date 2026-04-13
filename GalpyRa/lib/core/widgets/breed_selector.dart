import 'package:flutter/material.dart';
import '../../../config/theme/colors.dart';

/// Breed information model
class BreedInfo {
  final String name;
  final String icon; // emoji or icon name
  final String description;
  final String productionType; // egg, meat, dual
  final double estimatedEggsPerYear;

  const BreedInfo({
    required this.name,
    required this.icon,
    required this.description,
    required this.productionType,
    required this.estimatedEggsPerYear,
  });
}

/// Breed selector widget with predefined poultry breeds
class BreedSelector extends StatefulWidget {
  final String initialBreed;
  final ValueChanged<String> onBreedChanged;
  final String label;

  const BreedSelector({
    super.key,
    required this.initialBreed,
    required this.onBreedChanged,
    this.label = 'Raza',
  });

  @override
  State<BreedSelector> createState() => _BreedSelectorState();

  // Predefined breeds database
  static const List<BreedInfo> commonBreeds = [
    BreedInfo(
      name: 'Hy-Line Brown',
      icon: '🔴',
      description: 'Alta producción de huevos (310+ huevos/año)',
      productionType: 'egg',
      estimatedEggsPerYear: 310,
    ),
    BreedInfo(
      name: 'Hy-Line W-36',
      icon: '⚪',
      description: 'Huevos blancos de excelente calidad (300+ huevos/año)',
      productionType: 'egg',
      estimatedEggsPerYear: 300,
    ),
    BreedInfo(
      name: 'Lohmann LSL',
      icon: '⚪',
      description: 'Producción blanca eficiente (310+ huevos/año)',
      productionType: 'egg',
      estimatedEggsPerYear: 310,
    ),
    BreedInfo(
      name: 'Lohmann Brown',
      icon: '🔴',
      description: 'Raza robusta, buena adaptación (300+ huevos/año)',
      productionType: 'egg',
      estimatedEggsPerYear: 300,
    ),
    BreedInfo(
      name: 'ISA Brown',
      icon: '🔴',
      description: 'Excelente producción en clima tropical (300 huevos/año)',
      productionType: 'egg',
      estimatedEggsPerYear: 300,
    ),
    BreedInfo(
      name: 'Ross 308',
      icon: '🍗',
      description: 'Engorde rápido, buena conversión alimenticia',
      productionType: 'meat',
      estimatedEggsPerYear: 0,
    ),
    BreedInfo(
      name: 'Cobb 500',
      icon: '🍗',
      description: 'Producción de carne eficiente (ganancia diaria: 50-60g)',
      productionType: 'meat',
      estimatedEggsPerYear: 0,
    ),
    BreedInfo(
      name: 'Leghorn',
      icon: '⚪',
      description: 'Clásica postura blanca (280 huevos/año)',
      productionType: 'egg',
      estimatedEggsPerYear: 280,
    ),
    BreedInfo(
      name: 'Rhode Island Red',
      icon: '🔴',
      description: 'Para crianza de traspatio, rusticidad (260 huevos/año)',
      productionType: 'egg',
      estimatedEggsPerYear: 260,
    ),
    BreedInfo(
      name: 'Sussex',
      icon: '🟤',
      description: 'Doble propósito: huevo y carne (250+ huevos/año)',
      productionType: 'dual',
      estimatedEggsPerYear: 250,
    ),
  ];
}

class _BreedSelectorState extends State<BreedSelector> {
  late String _selectedBreed;
  bool _showDropdown = false;

  @override
  void initState() {
    super.initState();
    _selectedBreed = widget.initialBreed;
  }

  BreedInfo? _getBreedInfo(String breedName) {
    try {
      return BreedSelector.commonBreeds.firstWhere(
        (breed) => breed.name.toLowerCase() == breedName.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  void _selectBreed(String breedName) {
    setState(() {
      _selectedBreed = breedName;
      _showDropdown = false;
    });
    widget.onBreedChanged(breedName);
  }

  @override
  Widget build(BuildContext context) {
    final selectedBreedInfo = _getBreedInfo(_selectedBreed);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title
        Text(
          widget.label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryDark,
              ),
        ),
        const SizedBox(height: 8),

        // Current selection card
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _showDropdown ? AppColors.primaryLight : AppColors.border,
              width: 1.5,
            ),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                _showDropdown = !_showDropdown;
              });
            },
            child: Row(
              children: [
                if (selectedBreedInfo != null)
                  Text(
                    selectedBreedInfo.icon,
                    style: const TextStyle(fontSize: 24),
                  ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedBreed,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryDark,
                            ),
                      ),
                      if (selectedBreedInfo != null)
                        Text(
                          selectedBreedInfo.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                    ],
                  ),
                ),
                Icon(
                  _showDropdown ? Icons.expand_less : Icons.expand_more,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),

        // Dropdown options
        if (_showDropdown) ...[
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            constraints: const BoxConstraints(maxHeight: 350),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: BreedSelector.commonBreeds.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                color: AppColors.border,
                indent: 12,
                endIndent: 12,
              ),
              itemBuilder: (context, index) {
                final breed = BreedSelector.commonBreeds[index];
                final isSelected = breed.name == _selectedBreed;

                return InkWell(
                  onTap: () => _selectBreed(breed.name),
                  child: Container(
                    color: isSelected
                        ? AppColors.primaryLight.withOpacity(0.1)
                        : Colors.transparent,
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Text(breed.icon, style: const TextStyle(fontSize: 20)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                breed.name,
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w600,
                                      color: isSelected
                                          ? AppColors.primaryLight
                                          : AppColors.primaryDark,
                                    ),
                              ),
                              Text(
                                breed.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                      fontSize: 11,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(Icons.check, color: AppColors.primaryLight, size: 20),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],

        // Breed info card (when breed selected)
        if (selectedBreedInfo != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tipo de producción',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getProductionTypeColor(selectedBreedInfo.productionType),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _getProductionTypeLabel(selectedBreedInfo.productionType),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                if (selectedBreedInfo.estimatedEggsPerYear > 0) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.egg_rounded, size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          '~${selectedBreedInfo.estimatedEggsPerYear.toInt()} huevos/año',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }

  Color _getProductionTypeColor(String type) {
    switch (type) {
      case 'egg':
        return Colors.blue;
      case 'meat':
        return Colors.orange;
      case 'dual':
        return Colors.purple;
      default:
        return AppColors.textSecondary;
    }
  }

  String _getProductionTypeLabel(String type) {
    switch (type) {
      case 'egg':
        return 'Postura (Huevos)';
      case 'meat':
        return 'Carne (Engorde)';
      case 'dual':
        return 'Doble propósito';
      default:
        return type;
    }
  }
}
