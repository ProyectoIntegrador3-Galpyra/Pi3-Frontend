# PoultryTrace Frontend (Flutter)

Aplicacion movil para trazabilidad avicola desarrollada en Flutter.

Este README documenta el estado real del frontend en el codigo actual: arquitectura, flujo de autenticacion, sincronizacion offline, rutas publicas/privadas y endpoints que consume.

## 1. Stack Tecnico Real

- Flutter + Dart
- Estado: `flutter_riverpod`
- Navegacion: `go_router`
- HTTP: `dio`
- DI: `get_it`
- Persistencia local: `drift` + SQLite
- Persistencia segura: `flutter_secure_storage`
- Configuracion/cache liviano: `shared_preferences`

Referencia: `pubspec.yaml`.

## 2. Arquitectura Implementada

Estructura principal por feature:

- `lib/features/<feature>/data`
- `lib/features/<feature>/domain`
- `lib/features/<feature>/presentation`

Capas:

- `data`: datasources remotos/locales, modelos y repositorios concretos.
- `domain`: entidades y casos de uso.
- `presentation`: paginas, widgets y controllers (`StateNotifier`).

Bootstrap de la app:

1. `LocalDb.init()` inicializa Drift/SQLite y DAOs.
2. `setupInjector()` registra dependencias en GetIt.
3. App inicia con `ProviderScope` y router configurado.

Referencias:

- `lib/bootstrap.dart`
- `lib/config/di/injector.dart`
- `lib/core/storage/local_db.dart`

## 3. Configuracion de Entorno

Archivo: `lib/config/env.dart`

- `isProduction = false`
- `devBaseUrl = http://localhost:3000`
- `baseUrl = https://api.poultrytrace.com`
- `apiTimeout = 30000` ms

La app usa `Env.currentBaseUrl` para el `HttpClient`.

## 4. Manejo de HTTP y Seguridad

### 4.1 Cliente HTTP

`HttpClient` encapsula `Dio` con:

- `baseUrl` por entorno
- headers JSON por defecto
- interceptores de auth + logging

Referencia: `lib/core/network/http_client.dart`.

### 4.2 Interceptor de autenticacion

Archivo: `lib/core/network/interceptors.dart`

Comportamiento actual:

1. Agrega `Authorization: Bearer <token>` si hay token en secure storage.
2. Si un request llega con `options.extra['skipAuth'] == true`, no agrega token.
3. Ante `401`, intenta refresh automatico usando `POST /api/auth/refresh`.
4. Si refresh falla, limpia sesion local (token, refresh token, user cache key).

### 4.3 Endpoint publico de trazabilidad

El frontend consulta trazabilidad publica con `skipAuth: true`:

- `GET /api/trazabilidad/{token}`

Implementado en:

- `lib/features/trazabilidad/data/datasources/trazabilidad_remote_ds.dart`

## 5. Ruteo y Control de Acceso

Archivos:

- `lib/config/routes/route_paths.dart`
- `lib/config/routes/app_router.dart`

### 5.1 Rutas publicas del frontend

Estas rutas no requieren sesion:

- `/login`
- `/trazabilidad`

### 5.2 Resto de rutas

Todas las demas rutas requieren `authState.isAuthenticated == true`.

Si no hay sesion y se intenta entrar a una ruta privada, se redirige a `/login`.

## 6. Endpoints Consumidos por el Frontend

Fuente de verdad: `lib/config/constants/api_endpoints.dart`.

### 6.1 Auth

- `POST /api/auth/login`
- `POST /api/auth/logout`
- `GET /api/auth/me`
- `POST /api/auth/refresh`

### 6.2 Dashboard y Sync

- `GET /api/dashboard`
- `POST /api/sync`

### 6.3 Galpones

- `GET/POST /api/galpones`
- `GET/PUT/PATCH/DELETE /api/galpones/{id}`

### 6.4 Aves

- `GET /api/aves/inventario`
- `POST /api/aves/mortalidad`
- `POST /api/aves/ingreso`

### 6.5 Produccion

