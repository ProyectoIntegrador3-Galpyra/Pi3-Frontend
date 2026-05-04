import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../controllers/trazabilidad_controller.dart';

class TrazabilidadPage extends ConsumerStatefulWidget {
  const TrazabilidadPage({super.key});

  @override
  ConsumerState<TrazabilidadPage> createState() => _TrazabilidadPageState();
}

class _TrazabilidadPageState extends ConsumerState<TrazabilidadPage> {
  final _tokenController = TextEditingController();
  String? _selectedLoteId;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(trazabilidadControllerProvider.notifier).cargarLotes(),
    );
  }

  @override
  void dispose() {
    _tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(trazabilidadControllerProvider);
    final lotes = ref.watch(lotesProvider);

    return AppScaffold(
      title: 'Trazabilidad',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Generar Token (requiere sesión)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedLoteId,
              decoration: const InputDecoration(
                labelText: 'Lote',
                border: OutlineInputBorder(),
              ),
              items: lotes
                  .map(
                    (lote) => DropdownMenuItem<String>(
                      value: lote.id,
                      child: Text(lote.label),
                    ),
                  )
                  .toList(),
              onChanged: state.isLoading
                  ? null
                  : (value) => setState(() => _selectedLoteId = value),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: state.isLoading || _selectedLoteId == null
                    ? null
                    : () => ref
                        .read(trazabilidadControllerProvider.notifier)
                        .generarToken(_selectedLoteId!),
                child: const Text('Generar token'),
              ),
            ),
            if (state.generatedToken != null) ...[
              const SizedBox(height: 16),
              _QrTokenCard(token: state.generatedToken!),
            ],
            const SizedBox(height: 24),
            const Text(
              'Consulta Pública (sin JWT)',
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

class _QrTokenCard extends StatelessWidget {
  final String token;

  const _QrTokenCard({required this.token});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'QR generado — escanea para consultar',
              style: TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Center(
              child: QrImageView(
                data: token,
                version: QrVersions.auto,
                size: 200,
                backgroundColor: Colors.white,
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: AppColors.primaryDark,
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: AppColors.primaryDark,
                ),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: token));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Token copiado')),
                );
              },
              child: Text(
                token,
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
            ),
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
    final loteRaw = data['lote'];
    final lote = loteRaw is Map ? loteRaw : <String, dynamic>{};
    final eventosRaw =
        data['eventos_sanitarios'] ?? data['eventos'] ?? <dynamic>[];
    final eventos = eventosRaw is List ? eventosRaw : <dynamic>[];
    final nombreLote =
        (lote['nombre_lote'] ?? lote['codigo_lote'] ?? 'No disponible')
            .toString();
    final nombreGalpon =
        (lote['nombre_galpon'] ?? lote['galpon_nombre'] ?? 'No disponible')
            .toString();
    final fechaIngreso = (lote['fecha_ingreso'] ?? 'No disponible').toString();
    final raza = (lote['raza'] ?? 'No disponible').toString();
    final cantidadActual =
        (lote['cantidad_actual'] ?? lote['cantidad_inicial'] ?? 'No disponible')
            .toString();

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
            Text('Lote: $nombreLote'),
            Text('Galpón: $nombreGalpon'),
            Text('Fecha ingreso: $fechaIngreso'),
            Text('Raza: $raza'),
            Text('Cantidad actual de aves: $cantidadActual'),
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
