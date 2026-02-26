import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/loading.dart';
import '../../domain/entities/registro_sanitario.dart';
import '../controllers/sanidad_controller.dart';

/// Formulario de registro sanitario
class SanidadFormPage extends ConsumerStatefulWidget {
  final String galponId;

  const SanidadFormPage({super.key, required this.galponId});

  @override
  ConsumerState<SanidadFormPage> createState() => _SanidadFormPageState();
}

class _SanidadFormPageState extends ConsumerState<SanidadFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _descripcionController = TextEditingController();
  final _medicamentoController = TextEditingController();
  final _dosisController = TextEditingController();
  final _veterinarioController = TextEditingController();
  final _avesAfectadasController = TextEditingController();
  final _observacionesController = TextEditingController();

  TipoEventoSanitario _tipoSeleccionado = TipoEventoSanitario.vacunacion;
  DateTime _fechaSeleccionada = DateTime.now();
  DateTime? _fechaProximaAplicacion;

  @override
  void dispose() {
    _descripcionController.dispose();
    _medicamentoController.dispose();
    _dosisController.dispose();
    _veterinarioController.dispose();
    _avesAfectadasController.dispose();
    _observacionesController.dispose();
    super.dispose();
  }

  Future<void> _selectFecha() async {
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

  Future<void> _selectFechaProxima() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fechaProximaAplicacion ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _fechaProximaAplicacion = picked;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(sanidadControllerProvider.notifier).registrarEvento(
          galponId: widget.galponId,
          tipo: _tipoSeleccionado,
          fecha: _fechaSeleccionada,
          descripcion: _descripcionController.text,
          medicamento: _medicamentoController.text.isNotEmpty
              ? _medicamentoController.text
              : null,
          dosis: _dosisController.text.isNotEmpty ? _dosisController.text : null,
          veterinario: _veterinarioController.text.isNotEmpty
              ? _veterinarioController.text
              : null,
          avesAfectadas: _avesAfectadasController.text.isNotEmpty
              ? int.tryParse(_avesAfectadasController.text)
              : null,
          fechaProximaAplicacion: _fechaProximaAplicacion,
          observaciones: _observacionesController.text.isNotEmpty
              ? _observacionesController.text
              : null,
        );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Evento sanitario registrado')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sanidadControllerProvider);

    return AppScaffold(
      title: 'Registrar Evento Sanitario',
      body: state.isLoading
          ? const Loading()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Tipo de evento
                    DropdownButtonFormField<TipoEventoSanitario>(
                      value: _tipoSeleccionado,
                      decoration: const InputDecoration(
                        labelText: 'Tipo de evento',
                        prefixIcon: Icon(Icons.category),
                        border: OutlineInputBorder(),
                      ),
                      items: TipoEventoSanitario.values
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

                    // Fecha
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.calendar_today),
                      title: const Text('Fecha del evento'),
                      subtitle: Text(
                        '${_fechaSeleccionada.day}/${_fechaSeleccionada.month}/${_fechaSeleccionada.year}',
                      ),
                      trailing: TextButton(
                        onPressed: _selectFecha,
                        child: const Text('Cambiar'),
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 16),

                    // Descripción
                    AppTextField(
                      controller: _descripcionController,
                      label: 'Descripción',
                      hint: 'Ej: Vacuna Newcastle B1',
                      prefixIcon: Icons.description,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese una descripción';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Medicamento y dosis
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: _medicamentoController,
                            label: 'Medicamento',
                            hint: 'Opcional',
                            prefixIcon: Icons.medical_services,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppTextField(
                            controller: _dosisController,
                            label: 'Dosis',
                            hint: 'Opcional',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Veterinario
                    AppTextField(
                      controller: _veterinarioController,
                      label: 'Veterinario responsable',
                      hint: 'Opcional',
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(height: 16),

                    // Aves afectadas
                    if (_tipoSeleccionado == TipoEventoSanitario.tratamiento ||
                        _tipoSeleccionado == TipoEventoSanitario.cuarentena)
                      AppTextField(
                        controller: _avesAfectadasController,
                        label: 'Aves afectadas',
                        hint: 'Número de aves',
                        keyboardType: TextInputType.number,
                        prefixIcon: Icons.pets,
                      ),
                    const SizedBox(height: 16),

                    // Próxima aplicación
                    if (_tipoSeleccionado == TipoEventoSanitario.vacunacion ||
                        _tipoSeleccionado == TipoEventoSanitario.desparasitacion)
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.event_repeat),
                          title: const Text('Próxima aplicación'),
                          subtitle: Text(
                            _fechaProximaAplicacion != null
                                ? '${_fechaProximaAplicacion!.day}/${_fechaProximaAplicacion!.month}/${_fechaProximaAplicacion!.year}'
                                : 'No programada',
                          ),
                          trailing: TextButton(
                            onPressed: _selectFechaProxima,
                            child: Text(_fechaProximaAplicacion != null ? 'Cambiar' : 'Programar'),
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),

                    // Observaciones
                    AppTextField(
                      controller: _observacionesController,
                      label: 'Observaciones',
                      hint: 'Notas adicionales',
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

  String _getTipoNombre(TipoEventoSanitario tipo) {
    switch (tipo) {
      case TipoEventoSanitario.vacunacion:
        return 'Vacunación';
      case TipoEventoSanitario.tratamiento:
        return 'Tratamiento';
      case TipoEventoSanitario.inspeccion:
        return 'Inspección';
      case TipoEventoSanitario.cuarentena:
        return 'Cuarentena';
      case TipoEventoSanitario.desparasitacion:
        return 'Desparasitación';
    }
  }
}
