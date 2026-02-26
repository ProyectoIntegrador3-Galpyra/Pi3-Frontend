import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/loading.dart';
import '../controllers/settings_controller.dart';

/// Página de configuraciones
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    // Escuchar mensajes
    ref.listen<SettingsState>(settingsControllerProvider, (prev, next) {
      if (next.successMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.successMessage!)),
        );
        controller.clearMessages();
      }
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
        controller.clearMessages();
      }
    });

    if (state.isLoading) {
      return const AppScaffold(
        title: 'Configuración',
        body: Loading(),
      );
    }

    return AppScaffold(
      title: 'Configuración',
      body: ListView(
        children: [
          // Sección: General
          _buildSectionHeader('General'),
          ListTile(
            leading: const Icon(Icons.business),
            title: const Text('Nombre de la Granja'),
            subtitle: Text(state.settings.nombreGranja ?? 'Sin configurar'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _editarNombreGranja(context, ref),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Idioma'),
            subtitle: Text(_getIdiomaLabel(state.settings.idioma)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _seleccionarIdioma(context, ref),
          ),

          // Sección: Apariencia
          _buildSectionHeader('Apariencia'),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Modo Oscuro'),
            subtitle: const Text('Usar tema oscuro en la aplicación'),
            value: state.settings.modOscuro,
            onChanged: (value) {
              controller.cambiarValor(campo: 'modOscuro', valor: value);
            },
          ),

          // Sección: Notificaciones
          _buildSectionHeader('Notificaciones'),
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text('Notificaciones'),
            subtitle: const Text('Habilitar notificaciones push'),
            value: state.settings.notificacionesActivas,
            onChanged: (value) {
              controller.cambiarValor(campo: 'notificacionesActivas', valor: value);
            },
          ),
          if (state.settings.notificacionesActivas) ...[
            SwitchListTile(
              secondary: const Icon(Icons.egg),
              title: const Text('Alertas de Producción'),
              value: state.settings.alertasProduccion,
              onChanged: (value) {
                controller.cambiarValor(campo: 'alertasProduccion', valor: value);
              },
            ),
            SwitchListTile(
              secondary: const Icon(Icons.local_hospital),
              title: const Text('Alertas Sanitarias'),
              value: state.settings.alertasSanidad,
              onChanged: (value) {
                controller.cambiarValor(campo: 'alertasSanidad', valor: value);
              },
            ),
            SwitchListTile(
              secondary: const Icon(Icons.inventory),
              title: const Text('Alertas de Inventario'),
              value: state.settings.alertasInventario,
              onChanged: (value) {
                controller.cambiarValor(campo: 'alertasInventario', valor: value);
              },
            ),
          ],

          // Sección: Sincronización
          _buildSectionHeader('Sincronización'),
          SwitchListTile(
            secondary: const Icon(Icons.sync),
            title: const Text('Sincronización Automática'),
            subtitle: const Text('Sincronizar datos automáticamente'),
            value: state.settings.sincronizacionAutomatica,
            onChanged: (value) {
              controller.cambiarValor(campo: 'sincronizacionAutomatica', valor: value);
            },
          ),
          if (state.settings.sincronizacionAutomatica)
            ListTile(
              leading: const Icon(Icons.timer),
              title: const Text('Intervalo de Sincronización'),
              subtitle: Text('${state.settings.intervaloSincronizacion} minutos'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _seleccionarIntervalo(context, ref),
            ),

          // Sección: Umbrales
          _buildSectionHeader('Umbrales de Alerta'),
          ListTile(
            leading: const Icon(Icons.trending_down),
            title: const Text('Producción Baja'),
            subtitle: Text('Alertar cuando sea menor a ${state.settings.umbralProduccionBaja.toStringAsFixed(0)}%'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _editarUmbral(
              context,
              ref,
              'umbralProduccionBaja',
              'Umbral de Producción Baja',
              state.settings.umbralProduccionBaja,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.warning),
            title: const Text('Mortalidad Alta'),
            subtitle: Text('Alertar cuando sea mayor a ${state.settings.umbralMortalidadAlta.toStringAsFixed(1)}%'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _editarUmbral(
              context,
              ref,
              'umbralMortalidadAlta',
              'Umbral de Mortalidad Alta',
              state.settings.umbralMortalidadAlta,
            ),
          ),

          // Sección: Cuenta
          _buildSectionHeader('Cuenta'),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to profile
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
            onTap: () => _confirmarCerrarSesion(context, ref),
          ),

          // Sección: Datos
          _buildSectionHeader('Datos'),
          ListTile(
            leading: const Icon(Icons.backup),
            title: const Text('Exportar Configuración'),
            onTap: () => _exportarConfig(context, ref),
          ),
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text('Restaurar Valores por Defecto'),
            onTap: () => _confirmarRestaurar(context, ref),
          ),

          // Sección: Acerca de
          _buildSectionHeader('Acerca de'),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('Versión'),
            subtitle: Text('1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Términos y Condiciones'),
            onTap: () {
              // TODO: Show terms
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Política de Privacidad'),
            onTap: () {
              // TODO: Show privacy policy
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  String _getIdiomaLabel(String codigo) {
    switch (codigo) {
      case 'es':
        return 'Español';
      case 'en':
        return 'English';
      default:
        return codigo;
    }
  }

  Future<void> _editarNombreGranja(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController(
      text: ref.read(settingsControllerProvider).settings.nombreGranja,
    );

    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nombre de la Granja'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Ingrese el nombre',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      ref.read(settingsControllerProvider.notifier).cambiarValor(
            campo: 'nombreGranja',
            valor: result,
          );
    }
  }

  Future<void> _seleccionarIdioma(BuildContext context, WidgetRef ref) async {
    final actual = ref.read(settingsControllerProvider).settings.idioma;

    final result = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Seleccionar Idioma'),
        children: [
          RadioListTile<String>(
            title: const Text('Español'),
            value: 'es',
            groupValue: actual,
            onChanged: (value) => Navigator.pop(context, value),
          ),
          RadioListTile<String>(
            title: const Text('English'),
            value: 'en',
            groupValue: actual,
            onChanged: (value) => Navigator.pop(context, value),
          ),
        ],
      ),
    );

    if (result != null) {
      ref.read(settingsControllerProvider.notifier).cambiarValor(
            campo: 'idioma',
            valor: result,
          );
    }
  }

  Future<void> _seleccionarIntervalo(BuildContext context, WidgetRef ref) async {
    final actual = ref.read(settingsControllerProvider).settings.intervaloSincronizacion;
    final opciones = [5, 15, 30, 60, 120];

    final result = await showDialog<int>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Intervalo de Sincronización'),
        children: opciones.map((minutos) {
          return RadioListTile<int>(
            title: Text('$minutos minutos'),
            value: minutos,
            groupValue: actual,
            onChanged: (value) => Navigator.pop(context, value),
          );
        }).toList(),
      ),
    );

    if (result != null) {
      ref.read(settingsControllerProvider.notifier).cambiarValor(
            campo: 'intervaloSincronizacion',
            valor: result,
          );
    }
  }

  Future<void> _editarUmbral(
    BuildContext context,
    WidgetRef ref,
    String campo,
    String titulo,
    double valorActual,
  ) async {
    final controller = TextEditingController(
      text: valorActual.toStringAsFixed(1),
    );

    final result = await showDialog<double>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titulo),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            suffixText: '%',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final value = double.tryParse(controller.text);
              Navigator.pop(context, value);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );

    if (result != null) {
      ref.read(settingsControllerProvider.notifier).cambiarValor(
            campo: campo,
            valor: result,
          );
    }
  }

  Future<void> _confirmarCerrarSesion(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Está seguro que desea cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      // TODO: Implement logout
      context.go(RoutePaths.login);
    }
  }

  Future<void> _exportarConfig(BuildContext context, WidgetRef ref) async {
    final data = await ref.read(settingsControllerProvider.notifier).exportarSettings();
    if (data != null && context.mounted) {
      // TODO: Share or copy data
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Configuración exportada')),
      );
    }
  }

  Future<void> _confirmarRestaurar(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restaurar Configuración'),
        content: const Text(
          '¿Está seguro que desea restaurar los valores por defecto? Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Restaurar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(settingsControllerProvider.notifier).resetearSettings();
    }
  }
}
