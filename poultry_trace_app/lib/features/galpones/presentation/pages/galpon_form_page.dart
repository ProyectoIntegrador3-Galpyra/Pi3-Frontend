import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/constants/validators.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/loading.dart';
import '../../domain/entities/galpon.dart';
import '../controllers/galpones_controller.dart';

/// Galpon form page (create/edit)
class GalponFormPage extends ConsumerStatefulWidget {
  final String? galponId;

  const GalponFormPage({
    super.key,
    this.galponId,
  });

  @override
  ConsumerState<GalponFormPage> createState() => _GalponFormPageState();
}

class _GalponFormPageState extends ConsumerState<GalponFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _capacidadController = TextEditingController();
  final _ubicacionController = TextEditingController();
  bool _activo = true;

  bool get isEditing => widget.galponId != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      Future.microtask(() {
        ref.read(galponesControllerProvider.notifier).obtenerGalpon(widget.galponId!);
      });
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _capacidadController.dispose();
    _ubicacionController.dispose();
    super.dispose();
  }

  void _populateForm(Galpon galpon) {
    _nombreController.text = galpon.nombre;
    _descripcionController.text = galpon.descripcion ?? '';
    _capacidadController.text = galpon.capacidadMaxima.toString();
    _ubicacionController.text = galpon.ubicacion ?? '';
    _activo = galpon.activo;
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final now = DateTime.now();
      final galpon = Galpon(
        id: widget.galponId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        nombre: _nombreController.text.trim(),
        descripcion: _descripcionController.text.trim().isNotEmpty
            ? _descripcionController.text.trim()
            : null,
        capacidadMaxima: int.parse(_capacidadController.text),
        ubicacion: _ubicacionController.text.trim().isNotEmpty
            ? _ubicacionController.text.trim()
            : null,
        activo: _activo,
        sincronizado: false,
        createdAt: now,
        updatedAt: now,
      );

      final controller = ref.read(galponesControllerProvider.notifier);
      final success = isEditing
          ? await controller.editarGalpon(galpon)
          : await controller.crearGalpon(galpon);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isEditing
                ? 'Galpón actualizado correctamente'
                : 'Galpón creado correctamente'),
          ),
        );
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(galponesControllerProvider);

    // Populate form when editing and data is loaded
    if (isEditing && state.selectedGalpon != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_nombreController.text.isEmpty) {
          _populateForm(state.selectedGalpon!);
          setState(() {});
        }
      });
    }

    return AppScaffold(
      title: isEditing ? 'Editar Galpón' : 'Nuevo Galpón',
      body: isEditing && state.isLoading && state.selectedGalpon == null
          ? const Loading(message: 'Cargando datos...')
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTextField(
                      controller: _nombreController,
                      label: 'Nombre *',
                      hint: 'Ej: Galpón A',
                      prefixIcon: Icons.home_work_outlined,
                      validator: (v) => Validators.validateRequired(v, 'El nombre'),
                      textCapitalization: TextCapitalization.words,
                    ),
                    const SizedBox(height: 16),

                    AppTextField(
                      controller: _descripcionController,
                      label: 'Descripción',
                      hint: 'Descripción opcional del galpón',
                      prefixIcon: Icons.description_outlined,
                      maxLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    const SizedBox(height: 16),

                    AppNumberField(
                      controller: _capacidadController,
                      label: 'Capacidad máxima *',
                      hint: 'Ej: 5000',
                      prefixIcon: Icons.groups_outlined,
                      suffix: 'aves',
                      validator: (v) => Validators.validatePositiveNumber(v, 'La capacidad'),
                    ),
                    const SizedBox(height: 16),

                    AppTextField(
                      controller: _ubicacionController,
                      label: 'Ubicación',
                      hint: 'Ej: Sector Norte',
                      prefixIcon: Icons.location_on_outlined,
                      textCapitalization: TextCapitalization.words,
                    ),
                    const SizedBox(height: 16),

                    SwitchListTile(
                      title: const Text('Galpón activo'),
                      subtitle: const Text('Habilita o deshabilita el galpón'),
                      value: _activo,
                      onChanged: (value) => setState(() => _activo = value),
                    ),
                    const SizedBox(height: 24),

                    if (state.error != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          state.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    AppButton(
                      text: isEditing ? 'Guardar cambios' : 'Crear galpón',
                      onPressed: _handleSubmit,
                      isLoading: state.isLoading,
                      isExpanded: true,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
