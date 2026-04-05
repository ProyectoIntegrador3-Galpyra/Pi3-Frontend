# Release QA Checklist - Backend Alignment

Objetivo: validar en backend vivo la integracion frontend-backend en auth, contrato API, retry/backoff y sync offline.

## Precondiciones
- Backend accesible y con datos de prueba.
- Usuario de prueba valido y token refresh funcional.
- App ejecutando en web y al menos un dispositivo movil.
- Logs habilitados para capturar request/response y codigos HTTP.

## Evidencia minima por caso
- Request: endpoint, payload enviado, headers sensibles anonimizados.
- Response: status, cuerpo envelope y mensaje mostrado en UI.
- Resultado: PASS/FAIL y captura de pantalla (cuando aplique).

## Casos Criticos

### AUTH-01 Login valido
- Pasos:
  1. Iniciar sesion con credenciales validas.
  2. Verificar navegacion a home.
- Esperado:
  - `POST /api/auth/login` responde 200.
  - Envelope con `success=true` y `data.access_token`, `data.refresh_token`, `data.user`.
  - Sesion persistida en almacenamiento seguro.

### AUTH-02 Login invalido
- Pasos:
  1. Iniciar sesion con password incorrecto.
- Esperado:
  - 401 o 422 segun backend.
  - Mensaje backend mostrado de forma legible.
  - No se guarda sesion.

### AUTH-03 Refresh automatico en 401
- Pasos:
  1. Forzar token expirado (o esperar expiracion).
  2. Ejecutar una operacion autenticada.
- Esperado:
  - Primer request devuelve 401.
  - Se ejecuta refresh una sola vez.
  - Request original se reintenta y completa exitosamente.

### AUTH-04 Refresh expirado (410)
- Pasos:
  1. Invalidar refresh token.
  2. Ejecutar request autenticado.
- Esperado:
  - Backend devuelve 410 en refresh.
  - Frontend limpia sesion y redirige a login.
  - No hay bucle de refresh.

### NET-01 Retry para 429
- Pasos:
  1. Forzar rate limit en endpoint autenticado.
- Esperado:
  - Reintentos finitos con backoff.
  - Respeta `Retry-After` si existe.
  - Si agota reintentos, error final claro para usuario.

### NET-02 Retry para 5xx y timeouts
- Pasos:
  1. Simular 500/503 y timeout de red.
- Esperado:
  - Reintentos finitos.
  - Sin loops infinitos.
  - Mensajes de error de conectividad/timeout correctos.

### OFF-01 Cola offline (mutaciones)
- Pasos:
  1. Desconectar red.
  2. Ejecutar mutaciones en modulos criticos (galpones, aves, produccion, alimentacion, sanidad).
  3. Reconectar red y disparar sync.
- Esperado:
  - Mutaciones se encolan localmente.
  - Sync envia batch a `/api/sync`.
  - Registros se marcan sincronizados por entidad e id correcto.

### INV-01 Inventario por foto
- Pasos:
  1. Subir imagen valida en inventario foto.
  2. Esperar job y confirmar conteo.
- Esperado:
  - Flujo `procesar -> job -> confirmar` completo.
  - Estados de job coherentes (`procesando/completado/error`).
  - Conteo final persistido en backend.

### TRAZ-01 Trazabilidad publica
- Pasos:
  1. Generar token de trazabilidad.
  2. Consultar endpoint publico con token.
- Esperado:
  - Token recibido en `data.token`.
  - Consulta publica responde sin auth.
  - Si token vencido: mensaje controlado y status esperado.

## Casos por modulo (smoke)
- GALPONES-01: listar/crear/editar/eliminar.
- AVES-01: consultar inventario, registrar ingreso, registrar mortalidad.
- PROD-01: registrar produccion y consultar historial.
- ALIM-01: registrar alimentacion y consultar historial.
- SAN-01: registrar evento y consultar pendientes.
- REPORT-01: generar reporte, listar historico y exportar.

## Criterios de salida
- 0 fallos en casos Criticos.
- 100% PASS en smoke por modulo.
- Sin errores de contrato (claves fuera de `data` o payload inconsistente).
- Sin loops de retry/refresh observados en logs.

## Registro de ejecucion
| Caso | Estado | Observacion | Evidencia |
|---|---|---|---|
| AUTH-01 | FAIL | Backend no accesible en `http://localhost:3000`; login no llega a servidor. | `DioExceptionType.connectionError` en `POST /api/auth/login` |
| AUTH-02 | BLOCKED | Backend local no disponible en puerto 8000 durante la prueba. | `Invoke-RestMethod`: "No es posible conectar con el servidor remoto" |
| AUTH-03 | BLOCKED | No se pudo obtener refresh token por caida de backend local. | `Test-NetConnection localhost:8000` => `TcpTestSucceeded=False` |
| AUTH-04 | BLOCKED | No ejecutable sin token de setup (login/refresh) por backend caido. | Health/docs no accesibles en `localhost:8000` |
| NET-01 | PENDIENTE |  |  |
| NET-02 | PENDIENTE |  |  |
| OFF-01 | PENDIENTE |  |  |
| INV-01 | PENDIENTE |  |  |
| TRAZ-01 | PENDIENTE |  |  |
