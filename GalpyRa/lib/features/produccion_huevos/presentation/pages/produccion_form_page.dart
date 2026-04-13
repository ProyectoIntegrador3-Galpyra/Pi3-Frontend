import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/colors.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/loading.dart';
import '../controllers/produccion_huevos_controller.dart';

/// Formulario para registrar producción de huevos
class ProduccionFormPage extends ConsumerStatefulWidget {
  final String galponId;

  const ProduccionFormPage({super.key, required this.galponId});

  @override
  ConsumerState<ProduccionFormPage> createState() => _ProduccionFormPageState();
}

class _ProduccionFormPageState extends ConsumerState<ProduccionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _cantidadTotalController = TextEditingController();
  final _rotosController = TextEditingController(text: '0');
  final _suciosController = TextEditingController(text: '0');
  final _grandeAAController = TextEditingController(text: '0');
  final _grandeAController = TextEditingController(text: '0');
  final _aaController = TextEditingController(text: '0');
  final _medianoController = TextEditingController(text: '0');
  final _pequenoController = TextEditingController(text: '0');
  final _cController = TextEditingController(text: '0');
  final _observacionesController = TextEditingController();
  DateTime _fechaSeleccionada = DateTime.now();

  @override
  void dispose() {
    _cantidadTotalController.dispose();
    _rotosController.dispose();
    _suciosController.dispose();
    _grandeAAController.dispose();
    _grandeAController.dispose();
    _aaController.dispose();
    _medianoController.dispose();
    _pequenoController.dispose();
    _cController.dispose();
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

    final categoriaAA = int.tryParse(_aaController.text) ?? 0;
    final categoriaA = int.tryParse(_medianoController.text) ?? 0;
    final categoriaB = int.tryParse(_pequenoController.text) ?? 0;
    final categoriaC = int.tryParse(_cController.text) ?? 0;
    final success = await ref
        .read(produccionHuevosControllerProvider.notifier)
        .registrarProduccion(
          galponId: widget.galponId,
          fecha: _fechaSeleccionada,
          cantidadTotal: int.parse(_cantidadTotalController.text),
          huevosRotos: int.tryParse(_rotosController.text) ?? 0,
          huevosSucios: int.tryParse(_suciosController.text) ?? 0,
          huevosGrandeAA: int.tryParse(_grandeAAController.text) ?? 0,
          huevosGrandeA: int.tryParse(_grandeAController.text) ?? 0,
          // Mapeo temporal de ICONTEC al contrato actual del backend.
          huevosMediano: categoriaAA,
          huevosPequeno: categoriaA + categoriaB + categoriaC,
          observaciones: _observacionesController.text.isNotEmpty
              ? '${_observacionesController.text}\nICONTEC A (53-59.9g): $categoriaA\nICONTEC B (46-52.9g): $categoriaB\nICONTEC C (<46g): $categoriaC'
              : 'ICONTEC A (53-59.9g): $categoriaA\nICONTEC B (46-52.9g): $categoriaB\nICONTEC C (<46g): $categoriaC',
        );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producción registrada correctamente')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(produccionHuevosControllerProvider);

    return AppScaffold(
      title: 'Registrar Producción',
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
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.calendar_today),
                        title: const Text('Fecha'),
                        subtitle: Text(
                          '${_fechaSeleccionada.day}/${_fechaSeleccionada.month}/${_fechaSeleccionada.year}',
                        ),
                        trailing: TextButton(
                          onPressed: _selectDate,
                          child: const Text('Cambiar'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Cantidad total
                    AppTextField(
                      controller: _cantidadTotalController,
                      label: 'Cantidad total de huevos',
                      hint: 'Ej: 4200',
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.egg,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese la cantidad total';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Ingrese un número válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

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
                            'Clasificación ICONTEC 1240',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryDark,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  controller: _grandeAAController,
                                  label: 'YUMBO (>78g)',
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: AppTextField(
                                  controller: _grandeAController,
                                  label: 'AAA (67-77.9g)',
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  controller: _aaController,
                                  label: 'AA (60-66.9g)',
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: AppTextField(
                                  controller: _medianoController,
                                  label: 'A (53-59.9g)',
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  controller: _pequenoController,
                                  label: 'B (46-52.9g)',
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: AppTextField(
                                  controller: _cController,
                                  label: 'C (<46g)',
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

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
                            'Mermas',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryDark,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  controller: _rotosController,
                                  label: 'Rotos',
                                  keyboardType: TextInputType.number,
                                  prefixIcon: Icons.broken_image_outlined,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: AppTextField(
                                  controller: _suciosController,
                                  label: 'Sucios',
                                  keyboardType: TextInputType.number,
                                  prefixIcon: Icons.blur_on,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Observaciones
                    AppTextField(
                      controller: _observacionesController,
                      label: 'Observaciones',
                      hint: 'Notas adicionales (opcional)',
                      maxLines: 2,
                      prefixIcon: Icons.notes,
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
                      text: 'Guardar Producción',
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
