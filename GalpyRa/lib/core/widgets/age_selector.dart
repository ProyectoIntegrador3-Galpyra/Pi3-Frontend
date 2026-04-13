import 'package:flutter/material.dart';
import '../../../config/theme/colors.dart';

/// Age selector widget with slider and preset buttons
/// Displays age in weeks with visual feedback
class AgeSelector extends StatefulWidget {
  final int initialAge;
  final ValueChanged<int> onAgeChanged;
  final int minWeeks;
  final int maxWeeks;
  final String label;

  const AgeSelector({
    super.key,
    required this.initialAge,
    required this.onAgeChanged,
    this.minWeeks = 1,
    this.maxWeeks = 52,
    this.label = 'Edad (semanas)',
  });

  @override
  State<AgeSelector> createState() => _AgeSelectorState();
}

class _AgeSelectorState extends State<AgeSelector> {
  late int _selectedAge;

  // Common preset ages for poultry
  static const List<int> _presetAges = [1, 4, 8, 12, 16, 18, 20, 24, 30, 40, 52];

  @override
  void initState() {
    super.initState();
    _selectedAge = widget.initialAge.clamp(widget.minWeeks, widget.maxWeeks);
  }

  void _setAge(int age) {
    setState(() {
      _selectedAge = age.clamp(widget.minWeeks, widget.maxWeeks);
    });
    widget.onAgeChanged(_selectedAge);
  }

  String _ageDescription(int weeks) {
    final days = weeks * 7;
    if (weeks < 4) {
      return '$weeks semanas ($days días)';
    } else if (weeks < 16) {
      return '$weeks semanas (~${(weeks / 4).toStringAsFixed(1)} meses)';
    } else {
      return '$weeks semanas (~${(weeks / 52).toStringAsFixed(1)} años)';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title and current age display
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryDark,
                  ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.primaryLight, width: 1.5),
              ),
              child: Text(
                _ageDescription(_selectedAge),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.primaryLight,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Slider
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Column(
            children: [
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 6,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 14,
                    elevation: 4,
                  ),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                  activeTrackColor: AppColors.primaryLight,
                  inactiveTrackColor: AppColors.border,
                  thumbColor: AppColors.primaryLight,
                  overlayColor: AppColors.primaryLight.withOpacity(0.2),
                  valueIndicatorColor: AppColors.primaryLight,
                  valueIndicatorTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Slider(
                  value: _selectedAge.toDouble(),
                  min: widget.minWeeks.toDouble(),
                  max: widget.maxWeeks.toDouble(),
                  divisions: widget.maxWeeks - widget.minWeeks,
                  label: '$_selectedAge',
                  onChanged: (value) {
                    _setAge(value.toInt());
                  },
                ),
              ),
              const SizedBox(height: 8),
              // Min and Max labels
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.minWeeks}s',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    Text(
                      '${widget.maxWeeks}s',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Preset buttons
        Text(
          'Edades comunes',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int age in _presetAges) ...[
                _PresetAgeButton(
                  age: age,
                  isSelected: _selectedAge == age,
                  onPressed: () => _setAge(age),
                ),
                const SizedBox(width: 8),
              ]
            ],
          ),
        ),

        // Age details
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Info de edad',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _getAgeStageInfo(_selectedAge),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getAgeStageInfo(int weeks) {
    if (weeks < 1) {
      return 'Pollitas recién nacidas';
    } else if (weeks < 4) {
      return 'Fase de crianza: necesita temperatura controlada';
    } else if (weeks < 8) {
      return 'Crecimiento activo: dieta especial de levante';
    } else if (weeks < 12) {
      return 'Pre-postura: preparación reproductiva';
    } else if (weeks < 16) {
      return 'Inicio de madurez: esperando postura';
    } else if (weeks < 20) {
      return 'Edad de postura: producción activa comenzando';
    } else if (weeks < 72) {
      return 'Producción plena: máximo rendimiento esperado';
    } else {
      return 'Fase tardía: considerar recambio';
    }
  }
}

/// Individual preset age button
class _PresetAgeButton extends StatelessWidget {
  final int age;
  final bool isSelected;
  final VoidCallback onPressed;

  const _PresetAgeButton({
    required this.age,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryLight : AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? AppColors.primaryLight : AppColors.border,
              width: 1.5,
            ),
          ),
          child: Text(
            '${age}s',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
