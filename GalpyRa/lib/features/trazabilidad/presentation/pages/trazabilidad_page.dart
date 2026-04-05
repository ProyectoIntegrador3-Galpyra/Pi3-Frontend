import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../controllers/trazabilidad_controller.dart';

class TrazabilidadPage extends ConsumerStatefulWidget {
  const TrazabilidadPage({super.key});

  @override
  ConsumerState<TrazabilidadPage> createState() => _TrazabilidadPageState();
}

class _TrazabilidadPageState extends ConsumerState<TrazabilidadPage> {
  final _loteIdController = TextEditingController();
  final _tokenController = TextEditingController();

  @override
  void dispose() {
    _loteIdController.dispose();
    _tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(trazabilidadControllerProvider);

    return AppScaffold(
      title: 'Trazabilidad',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Generar Token (requiere sesion)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _loteIdController,
              decoration: const InputDecoration(
                labelText: 'Lote ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state.isLoading
                    ? null
                    : () => ref
                        .read(trazabilidadControllerProvider.notifier)
                        .generarToken(_loteIdController.text.trim()),
                child: const Text('Generar token'),
              ),
            ),
            if (state.generatedToken != null) ...[
              const SizedBox(height: 8),
              SelectableText(
                'Token generado: ${state.generatedToken}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
            const SizedBox(height: 24),
            const Text(
              'Consulta Publica (sin JWT)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _tokenController,
              decoration: const InputDecoration(
                labelText: 'Token de trazabilidad',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state.isLoading
                    ? null
                    : () => ref
                        .read(trazabilidadControllerProvider.notifier)
                        .consultarPublica(_tokenController.text.trim()),
                child: const Text('Consultar token'),
              ),
            ),
            if (state.error != null) ...[
              const SizedBox(height: 12),
              Text(
                state.error!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            if (state.consultaData != null) ...[
              const SizedBox(height: 16),
              _ResultadoTrazabilidad(data: state.consultaData!),
            ],
          ],
        ),
      ),
    );
  }
}

class _ResultadoTrazabilidad extends StatelessWidget {
  final Map<String, dynamic> data;

  const _ResultadoTrazabilidad({required this.data});

  @override
  Widget build(BuildContext context) {
    final lote = data['lote'];
    final eventosRaw =
        data['eventos_sanitarios'] ?? data['eventos'] ?? <dynamic>[];
    final eventos = eventosRaw is List ? eventosRaw : <dynamic>[];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resultado',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (lote != null)
              Text('Lote: ${lote.toString()}')
            else
              const Text('Lote: no disponible'),
            const SizedBox(height: 8),
            const Text(
              'Eventos sanitarios',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            if (eventos.isEmpty)
              const Text('Sin eventos en la respuesta')
            else
              ...eventos.map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('- ${e.toString()}'),
                  )),
          ],
        ),
      ),
    );
  }
}
