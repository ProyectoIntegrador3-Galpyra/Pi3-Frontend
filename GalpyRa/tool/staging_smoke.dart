import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

Future<void> main() async {
  final baseUrl = Platform.environment['SMOKE_BASE_URL'];
  final email = Platform.environment['SMOKE_EMAIL'];
  final password = Platform.environment['SMOKE_PASSWORD'];
  final traceToken = Platform.environment['SMOKE_TRACE_TOKEN'];

  if (baseUrl == null || email == null || password == null) {
    stderr.writeln(
      'Faltan variables: SMOKE_BASE_URL, SMOKE_EMAIL, SMOKE_PASSWORD.\n'
      'Opcional: SMOKE_TRACE_TOKEN para validar trazabilidad publica.',
    );
    exit(2);
  }

  final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 20),
    sendTimeout: const Duration(seconds: 20),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
    validateStatus: (_) => true,
  ));

  final failures = <String>[];

  Future<Map<String, dynamic>> parseEnvelope(
      Response response, String step) async {
    if (response.data is! Map<String, dynamic>) {
      failures.add('$step -> respuesta no es objeto JSON');
      return <String, dynamic>{};
    }

    final body = response.data as Map<String, dynamic>;
    for (final key in ['success', 'message', 'data']) {
      if (!body.containsKey(key)) {
        failures.add('$step -> falta key de contrato: $key');
      }
    }

    return body;
  }

  stdout.writeln('1) Login');
  final loginRes = await dio.post('/api/auth/login', data: {
    'email': email,
    'password': password,
  });
  final loginBody = await parseEnvelope(loginRes, 'login');
  if (loginRes.statusCode != 200) {
    failures
        .add('login -> status esperado 200, recibido ${loginRes.statusCode}');
  }

  final loginData = (loginBody['data'] is Map<String, dynamic>)
      ? loginBody['data'] as Map<String, dynamic>
      : <String, dynamic>{};

  final accessToken = (loginData['access_token'] ?? '').toString();
  final refreshToken = (loginData['refresh_token'] ?? '').toString();
  final tokenType = (loginData['token_type'] ?? '').toString();
  if (accessToken.isEmpty ||
      refreshToken.isEmpty ||
      tokenType.isEmpty ||
      loginData['user'] == null) {
    failures.add(
        'login -> contrato incompleto: access_token/refresh_token/token_type/user');
  }

  dio.options.headers['Authorization'] = 'Bearer $accessToken';

  stdout.writeln('2) Perfil /api/auth/me');
  final meRes = await dio.get('/api/auth/me');
  await parseEnvelope(meRes, 'me');
  if (meRes.statusCode != 200) {
    failures.add('me -> status esperado 200, recibido ${meRes.statusCode}');
  }

  stdout.writeln('3) Refresh /api/auth/refresh');
  final refreshRes = await dio.post('/api/auth/refresh', data: {
    'refresh_token': refreshToken,
  });
  final refreshBody = await parseEnvelope(refreshRes, 'refresh');
  if (refreshRes.statusCode != 200) {
    failures.add(
        'refresh -> status esperado 200, recibido ${refreshRes.statusCode}');
  }
  final refreshData = (refreshBody['data'] is Map<String, dynamic>)
      ? refreshBody['data'] as Map<String, dynamic>
      : <String, dynamic>{};
  if ((refreshData['access_token'] ?? '').toString().isEmpty) {
    failures.add('refresh -> falta access_token');
  }

  stdout.writeln('4) Dashboard /api/dashboard');
  final dashboardRes = await dio.get('/api/dashboard');
  final dashboardBody = await parseEnvelope(dashboardRes, 'dashboard');
  if (dashboardRes.statusCode != 200) {
    failures.add(
        'dashboard -> status esperado 200, recibido ${dashboardRes.statusCode}');
  }
  final dashboardData = (dashboardBody['data'] is Map<String, dynamic>)
      ? dashboardBody['data'] as Map<String, dynamic>
      : <String, dynamic>{};
  for (final key in [
    'total_aves_activas',
    'produccion_ultimos_7_dias',
    'tasa_mortalidad_porcentaje',
    'alertas',
  ]) {
    if (!dashboardData.containsKey(key)) {
      failures.add('dashboard -> falta campo $key');
    }
  }

  stdout.writeln('5) Sync /api/sync');
  final syncRes = await dio.post('/api/sync', data: {
    'operaciones': [
      {
        'id': 'smoke-upsert-1',
        'operacion': 'UPSERT',
        'entidad': 'galpones',
        'payload': {'id': 'smoke-galpon-1', 'nombre': 'Smoke Galpon'},
        'created_at': DateTime.now().toIso8601String(),
      }
    ],
  });
  final syncBody = await parseEnvelope(syncRes, 'sync');
  if (syncRes.statusCode != 200) {
    failures.add('sync -> status esperado 200, recibido ${syncRes.statusCode}');
  }
  final syncData = (syncBody['data'] is Map<String, dynamic>)
      ? syncBody['data'] as Map<String, dynamic>
      : <String, dynamic>{};
  for (final key in ['procesadas', 'fallidas', 'detalles']) {
    if (!syncData.containsKey(key)) {
      failures.add('sync -> falta campo $key');
    }
  }

  stdout.writeln('6) Reporte /api/reportes/generar');
  final now = DateTime.now();
  final reportRes = await dio.post('/api/reportes/generar', data: {
    'tipo': 'produccion',
    'fecha_inicio': now.subtract(const Duration(days: 7)).toIso8601String(),
    'fecha_fin': now.toIso8601String(),
    'formato': 'pdf',
  });
  final reportBody = await parseEnvelope(reportRes, 'reportes_generar');
  if (reportRes.statusCode != 200 && reportRes.statusCode != 201) {
    failures.add(
        'reportes_generar -> status esperado 200/201, recibido ${reportRes.statusCode}');
  }
  final reportData = (reportBody['data'] is Map<String, dynamic>)
      ? reportBody['data'] as Map<String, dynamic>
      : <String, dynamic>{};
  if ((reportData['url_reporte'] ?? '').toString().isEmpty) {
    failures.add('reportes_generar -> falta url_reporte');
  }

  if (traceToken != null && traceToken.isNotEmpty) {
    stdout.writeln('7) Trazabilidad publica /api/trazabilidad/{token}');
    final trazabilidadPublicRes = await dio.get(
      '/api/trazabilidad/$traceToken',
      options: Options(headers: {'Authorization': null}),
    );
    await parseEnvelope(trazabilidadPublicRes, 'trazabilidad_publica');
    if (trazabilidadPublicRes.statusCode != 200) {
      failures.add(
        'trazabilidad_publica -> status esperado 200, recibido ${trazabilidadPublicRes.statusCode}',
      );
    }
  } else {
    stdout.writeln(
        '7) Trazabilidad publica omitida (SMOKE_TRACE_TOKEN no definido)');
  }

  stdout.writeln('8) Logout /api/auth/logout');
  final logoutRes = await dio.post('/api/auth/logout', data: {
    'refresh_token': refreshToken,
  });
  await parseEnvelope(logoutRes, 'logout');
  if (logoutRes.statusCode != 200) {
    failures
        .add('logout -> status esperado 200, recibido ${logoutRes.statusCode}');
  }

  if (failures.isEmpty) {
    stdout.writeln('SMOKE OK: contratos principales validados');
    exit(0);
  }

  stdout.writeln('SMOKE FAIL: ${failures.length} hallazgos');
  stdout.writeln(const JsonEncoder.withIndent('  ').convert(failures));
  exit(1);
}
