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
  ConsumerState<AlimentacionFormPage> createState() => _AlimentacionFormPageState();
}

class _AlimentacionFormPageState extends ConsumerState<AlimentacionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreAlimentoController = TextEditingController();
  final _cantidadController = TextEditingController();
  final _costoController = TextEditingController();
  final _avesController = TextEditingController();
  final _loteController = TextEditingController();
  final _proveedorController = TextEditingController();
  final _observacionesController = TextEditingController();

  TipoAlimento _tipoSeleccionado = TipoAlimento.concentrado;
  DateTime _fechaSeleccionada = DateTime.now();

  final List<String> _alimentosSugeridos = [
    'Concentrado Ponedoras Fase 1',
    'Concentrado Ponedoras Fase 2',
    'Concentrado Inicio',
    'Concentrado Crecimiento',
    'Maíz molido',
    'Soya integral',
    'Vitaminas ADE',
    'Minerales',
  ];

  @override
  void dispose() {
    _nombreAlimentoController.dispose();
    _cantidadController.dispose();
    _costoController.dispose();
    _avesController.dispose();
    _loteController.dispose();
    _proveedorController.dispose();
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

    final success = await ref.read(alimentacionControllerProvider.notifier).registrarAlimentacion(
          galponId: widget.galponId,
          fecha: _fechaSeleccionada,
          tipoAlimento: _tipoSeleccionado,
          nombreAlimento: _nombreAlimentoController.text,
          cantidadKg: double.parse(_cantidadController.text),
          costoUnitario: _costoController.text.isNotEmpty
              ? double.parse(_costoController.text)
              : null,
          numeroAves: _avesController.text.isNotEmpty
              ? int.parse(_avesController.text)
              : null,
          loteAlimento: _loteController.text.isNotEmpty ? _loteController.text : null,
          proveedor: _proveedorController.text.isNotEmpty
              ? _proveedorController.text
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
                    DropdownButtonFormField<TipoAlimento>(
                      value: _tipoSeleccionado,
                      decoration: const InputDecoration(
                        labelText: 'Tipo de alimento',
                        prefixIcon: Icon(Icons.category),
                        border: OutlineInputBorder(),
                      ),
                      items: TipoAlimento.values
                          .map((tipo) => DropdownMenuItem(
                                value: tipo,
                                child: Text(_getTipoNombre(tipo)),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _tipoSeleccionado = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Nombre del alimento con sugerencias
                    Autocomplete<String>(
                      optionsBuilder: (textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return _alimentosSugeridos;
                        }
                        return _alimentosSugeridos.where((alimento) => alimento
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()));
                      },
                      onSelected: (selection) {
                        _nombreAlimentoController.text = selection;
                      },
                      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                        controller.text = _nombreAlimentoController.text;
                        controller.addListener(() {
                          _nombreAlimentoController.text = controller.text;
                        });
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: const InputDecoration(
                            labelText: 'Nombre del alimento',
                            hintText: 'Ej: Concentrado Ponedoras',
                            prefixIcon: Icon(Icons.restaurant),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese el nombre del alimento';
                            }
                            return null;
                          },
                        );
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
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            prefixIcon: Icons.attach_money,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Número de aves
                    AppTextField(
                      controller: _avesController,
                      label: 'Número de aves',
                      hint: 'Para calcular consumo por ave (opcional)',
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.pets,
                    ),
                    const SizedBox(height: 16),

                    // Lote y proveedor
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: _loteController,
                            label: 'Lote',
                            hint: 'Opcional',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppTextField(
                            controller: _proveedorController,
                            label: 'Proveedor',
                            hint: 'Opcional',
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

  String _getTipoNombre(TipoAlimento tipo) {
    switch (tipo) {
      case TipoAlimento.concentrado:
        return 'Concentrado';
      case TipoAlimento.maiz:
        return 'Maíz';
      case TipoAlimento.soya:
        return 'Soya';
      case TipoAlimento.vitaminas:
        return 'Vitaminas';
      case TipoAlimento.minerales:
        return 'Minerales';
      case TipoAlimento.otro:
        return 'Otro';
    }
  }
}
