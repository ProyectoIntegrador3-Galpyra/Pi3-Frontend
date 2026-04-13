import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/colors.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/loading.dart';
import '../controllers/aves_controller.dart';

/// Página para registrar mortalidad
class MortalidadFormPage extends ConsumerStatefulWidget {
  final String galponId;

  const MortalidadFormPage({super.key, required this.galponId});

  @override
  ConsumerState<MortalidadFormPage> createState() => _MortalidadFormPageState();
}

class _MortalidadFormPageState extends ConsumerState<MortalidadFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _cantidadController = TextEditingController();
  final _observacionesController = TextEditingController();
  String _causaSeleccionada = 'Enfermedad';
  DateTime _fechaSeleccionada = DateTime.now();

  final List<String> _causas = [
    'Enfermedad',
    'Accidente/Trauma',
    'Depredador',
    'Calor/Estrés',
    'Causa desconocida',
    'Otra',
  ];

  @override
  void dispose() {
    _cantidadController.dispose();
    _observacionesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _fechaSeleccionada = picked;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final success =
        await ref.read(avesControllerProvider.notifier).registrarMortalidad(
              galponId: widget.galponId,
              cantidad: int.parse(_cantidadController.text),
              causa: _causaSeleccionada,
              fecha: _fechaSeleccionada,
              observaciones: _observacionesController.text.isNotEmpty
                  ? _observacionesController.text
                  : null,
            );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mortalidad registrada correctamente')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(avesControllerProvider);

    return AppScaffold(
      title: 'Registrar Mortalidad',
      body: state.isLoading
          ? const Loading()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Info card
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.red.withOpacity(0.3), width: 1),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning_rounded,
                              color: Colors.red.shade700, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Registra mortalidad para mantener actualizado tu inventario',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.red.shade700,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Main data section
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Datos del evento',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryDark,
                                ),
                          ),
                          const SizedBox(height: 12),
                          // Cantidad
                          AppTextField(
                            controller: _cantidadController,
                            label: 'Cantidad de aves fallecidas',
                            hint: 'Ej: 5',
                            keyboardType: TextInputType.number,
                            prefixIcon: Icons.numbers,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese la cantidad';
                              }
                              final cantidad = int.tryParse(value);
                              if (cantidad == null || cantidad <= 0) {
                                return 'Ingrese un número válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),

                          // Causa
                          DropdownButtonFormField<String>(
                            value: _causaSeleccionada,
                            decoration: InputDecoration(
                              labelText: 'Causa de mortalidad',
                              prefixIcon:
                                  const Icon(Icons.report_problem_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor:
                                  AppColors.surfaceVariant.withOpacity(0.3),
                            ),
                            items: _causas
                                .map((causa) => DropdownMenuItem(
                                      value: causa,
                                      child: Text(causa),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _causaSeleccionada = value;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 14),

                          // Fecha
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.calendar_today),
                              title: const Text('Fecha del evento'),
                              subtitle: Text(
                                '${_fechaSeleccionada.day}/${_fechaSeleccionada.month}/${_fechaSeleccionada.year}',
                              ),
                              trailing: TextButton(
                                onPressed: _selectDate,
                                child: const Text('Cambiar'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Additional info section
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Información adicional',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryDark,
                                ),
                          ),
                          const SizedBox(height: 12),
                          // Observaciones
                          AppTextField(
                            controller: _observacionesController,
                            label: 'Observaciones',
                            hint: 'Detalles adicionales (opcional)',
                            maxLines: 3,
                            prefixIcon: Icons.notes,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Error message
                    if (state.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          state.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),

                    // Submit button
                    AppButton(
                      text: 'Registrar Mortalidad',
                      onPressed: _submit,
                      isLoading: state.isLoading,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
