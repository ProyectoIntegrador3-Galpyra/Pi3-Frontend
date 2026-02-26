# 🐔 PoultryTrace App

Aplicación móvil para la **trazabilidad avícola** desarrollada con Flutter. Permite gestionar galpones, aves, producción de huevos, sanidad, alimentación e inventario mediante inteligencia artificial con procesamiento de imágenes.

---

## 📋 Tabla de Contenidos

1. [Arquitectura del Proyecto](#-arquitectura-del-proyecto)
2. [Estructura de Carpetas](#-estructura-de-carpetas)
3. [Tecnologías Utilizadas](#-tecnologías-utilizadas)
4. [Flujo de la Aplicación](#-flujo-de-la-aplicación)
5. [Configuración del Entorno](#-configuración-del-entorno)
6. [Inyección de Dependencias](#-inyección-de-dependencias)
7. [Sistema de Navegación](#-sistema-de-navegación)
8. [Manejo de Errores](#-manejo-de-errores)
9. [Features (Funcionalidades)](#-features-funcionalidades)
10. [Servicios Core](#-servicios-core)
11. [Flujo de Datos](#-flujo-de-datos)
12. [Guía de Instalación](#-guía-de-instalación)

---

## 🏗 Arquitectura del Proyecto

El proyecto sigue una arquitectura **Feature-First + Clean Architecture** con tres capas por cada funcionalidad:

```
┌─────────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────────┐  │
│  │   Pages     │  │  Widgets    │  │  Controllers/Providers  │  │
│  │  (UI/Views) │  │ (Componentes│  │  (StateNotifier +       │  │
│  │             │  │  reutilizab)│  │   Riverpod)             │  │
│  └─────────────┘  └─────────────┘  └─────────────────────────┘  │
└───────────────────────────┬─────────────────────────────────────┘
                            │ Usa
┌───────────────────────────▼─────────────────────────────────────┐
│                      DOMAIN LAYER                                │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────────┐  │
│  │  Entities   │  │  Use Cases  │  │  Repository Interfaces  │  │
│  │  (Modelos   │  │  (Casos de  │  │  (Contratos/Abstraccio- │  │
│  │   puros)    │  │   uso)      │  │   nes)                  │  │
│  └─────────────┘  └─────────────┘  └─────────────────────────┘  │
└───────────────────────────┬─────────────────────────────────────┘
                            │ Implementa
┌───────────────────────────▼─────────────────────────────────────┐
│                       DATA LAYER                                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────────┐  │
│  │   Models    │  │ Datasources │  │ Repository Implementat- │  │
│  │  (DTOs con  │  │ (Remote/    │  │   ions                  │  │
│  │ serializa-  │  │  Local)     │  │  (Conecta datasources)  │  │
│  │   ción)     │  │             │  │                         │  │
│  └─────────────┘  └─────────────┘  └─────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

### ¿Por qué esta arquitectura?

| Beneficio | Descripción |
|-----------|-------------|
| **Testeable** | Cada capa se puede probar de forma independiente |
| **Mantenible** | Cambios en una capa no afectan a las demás |
| **Escalable** | Fácil agregar nuevas funcionalidades |
| **Desacoplado** | La lógica de negocio no depende de frameworks |

---

## 📁 Estructura de Carpetas

```
lib/
├── main.dart                 # Punto de entrada
├── app.dart                  # Widget raíz de la aplicación
├── bootstrap.dart            # Inicialización (Hive, DI, etc.)
│
├── config/                   # Configuración global
│   ├── env.dart             # Variables de entorno (URLs, timeouts)
│   ├── constants/           # Constantes de la app
│   │   ├── api_endpoints.dart    # Endpoints del API
│   │   ├── app_constants.dart    # Constantes generales
│   │   └── validators.dart       # Reglas de validación
│   ├── di/                  # Inyección de dependencias
│   │   └── injector.dart    # Registro de dependencias (GetIt)
│   ├── routes/              # Navegación
│   │   ├── app_router.dart  # Configuración de GoRouter
│   │   └── route_paths.dart # Rutas definidas
│   └── theme/               # Tema visual
│       ├── app_theme.dart   # ThemeData de Material 3
│       ├── colors.dart      # Paleta de colores
│       └── text_styles.dart # Estilos tipográficos
│
├── core/                     # Código compartido/base
│   ├── errors/              # Manejo de errores
│   │   ├── exceptions.dart  # Excepciones personalizadas
│   │   └── failure.dart     # Failures para Either<Failure, T>
│   ├── network/             # Capa de red
│   │   ├── http_client.dart # Cliente HTTP (Dio)
│   │   ├── interceptors.dart    # Interceptores (Auth, Logging)
│   │   └── connectivity_service.dart # Monitor de conectividad
│   ├── services/            # Servicios globales
│   │   ├── camera_service.dart
│   │   ├── image_processing_service.dart
│   │   ├── sync_service.dart
│   │   └── notifications_service.dart
│   ├── storage/             # Almacenamiento local
│   │   ├── secure_storage.dart  # Datos sensibles (tokens)
│   │   ├── local_db.dart        # Hive database
│   │   └── cache_manager.dart   # Caché de datos
│   ├── utils/               # Utilidades
│   │   ├── date_utils.dart
│   │   ├── number_utils.dart
│   │   └── debouncer.dart
│   └── widgets/             # Widgets reutilizables
│       ├── app_scaffold.dart
│       ├── app_text_field.dart
│       ├── app_button.dart
│       ├── loading.dart
│       ├── error_view.dart
│       └── empty_state.dart
│
├── features/                 # Funcionalidades (Feature-First)
│   ├── auth/                # Autenticación
│   ├── galpones/            # Gestión de galpones
│   ├── aves/                # Gestión de aves
│   ├── produccion_huevos/   # Producción de huevos
│   ├── sanidad/             # Eventos sanitarios
│   ├── alimentacion/        # Registros de alimentación
│   ├── inventario_foto/     # Conteo por IA
│   ├── reportes/            # Reportes y dashboard
│   ├── settings/            # Configuración
│   └── home/                # Pantalla principal
│
└── shared/                   # Código compartido entre features
    └── enums/
        └── user_role.dart   # Roles de usuario
```

### Estructura de cada Feature

```
features/[nombre_feature]/
├── data/
│   ├── datasources/
│   │   ├── [feature]_remote_ds.dart    # Llamadas al API
│   │   └── [feature]_local_ds.dart     # Almacenamiento local
│   ├── models/
│   │   └── [feature]_model.dart        # DTOs con toJson/fromJson
│   └── repositories/
│       └── [feature]_repository_impl.dart  # Implementación
│
├── domain/
│   ├── entities/
│   │   └── [feature].dart              # Entidad pura (sin dependencias)
│   ├── repositories/
│   │   └── [feature]_repository.dart   # Interfaz/contrato abstracto
│   └── usecases/
│       ├── crear_[feature].dart
│       ├── editar_[feature].dart
│       └── listar_[feature].dart
│
└── presentation/
    ├── controllers/
    │   └── [feature]_controller.dart   # StateNotifier + Provider
    ├── pages/
    │   ├── [feature]_list_page.dart
    │   ├── [feature]_detail_page.dart
    │   └── [feature]_form_page.dart
    └── widgets/
        └── [feature]_card.dart
```

---

## 🛠 Tecnologías Utilizadas

### Dependencias Principales

| Paquete | Versión | Propósito |
|---------|---------|-----------|
| `flutter_riverpod` | ^2.4.9 | **State Management** - Gestión reactiva del estado |
| `go_router` | ^13.0.1 | **Navegación** - Routing declarativo con deep linking |
| `dio` | ^5.4.0 | **HTTP Client** - Peticiones REST con interceptores |
| `get_it` | ^7.6.4 | **Dependency Injection** - Service Locator pattern |
| `dartz` | ^0.10.1 | **Functional Programming** - Either<L,R> para manejo de errores |
| `equatable` | ^2.0.5 | **Equality** - Comparación de objetos |
| `hive` | ^2.2.3 | **Local Database** - NoSQL rápido para Flutter |
| `flutter_secure_storage` | ^9.0.0 | **Secure Storage** - Tokens y datos sensibles |
| `image_picker` | ^1.0.7 | **Cámara** - Captura de imágenes |
| `connectivity_plus` | ^5.0.2 | **Conectividad** - Detección de red |

### ¿Cómo se conectan?

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   Riverpod   │────▶│   GetIt      │────▶│  Use Cases   │
│  (Providers) │     │    (DI)      │     │              │
└──────────────┘     └──────────────┘     └──────────────┘
                                                  │
                                                  ▼
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│     Dio      │◀────│ Repositories │◀────│ Datasources  │
│ (HTTP Client)│     │              │     │              │
└──────────────┘     └──────────────┘     └──────────────┘
        │                                         │
        ▼                                         ▼
┌──────────────┐                          ┌──────────────┐
│   Backend    │                          │    Hive      │
│   (API)      │                          │   (Local)    │
└──────────────┘                          └──────────────┘
```

---

## 🔄 Flujo de la Aplicación

### 1. Inicialización (`main.dart` → `bootstrap.dart`)

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await bootstrap();  // 1. Inicializa todo
  
  runApp(
    const ProviderScope(  // 2. Envuelve con Riverpod
      child: PoultryTraceApp(),
    ),
  );
}

// bootstrap.dart
Future<void> bootstrap() async {
  await SystemChrome.setPreferredOrientations([...]);  // Orientación
  await Hive.initFlutter();                            // Base de datos local
  await LocalDb.init();                                // Boxes de Hive
  await setupInjector();                               // Inyección de dependencias
}
```

### 2. Flujo de una Petición (Ejemplo: Login)

```
┌─────────────┐
│  LoginPage  │  Usuario presiona "Iniciar sesión"
└──────┬──────┘
       │ ref.read(authControllerProvider.notifier).login(...)
       ▼
┌──────────────────┐
│ AuthController   │  StateNotifier que gestiona estado
│ (Presentation)   │
└────────┬─────────┘
         │ _loginUseCase(email, password)
         ▼
┌──────────────────┐
│  LoginUseCase    │  Caso de uso - lógica de negocio
│    (Domain)      │
└────────┬─────────┘
         │ _repository.login(email, password)
         ▼
┌──────────────────┐
│ AuthRepository   │  Implementación del repositorio
│ Impl (Data)      │
└────────┬─────────┘
         │ _remoteDataSource.login(...)
         ▼
┌──────────────────────┐
│ AuthRemoteDataSource │  Llama al API
│      (Data)          │
└──────────┬───────────┘
           │ _httpClient.post('/auth/login', ...)
           ▼
┌──────────────────┐
│    HttpClient    │  Cliente Dio con interceptores
│     (Core)       │
└────────┬─────────┘
         │ HTTP POST
         ▼
┌──────────────────┐
│   Backend API    │  Servidor externo
└──────────────────┘
```

### 3. Respuesta con Either (Manejo de Errores)

```dart
// El repositorio retorna Either<Failure, User>
Future<Either<Failure, User>> login(...) async {
  try {
    final result = await _remoteDataSource.login(...);
    await _localDataSource.saveUser(result);
    return Right(result.toEntity());  // ✅ Éxito
  } on ServerException catch (e) {
    return Left(ServerFailure(message: e.message));  // ❌ Error
  } on NetworkException catch (e) {
    return Left(NetworkFailure(message: e.message)); // ❌ Sin red
  }
}

// El controller maneja ambos casos
result.fold(
  (failure) => state = state.copyWith(error: failure.message),  // Error
  (user) => state = state.copyWith(user: user, isLoggedIn: true), // Éxito
);
```

---

## ⚙️ Configuración del Entorno

### `config/env.dart`

```dart
class Env {
  // URLs del API
  static const String baseUrl = 'https://api.poultrytrace.com/v1';     // Producción
  static const String devBaseUrl = 'http://localhost:3000/api/v1';     // Desarrollo
  
  // Ambiente actual
  static const bool isProduction = false;
  
  // Configuración
  static const int apiTimeout = 30000;            // 30 segundos
  static const bool offlineModeEnabled = true;    // Soporte offline
  static const bool enableLogs = true;            // Logs de debug
  
  // API de visión para procesamiento de imágenes
  static const String visionApiUrl = 'https://vision.poultrytrace.com/v1';
  
  // URL actual según ambiente
  static String get currentBaseUrl => isProduction ? baseUrl : devBaseUrl;
}
```

### `config/constants/api_endpoints.dart`

```dart
class ApiEndpoints {
  // Auth
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String profile = '/auth/profile';
  
  // Galpones
  static const String galpones = '/galpones';
  static String galpon(String id) => '/galpones/$id';
  
  // Aves
  static const String aves = '/aves';
  static const String mortalidad = '/aves/mortalidad';
  static const String ingreso = '/aves/ingreso';
  
  // ... más endpoints
}
```

---

## 💉 Inyección de Dependencias

### `config/di/injector.dart`

El archivo configura **GetIt** como Service Locator. Las dependencias se registran en orden:

```dart
final GetIt getIt = GetIt.instance;

Future<void> setupInjector() async {
  // 1️⃣ EXTERNOS (libs de terceros)
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  // 2️⃣ CORE - Servicios base
  getIt.registerLazySingleton(() => SecureStorage());
  getIt.registerLazySingleton(() => LocalDb());
  getIt.registerLazySingleton(() => HttpClient(getIt()));  // Depende de SecureStorage
  getIt.registerLazySingleton(() => ConnectivityService());
  getIt.registerLazySingleton(() => CameraService());
  getIt.registerLazySingleton(() => ImageProcessingService());

  // 3️⃣ FEATURES - Por cada feature:
  
  // === AUTH ===
  // Datasources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt()),  // Inyecta HttpClient
  );
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(getIt(), getIt()),  // SecureStorage, LocalDb
  );
  
  // Repository (implementación)
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt(), getIt()),  // Remote + Local datasources
  );
  
  // Use Cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));  // Repository
  getIt.registerLazySingleton(() => LogoutUseCase(getIt()));
  getIt.registerLazySingleton(() => GetProfileUseCase(getIt()));

  // ... similar para cada feature
}
```

### ¿Cómo se usa?

```dart
// En un Provider de Riverpod
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(
    loginUseCase: getIt<LoginUseCase>(),      // Obtiene del container
    logoutUseCase: getIt<LogoutUseCase>(),
    getProfileUseCase: getIt<GetProfileUseCase>(),
  );
});
```

### Diagrama de Dependencias

```
SharedPreferences ──┐
                    │
SecureStorage ──────┼──▶ HttpClient ──▶ AuthRemoteDS ──┐
                    │                                   │
LocalDb ────────────┼──▶ AuthLocalDS ─────────────────┼──▶ AuthRepositoryImpl
                    │                                   │           │
                    └───────────────────────────────────┘           ▼
                                                              LoginUseCase
                                                                    │
                                                                    ▼
                                                             AuthController
```

---

## 🧭 Sistema de Navegación

### `config/routes/route_paths.dart`

Define todas las rutas de la aplicación:

```dart
class RoutePaths {
  // Rutas estáticas
  static const String login = '/login';
  static const String home = '/';
  static const String galpones = '/galpones';
  static const String settings = '/settings';
  
  // Rutas dinámicas (con parámetros)
  static const String galponDetail = '/galpones/:id';
  static const String aves = '/aves/:galponId';
  static const String produccion = '/produccion/:galponId';
  
  // Helper methods para construir rutas
  static String galponDetailPath(String id) => '/galpones/$id';
  static String avesPath(String galponId) => '/aves/$galponId';
  static String produccionPath(String galponId) => '/produccion/$galponId';
}
```

### `config/routes/app_router.dart`

Configura **GoRouter** con todas las rutas:

```dart
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RoutePaths.home,
    debugLogDiagnostics: true,
    routes: [
      // Ruta simple
      GoRoute(
        path: RoutePaths.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      
      // Ruta con parámetro
      GoRoute(
        path: RoutePaths.galponDetail,  // '/galpones/:id'
        name: 'galponDetail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;  // Extrae el ID
          return GalponDetailPage(galponId: id);
        },
      ),
      
      // Ruta con múltiples parámetros
      GoRoute(
        path: RoutePaths.aves,  // '/aves/:galponId'
        builder: (context, state) {
          final galponId = state.pathParameters['galponId']!;
          return AvesPage(galponId: galponId);
        },
      ),
    ],
  );
});
```

### Navegación en la UI

```dart
// Navegar a una ruta (push - agrega al stack)
context.push(RoutePaths.galponDetailPath('123'));

// Reemplazar ruta actual (go - reemplaza stack)
context.go(RoutePaths.home);

// Volver atrás
context.pop();

// Navegar con parámetros de query
context.push('/reportes?tipo=mensual&fecha=2024-01');
```

---

## ❌ Manejo de Errores

### Excepciones (`core/errors/exceptions.dart`)

```dart
// Excepción del servidor
class ServerException implements Exception {
  final String message;
  final int? statusCode;
  ServerException({required this.message, this.statusCode});
}

// Excepción de caché
class CacheException implements Exception {
  final String message;
  CacheException({required this.message});
}

// Excepción de red
class NetworkException implements Exception {
  final String message;
  NetworkException({this.message = 'Sin conexión a internet'});
}
```

### Failures (`core/errors/failure.dart`)

Los Failures son para el patrón **Either<Failure, Success>**:

```dart
abstract class Failure extends Equatable {
  final String message;
  final String? code;
  
  const Failure({required this.message, this.code});
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure({required super.message, this.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Sin conexión a internet',
    super.code = 'NO_NETWORK',
  });
}

class CacheFailure extends Failure { ... }
class AuthFailure extends Failure { ... }
class ValidationFailure extends Failure { ... }
```

### Flujo de Error Completo

```dart
// 1. DataSource lanza excepción
Future<UserModel> login(String email, String password) async {
  try {
    final response = await _client.post('/auth/login', data: {...});
    return UserModel.fromJson(response.data);
  } on DioException catch (e) {
    throw ServerException(
      message: e.response?.data['message'] ?? 'Error del servidor',
      statusCode: e.response?.statusCode,
    );
  }
}

// 2. Repository captura y convierte a Failure
Future<Either<Failure, User>> login(...) async {
  try {
    final result = await _remoteDataSource.login(...);
    return Right(result.toEntity());
  } on ServerException catch (e) {
    return Left(ServerFailure(message: e.message));
  } on NetworkException catch (e) {
    return Left(NetworkFailure());
  }
}

// 3. Controller maneja el Failure
Future<void> login(String email, String password) async {
  state = state.copyWith(isLoading: true);
  
  final result = await _loginUseCase(email: email, password: password);
  
  result.fold(
    (failure) {
      // ❌ Mostrar error al usuario
      state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      );
    },
    (user) {
      // ✅ Login exitoso
      state = state.copyWith(
        isLoading: false,
        user: user,
        isAuthenticated: true,
      );
    },
  );
}
```

---

## 📦 Features (Funcionalidades)

### 1. 🔐 Auth (Autenticación)

**Propósito:** Gestionar el inicio de sesión, cierre de sesión y perfil del usuario.

| Componente | Archivo | Descripción |
|------------|---------|-------------|
| Entity | `user.dart` | Datos del usuario (id, email, name, role) |
| Use Cases | `login.dart`, `logout.dart`, `get_profile.dart` | Acciones del usuario |
| Controller | `auth_controller.dart` | Estado de autenticación |
| Pages | `login_page.dart`, `profile_page.dart` | UI |

**Flujo:**
```
LoginPage → AuthController → LoginUseCase → AuthRepository → API
                                                    ↓
                                            AuthLocalDataSource
                                            (guarda token en SecureStorage)
```

---

### 2. 🏠 Galpones

**Propósito:** CRUD completo de galpones (edificaciones donde se crían las aves).

| Entidad | Campos |
|---------|--------|
| Galpon | id, nombre, capacidad, tipo, ubicacion, estado, createdAt |

**Use Cases:**
- `ListarGalponesUseCase` - Obtener todos los galpones
- `CrearGalponUseCase` - Crear nuevo galpón
- `EditarGalponUseCase` - Actualizar galpón existente
- `VerDetalleGalponUseCase` - Ver detalle de un galpón

**Rutas:**
```
/galpones                → Lista de galpones
/galpones/:id            → Detalle del galpón
/galpones/form           → Crear galpón
/galpones/:id/edit       → Editar galpón
```

---

### 3. 🐔 Aves

**Propósito:** Gestionar lotes de aves, registrar ingresos y mortalidad.

| Entidad | Campos |
|---------|--------|
| LoteAves | id, galponId, raza, cantidad, fechaIngreso, edadSemanas, pesoPromedio |

**Use Cases:**
- `ConsultarInventarioUseCase` - Ver aves por galpón
- `RegistrarIngresoUseCase` - Registrar nuevo lote de aves
- `RegistrarMortalidadUseCase` - Registrar aves muertas

**Rutas:**
```
/aves/:galponId             → Inventario del galpón
/aves/:galponId/ingreso     → Registrar ingreso
/aves/:galponId/mortalidad  → Registrar mortalidad
```

---

### 4. 🥚 Producción de Huevos

**Propósito:** Registrar la producción diaria de huevos por galpón.

| Entidad | Campos |
|---------|--------|
| ProduccionHuevos | id, galponId, fecha, cantidadTotal, huevosSanos, huevosRotos, huevosOtros |

**Use Cases:**
- `RegistrarProduccionUseCase` - Registrar producción del día
- `ObtenerHistorialProduccionUseCase` - Ver histórico

---

### 5. 🏥 Sanidad

**Propósito:** Registrar eventos sanitarios (vacunas, enfermedades, tratamientos).

| Entidad | Campos |
|---------|--------|
| RegistroSanitario | id, galponId, tipo, descripcion, fecha, veterinario, proximaAccion |

**Tipos de eventos:**
- Vacunación
- Tratamiento
- Diagnóstico
- Cuarentena
- Desparasitación

---

### 6. 🍽 Alimentación

**Propósito:** Registrar el suministro de alimento a las aves.

| Entidad | Campos |
|---------|--------|
| RegistroAlimentacion | id, galponId, fecha, tipoAlimento, cantidad, lote, observaciones |

---

### 7. 📸 Inventario por Foto (IA)

**Propósito:** Contar aves automáticamente mediante procesamiento de imágenes.

**Flujo:**
```
1. Usuario captura foto del galpón
2. Imagen se envía al Vision API
3. API procesa y retorna conteo automático
4. Usuario puede ajustar manualmente
5. Se confirma y guarda el inventario
```

| Entidad | Campos |
|---------|--------|
| ConteoFoto | id, galponId, imagePath, conteoAutomatico, conteoManual, confianza, estado |

**Estados del conteo:**
- `pendiente` - Esperando procesar
- `procesando` - Procesando imagen
- `completado` - Conteo finalizado
- `error` - Error en procesamiento

**Rutas:**
```
/inventario-foto/captura/:galponId   → Capturar foto
/inventario-foto/revision/:galponId  → Revisar conteo
/inventario-foto/resultado/:galponId → Resultado final
```

---

### 8. 📊 Reportes

**Propósito:** Generar y exportar reportes de operación.

**Tipos de reportes:**
- Producción (diario, semanal, mensual)
- Mortalidad
- Inventario
- Alimentación
- Sanidad
- Dashboard general

**Use Cases:**
- `GenerarReporteUseCase` - Crear reporte
- `ExportarReporteUseCase` - Exportar a PDF/Excel
- `ObtenerDatosDashboardUseCase` - KPIs para dashboard

---

### 9. ⚙️ Settings

**Propósito:** Configuración de la aplicación.

| Configuración | Opciones |
|---------------|----------|
| Tema | Claro / Oscuro / Sistema |
| Idioma | Español / Inglés |
| Notificaciones | Activar / Desactivar |
| Sincronización | Manual / Automática |
| Modo offline | Activar / Desactivar |

---

## 🔧 Servicios Core

### `HttpClient` (Dio)

Cliente HTTP con interceptores para autenticación y logging:

```dart
class HttpClient {
  late final Dio _dio;
  
  HttpClient(SecureStorage secureStorage) {
    _dio = Dio(BaseOptions(
      baseUrl: Env.currentBaseUrl,
      connectTimeout: Duration(milliseconds: Env.apiTimeout),
      headers: {'Content-Type': 'application/json'},
    ));
    
    _dio.interceptors.addAll([
      AuthInterceptor(secureStorage),  // Agrega token a cada request
      LoggingInterceptor(),            // Log de requests/responses
    ]);
  }
}
```

### `ConnectivityService`

Monitorea el estado de la conexión:

```dart
class ConnectivityService {
  Stream<bool> get connectionStream;  // Stream de estado
  Future<bool> hasConnection();        // Verificar conexión actual
  Future<String> getConnectionType();  // WiFi, Móvil, Ethernet
}
```

### `SecureStorage`

Almacena datos sensibles de forma segura:

```dart
class SecureStorage {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
  Future<void> saveUser(Map<String, dynamic> userData);
  Future<Map<String, dynamic>?> getUser();
}
```

### `CameraService`

Gestiona la cámara para captura de imágenes:

```dart
class CameraService {
  Future<void> initialize();
  Future<String?> captureImage();
  Future<String?> pickFromGallery();
  void dispose();
}
```

### `ImageProcessingService`

Procesa imágenes para conteo de aves:

```dart
class ImageProcessingService {
  Future<int> processImageForCounting(String imagePath);
  Future<double> getConfidenceLevel();
}
```

### `SyncService`

Sincroniza datos locales con el servidor:

```dart
class SyncService {
  Future<void> syncAll();           // Sincronizar todo
  Future<void> syncPendingData();   // Solo datos pendientes
  Stream<SyncStatus> get syncStatus; // Estado de sincronización
}
```

---

## 📊 Flujo de Datos

### Offline-First Strategy

```
┌─────────────────────────────────────────────────────────────┐
│                      USER ACTION                             │
│                    (Crear registro)                          │
└───────────────────────────┬─────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                    REPOSITORY                                │
│  1. Guardar en LocalDB (Hive)                               │
│  2. Marcar como "pendiente de sincronización"               │
└───────────────────────────┬─────────────────────────────────┘
                            │
              ┌─────────────┴─────────────┐
              │    ¿Hay conexión?          │
              └─────────────┬─────────────┘
                   ┌────────┴────────┐
                   ▼                 ▼
            ┌──────────┐      ┌──────────────┐
            │    SÍ    │      │      NO      │
            └────┬─────┘      └──────┬───────┘
                 │                   │
                 ▼                   ▼
         ┌───────────────┐   ┌─────────────────┐
         │ Enviar al API │   │ Guardar en cola │
         │ Actualizar    │   │ de sincroniza-  │
         │ registro local│   │ ción pendiente  │
         └───────────────┘   └─────────────────┘
                                     │
                                     │ (Cuando hay conexión)
                                     ▼
                             ┌───────────────┐
                             │ SyncService   │
                             │ sincroniza    │
                             │ datos         │
                             └───────────────┘
```

---

## 🚀 Guía de Instalación

### Requisitos

- Flutter SDK >= 3.0.0
- Dart >= 3.0.0
- Android Studio / VS Code
- Git

### Pasos

```bash
# 1. Clonar repositorio
git clone https://github.com/tu-repo/poultry_trace_app.git
cd poultry_trace_app

# 2. Instalar dependencias
flutter pub get

# 3. Generar código (si es necesario)
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Ejecutar en modo debug
flutter run

# 5. Build para producción
flutter build apk --release          # Android
flutter build ios --release          # iOS
flutter build web --release          # Web
```

### Configuración de Ambiente

1. Editar `lib/config/env.dart` con las URLs correctas del API
2. Configurar Firebase (si se usa para notificaciones)
3. Configurar API Keys para Vision API (procesamiento de imágenes)

---

## 📝 Convenciones de Código

### Nombrado

| Tipo | Convención | Ejemplo |
|------|------------|---------|
| Archivos | snake_case | `auth_controller.dart` |
| Clases | PascalCase | `AuthController` |
| Variables | camelCase | `isLoading` |
| Constantes | camelCase o SCREAMING_SNAKE | `apiTimeout`, `MAX_RETRIES` |
| Privados | _prefijo | `_repository`, `_init()` |

### Estructura de Imports

```dart
// 1. Dart SDK
import 'dart:async';

// 2. Flutter
import 'package:flutter/material.dart';

// 3. Paquetes externos
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// 4. Imports del proyecto (relativos)
import '../../core/errors/failure.dart';
import '../entities/user.dart';
```

---

## 🧪 Testing

```bash
# Ejecutar todos los tests
flutter test

# Test con coverage
flutter test --coverage

# Tests de integración
flutter drive --target=test_driver/app.dart
```

---

## 📄 Licencia

Este proyecto es privado y de uso interno.

---

## 👥 Equipo

Proyecto desarrollado para gestión de trazabilidad avícola.

---

**Última actualización:** Febrero 2026
