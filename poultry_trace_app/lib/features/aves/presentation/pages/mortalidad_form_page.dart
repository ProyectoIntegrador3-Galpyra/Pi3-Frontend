import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    'Asfixia',
    'Depredador',
    'Accidente',
    'Edad avanzada',
    'Desconocida',
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

    final success = await ref.read(avesControllerProvider.notifier).registrarMortalidad(
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
                    // Cantidad
                    AppTextField(
                      controller: _cantidadController,
                      label: 'Cantidad de aves',
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
                    const SizedBox(height: 16),

                    // Causa
                    DropdownButtonFormField<String>(
                      value: _causaSeleccionada,
                      decoration: const InputDecoration(
                        labelText: 'Causa de mortalidad',
                        prefixIcon: Icon(Icons.report_problem_outlined),
                        border: OutlineInputBorder(),
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
                    const SizedBox(height: 16),

                    // Fecha
                    ListTile(
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
                    const Divider(),
                    const SizedBox(height: 16),

                    // Observaciones
                    AppTextField(
                      controller: _observacionesController,
                      label: 'Observaciones',
                      hint: 'Detalles adicionales (opcional)',
                      maxLines: 3,
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
