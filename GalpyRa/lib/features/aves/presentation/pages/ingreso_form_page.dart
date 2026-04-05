import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/colors.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/loading.dart';
import '../controllers/aves_controller.dart';

/// Página para registrar ingreso de aves
class IngresoFormPage extends ConsumerStatefulWidget {
  final String galponId;

  const IngresoFormPage({super.key, required this.galponId});

  @override
  ConsumerState<IngresoFormPage> createState() => _IngresoFormPageState();
}

class _IngresoFormPageState extends ConsumerState<IngresoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _razaController = TextEditingController();
  final _cantidadController = TextEditingController();
  final _edadController = TextEditingController();
  final _pesoController = TextEditingController();
  final _observacionesController = TextEditingController();
  DateTime _fechaIngreso = DateTime.now();

  final List<String> _razasSugeridas = [
    'Hy-Line Brown',
    'Hy-Line W-36',
    'Lohmann LSL',
    'Lohmann Brown',
    'ISA Brown',
    'Ross 308',
    'Cobb 500',
  ];

  @override
  void dispose() {
    _razaController.dispose();
    _cantidadController.dispose();
    _edadController.dispose();
    _pesoController.dispose();
    _observacionesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fechaIngreso,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() {
        _fechaIngreso = picked;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(avesControllerProvider.notifier).registrarIngreso(
          galponId: widget.galponId,
          raza: _razaController.text,
          cantidad: int.parse(_cantidadController.text),
          fechaIngreso: _fechaIngreso,
          edadSemanas:
              _edadController.text.isNotEmpty ? int.parse(_edadController.text) : 0,
          pesoPromedio:
              _pesoController.text.isNotEmpty ? double.parse(_pesoController.text) : null,
          observaciones: _observacionesController.text.isNotEmpty
              ? _observacionesController.text
              : null,
        );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingreso registrado correctamente')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(avesControllerProvider);

    return AppScaffold(
      title: 'Registrar Ingreso',
      body: state.isLoading
          ? const Loading()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                            'Datos principales',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryDark,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Autocomplete<String>(
                            optionsBuilder: (textEditingValue) {
                              if (textEditingValue.text.isEmpty) {
                                return _razasSugeridas;
                              }
                              return _razasSugeridas.where((raza) =>
                                  raza.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                            },
                            onSelected: (selection) {
                              _razaController.text = selection;
                            },
                            fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                              controller.text = _razaController.text;
                              controller.addListener(() {
                                _razaController.text = controller.text;
                              });
                              return TextFormField(
                                controller: controller,
                                focusNode: focusNode,
                                decoration: const InputDecoration(
                                  labelText: 'Raza',
                                  hintText: 'Ej: Hy-Line Brown',
                                  prefixIcon: Icon(Icons.pets),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ingrese la raza';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          AppTextField(
                            controller: _cantidadController,
                            label: 'Cantidad de aves',
                            hint: 'Ej: 5000',
                            keyboardType: TextInputType.number,
                            prefixIcon: Icons.numbers,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese la cantidad';
                              }
                              final cantidad = int.tryParse(value);
                              if (cantidad == null || cantidad <= 0) {
                                return 'Ingrese un numero valido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.calendar_today),
                              title: const Text('Fecha de ingreso'),
                              subtitle: Text(
                                '${_fechaIngreso.day}/${_fechaIngreso.month}/${_fechaIngreso.year}',
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
                            'Informacion adicional',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryDark,
                                ),
                          ),
                          const SizedBox(height: 12),
                          AppTextField(
                            controller: _edadController,
                            label: 'Edad (semanas)',
                            hint: 'Ej: 18 (opcional)',
                            keyboardType: TextInputType.number,
                            prefixIcon: Icons.timelapse,
                          ),
                          const SizedBox(height: 12),
                          AppTextField(
                            controller: _pesoController,
                            label: 'Peso promedio (kg)',
                            hint: 'Ej: 1.85 (opcional)',
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            prefixIcon: Icons.scale,
                          ),
                          const SizedBox(height: 12),
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
                      text: 'Registrar Ingreso',
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
