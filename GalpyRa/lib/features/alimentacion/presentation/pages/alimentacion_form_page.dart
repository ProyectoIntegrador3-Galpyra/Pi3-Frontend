import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/loading.dart';
import '../../domain/entities/registro_alimentacion.dart';
import '../controllers/alimentacion_controller.dart';

/// Formulario de alimentación
class AlimentacionFormPage extends ConsumerStatefulWidget {
  final String galponId;

  const AlimentacionFormPage({super.key, required this.galponId});

  @override
  ConsumerState<AlimentacionFormPage> createState() =>
      _AlimentacionFormPageState();
}

class _AlimentacionFormPageState extends ConsumerState<AlimentacionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _cantidadController = TextEditingController();
  final _costoController = TextEditingController();
  final _observacionesController = TextEditingController();

  TipoAlimento _tipoSeleccionado = TipoAlimento.concentrado;
  String _tipoNombreSeleccionado = 'Ponedoras I';
  DateTime _fechaSeleccionada = DateTime.now();

  final List<String> _tiposAlimentoReales = [
    'Pollitas',
    'Pollas',
    'Prepostura P-80',
    'Ponedoras I',
    'Ponedoras I SP',
    'Campo Huevo',
    'Carbonato de Calcio',
    'Otro',
  ];

  @override
  void dispose() {
    _cantidadController.dispose();
    _costoController.dispose();
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

    final success = await ref
        .read(alimentacionControllerProvider.notifier)
        .registrarAlimentacion(
          galponId: widget.galponId,
          fecha: _fechaSeleccionada,
          tipoAlimento: _tipoSeleccionado,
          nombreAlimento: _tipoNombreSeleccionado,
          cantidadKg: double.parse(_cantidadController.text),
          costoUnitario: _costoController.text.isNotEmpty
              ? double.parse(_costoController.text)
              : null,
          observaciones: _observacionesController.text.isNotEmpty
              ? _observacionesController.text
              : null,
        );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Alimentación registrada')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(alimentacionControllerProvider);

    return AppScaffold(
      title: 'Registrar Alimentación',
      body: state.isLoading
          ? const Loading()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Fecha
                    Card(
                      child: ListTile(
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

                    // Tipo de alimento
                    DropdownButtonFormField<String>(
                      value: _tipoNombreSeleccionado,
                      decoration: const InputDecoration(
                        labelText: 'Tipo de alimento',
                        prefixIcon: Icon(Icons.category),
                        border: OutlineInputBorder(),
                      ),
                      items: _tiposAlimentoReales
                          .map((tipo) => DropdownMenuItem(
                                value: tipo,
                                child: Text(tipo),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _tipoNombreSeleccionado = value;
                            _tipoSeleccionado = value == 'Otro'
                                ? TipoAlimento.otro
                                : TipoAlimento.concentrado;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Cantidad y costo
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: _cantidadController,
                            label: 'Cantidad (kg)',
                            hint: 'Ej: 250',
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            prefixIcon: Icons.scale,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Requerido';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Número inválido';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppTextField(
                            controller: _costoController,
                            label: 'Costo/kg (\$)',
                            hint: 'Opcional',
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            prefixIcon: Icons.attach_money,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Observaciones
                    AppTextField(
                      controller: _observacionesController,
                      label: 'Observaciones',
                      hint: 'Notas adicionales',
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
                      text: 'Guardar Registro',
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