- `GET/POST /api/produccion`
- `GET /api/produccion/rango`
- `GET /api/produccion/galpon/{galponId}`

### 6.6 Sanidad

- `GET/POST /api/sanidad`
- `GET /api/galpones/{galponId}/sanidad`

### 6.7 Alimentacion

- `GET/POST /api/alimentacion`
- `GET /api/galpones/{galponId}/alimentacion`

### 6.8 Inventario por foto

- `POST /api/inventario/procesar`
- `POST /api/inventario/confirmar`
- `GET /api/inventario/jobs`
- `GET /api/inventario/jobs/{jobId}`

### 6.9 Reportes

- `GET /api/reportes`
- `POST /api/reportes/generar`
- `GET /api/reportes/{id}`

### 6.10 Trazabilidad

- `POST /api/trazabilidad/token` (requiere sesion)
- `GET /api/trazabilidad/{token}` (consulta publica)

## 7. Endpoints Abiertos (Sin JWT Forzado)

Desde el punto de vista del frontend actual:

1. `POST /api/auth/login`
   - Flujo de inicio de sesion.
2. `POST /api/auth/refresh`
   - Se usa para renovar token con `refresh_token`.
3. `GET /api/trazabilidad/{token}`
   - Se marca explicitamente con `skipAuth: true`.

Nota: el que esta explicitamente configurado como publico en codigo de interceptor es la consulta de trazabilidad (`skipAuth`).

## 8. Contrato de Respuesta del Backend

Parser central: `lib/core/network/api_response_parser.dart`.

El frontend espera un envelope tipo:

- `success`
- `message`
- `data`
- `status_code` (opcional)
- `error` (opcional)

Comportamiento:

- `extractDataMap()` y `extractDataList()` normalizan respuestas.
- `extractMessage()` prioriza `message`, luego `error.message`.
- `toServerException()` traduce errores de Dio a excepcion de dominio.

## 9. Offline y Sincronizacion

### 9.1 Persistencia local

`LocalDb` usa:

- Drift/SQLite para datos de negocio y cola de sync.
- SharedPreferences para cache y settings ligeros.

### 9.2 Cola de sincronizacion

Tabla: `SyncQueueTable` (`app_database.dart`)

Operaciones soportadas:

- `CREATE`
- `UPDATE`
- `DELETE`
- `UPSERT`

### 9.3 SyncService

Archivo: `lib/core/services/sync_service.dart`

Flujo:

1. Observa conectividad.
2. Reintenta sync automatico cada 5 minutos si hay red.
3. Envia batch `operaciones` a `POST /api/sync`.
4. Procesa `procesadas`, `fallidas`, `detalles`.
5. Elimina procesadas y actualiza intentos/error de fallidas.

Metodo agregado para contrato actual:

- `queueUpsert(...)`

## 10. Modulos Implementados y Estado

Modulos visibles en router:

- Auth
- Home
- Galpones
- Aves
- Produccion
- Sanidad
- Alimentacion
- Inventario por foto
- Reportes
- Trazabilidad
- Settings

DI registrada para todos los modulos principales en `injector.dart`.

## 11. Smoke Test de Contrato (Staging)

Script: `tool/staging_smoke.dart`

Valida:

- login
- profile
- refresh
- dashboard
- sync (incluye `UPSERT`)
- reportes (`url_reporte`)
- trazabilidad publica opcional
- logout

Variables requeridas:

- `SMOKE_BASE_URL`
- `SMOKE_EMAIL`
- `SMOKE_PASSWORD`

Variable opcional:

- `SMOKE_TRACE_TOKEN`

### PowerShell

```powershell
$env:SMOKE_BASE_URL="https://tu-api-staging.com"
$env:SMOKE_EMAIL="usuario@dominio.com"
$env:SMOKE_PASSWORD="tu_password"
$env:SMOKE_TRACE_TOKEN="token_publico"
dart run tool/staging_smoke.dart
```

## 12. Comandos de Desarrollo

```bash
flutter pub get
flutter test
dart run tool/staging_smoke.dart
```

## 13. Matriz Endpoint -> Pantalla -> Datasource

La siguiente matriz conecta lo que ve el usuario (pantallas) con el endpoint que se consume y el datasource remoto que ejecuta la llamada.

| Modulo | Pantalla (UI) | Endpoint | Metodo | Datasource |
|---|---|---|---|---|
| Auth | LoginPage | /api/auth/login | POST | AuthRemoteDataSourceImpl |
| Auth | ProfilePage | /api/auth/me | GET | AuthRemoteDataSourceImpl |
| Auth | Logout (accion de perfil) | /api/auth/logout | POST | AuthRemoteDataSourceImpl |
| Auth (interno interceptor) | N/A (refresh automatico) | /api/auth/refresh | POST | AuthInterceptor (Dio interno) |
| Dashboard | DashboardPage / Home (datos globales) | /api/dashboard | GET | ReportesRemoteDataSourceImpl |
| Galpones | GalponesListPage / GalponDetailPage / GalponFormPage | /api/galpones, /api/galpones/{id} | GET/POST/PUT/PATCH/DELETE | GalponRemoteDataSourceImpl |
| Aves | AvesPage | /api/aves/inventario | GET | AvesRemoteDataSourceImpl |
| Aves | MortalidadFormPage | /api/aves/mortalidad | POST | AvesRemoteDataSourceImpl |
| Aves | IngresoFormPage | /api/aves/ingreso | POST | AvesRemoteDataSourceImpl |
| Produccion | ProduccionPage | /api/produccion/galpon/{galponId} | GET | ProduccionHuevosRemoteDataSourceImpl |
| Produccion | ProduccionFormPage | /api/produccion | POST | ProduccionHuevosRemoteDataSourceImpl |
| Sanidad | SanidadPage | /api/galpones/{galponId}/sanidad | GET | SanidadRemoteDataSourceImpl |
| Sanidad | SanidadFormPage | /api/sanidad | POST | SanidadRemoteDataSourceImpl |
| Alimentacion | AlimentacionPage | /api/galpones/{galponId}/alimentacion | GET | AlimentacionRemoteDataSourceImpl |
| Alimentacion | AlimentacionFormPage | /api/alimentacion | POST | AlimentacionRemoteDataSourceImpl |
| Inventario por foto | CapturaPage / RevisionConteoPage / ResultadoActualizacionPage | /api/inventario/procesar, /api/inventario/confirmar, /api/inventario/jobs, /api/inventario/jobs/{jobId} | POST/GET | InventarioFotoRemoteDataSourceImpl |
| Reportes | ReportesPage | /api/reportes | GET | ReportesRemoteDataSourceImpl |
| Reportes | GenerarReportePage | /api/reportes/generar | POST | ReportesRemoteDataSourceImpl |
| Reportes | Reporte detalle / descarga | /api/reportes/{id} | GET | ReportesRemoteDataSourceImpl |
| Trazabilidad (privado) | TrazabilidadPage (generar token) | /api/trazabilidad/token | POST | TrazabilidadRemoteDataSourceImpl |
| Trazabilidad (publico) | TrazabilidadPage (consulta publica) | /api/trazabilidad/{token} | GET | TrazabilidadRemoteDataSourceImpl (skipAuth=true) |
| Sync offline | N/A (servicio de infraestructura) | /api/sync | POST | SyncService |

Notas de alcance:

- La ruta frontend `/trazabilidad` es publica en el router, pero su accion de generar token llama a endpoint privado (`/api/trazabilidad/token`).
- La consulta publica de trazabilidad (`GET /api/trazabilidad/{token}`) se ejecuta sin JWT mediante `Options(extra: {'skipAuth': true})`.
- El endpoint de refresh no se dispara desde una pantalla; se ejecuta automaticamente en el interceptor cuando un request protegido retorna `401`.

## 14. Resumen Ejecutivo

El frontend quedo implementado con:

- seguridad por token + refresh automatico,
- excepcion publica controlada para trazabilidad,
- ruteo con guardas de autenticacion,
- parser de contrato de API unificado,
- sincronizacion offline con cola y soporte `UPSERT`,
- smoke test de staging para validar alineacion con backend real.
