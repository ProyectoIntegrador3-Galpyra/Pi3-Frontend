import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/http_client.dart';
import '../../core/storage/secure_storage.dart';
import '../../core/services/camera_service.dart';
import '../../core/services/image_processing_service.dart';
import '../../core/services/sync_service.dart';
import '../../core/services/notifications_service.dart';
import '../../core/network/connectivity_service.dart';

// Auth
import '../../features/auth/data/datasources/auth_remote_ds.dart';
import '../../features/auth/data/datasources/auth_local_ds.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login.dart';
import '../../features/auth/domain/usecases/logout.dart';
import '../../features/auth/domain/usecases/get_profile.dart';

// Galpones
import '../../features/galpones/data/datasources/galpon_remote_ds.dart';
import '../../features/galpones/data/datasources/galpon_local_ds.dart';
import '../../features/galpones/data/repositories/galpon_repository_impl.dart';
import '../../features/galpones/domain/repositories/galpon_repository.dart';
import '../../features/galpones/domain/usecases/listar_galpones.dart';
import '../../features/galpones/domain/usecases/crear_galpon.dart';
import '../../features/galpones/domain/usecases/editar_galpon.dart';
import '../../features/galpones/domain/usecases/ver_detalle_galpon.dart';

// Aves
import '../../features/aves/data/datasources/aves_remote_ds.dart';
import '../../features/aves/data/datasources/aves_local_ds.dart';
import '../../features/aves/data/repositories/aves_repository_impl.dart';
import '../../features/aves/domain/repositories/aves_repository.dart';
import '../../features/aves/domain/usecases/consultar_inventario.dart';
import '../../features/aves/domain/usecases/registrar_mortalidad.dart';
import '../../features/aves/domain/usecases/registrar_ingreso.dart';

// Producción
import '../../features/produccion_huevos/data/datasources/produccion_huevos_remote_ds.dart';
import '../../features/produccion_huevos/data/repositories/produccion_huevos_repository_impl.dart';
import '../../features/produccion_huevos/domain/repositories/produccion_huevos_repository.dart';
import '../../features/produccion_huevos/domain/usecases/registrar_produccion.dart';
import '../../features/produccion_huevos/domain/usecases/obtener_historial_produccion.dart';

// Sanidad
import '../../features/sanidad/data/datasources/sanidad_remote_ds.dart';
import '../../features/sanidad/data/repositories/sanidad_repository_impl.dart';
import '../../features/sanidad/domain/repositories/sanidad_repository.dart';
import '../../features/sanidad/domain/usecases/registrar_evento_sanitario.dart';
import '../../features/sanidad/domain/usecases/obtener_historial_sanitario.dart';

// Alimentación
import '../../features/alimentacion/data/datasources/alimentacion_remote_ds.dart';
import '../../features/alimentacion/data/repositories/alimentacion_repository_impl.dart';
import '../../features/alimentacion/domain/repositories/alimentacion_repository.dart';
import '../../features/alimentacion/domain/usecases/registrar_alimentacion.dart';
import '../../features/alimentacion/domain/usecases/obtener_historial_alimentacion.dart';

// Inventario por foto
import '../../features/inventario_foto/data/datasources/inventario_foto_remote_ds.dart';
import '../../features/inventario_foto/data/repositories/inventario_foto_repository_impl.dart';
import '../../features/inventario_foto/domain/repositories/inventario_foto_repository.dart';
import '../../features/inventario_foto/domain/usecases/procesar_imagen_conteo.dart';
import '../../features/inventario_foto/domain/usecases/confirmar_inventario.dart';

// Reportes
import '../../features/reportes/data/datasources/reportes_remote_ds.dart';
import '../../features/reportes/data/repositories/reportes_repository_impl.dart';
import '../../features/reportes/domain/repositories/reportes_repository.dart';
import '../../features/reportes/domain/usecases/generar_reporte.dart';
import '../../features/reportes/domain/usecases/exportar_reporte.dart';
import '../../features/reportes/domain/usecases/obtener_datos_dashboard.dart';

// Trazabilidad
import '../../features/trazabilidad/data/datasources/trazabilidad_remote_ds.dart';

// Settings
import '../../features/settings/data/datasources/settings_local_ds.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupInjector() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  // Core - Services
  getIt.registerLazySingleton(() => SecureStorage());
  getIt.registerLazySingleton(() => HttpClient(getIt()));
  getIt.registerLazySingleton(() => ConnectivityService());
  getIt.registerLazySingleton(() => CameraService());
  getIt.registerLazySingleton(() => ImageProcessingService());
  getIt.registerLazySingleton(() => SyncService(getIt(), getIt()));
  getIt.registerLazySingleton(() => NotificationsService());

  // ========== AUTH ==========
  // Datasources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(getIt()),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt(), getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt()));
  getIt.registerLazySingleton(() => GetProfileUseCase(getIt()));

  // ========== GALPONES ==========
  // Datasources
  getIt.registerLazySingleton<GalponRemoteDataSource>(
    () => GalponRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<GalponLocalDataSource>(
    () => GalponLocalDataSourceImpl(),
  );

  // Repository
  getIt.registerLazySingleton<GalponRepository>(
    () => GalponRepositoryImpl(getIt(), getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => ListarGalponesUseCase(getIt()));
  getIt.registerLazySingleton(() => CrearGalponUseCase(getIt()));
  getIt.registerLazySingleton(() => EditarGalponUseCase(getIt()));
  getIt.registerLazySingleton(() => VerDetalleGalponUseCase(getIt()));

  // ========== AVES ==========
  // Datasources
  getIt.registerLazySingleton<AvesRemoteDataSource>(
    () => AvesRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<AvesLocalDataSource>(
    () => AvesLocalDataSourceImpl(),
  );

  // Repository
  getIt.registerLazySingleton<AvesRepository>(
    () => AvesRepositoryImpl(getIt(), getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => ConsultarInventarioUseCase(getIt()));
  getIt.registerLazySingleton(() => RegistrarMortalidadUseCase(getIt()));
  getIt.registerLazySingleton(() => RegistrarIngresoUseCase(getIt()));

  // ========== PRODUCCIÓN ==========
  // Datasources
  getIt.registerLazySingleton<ProduccionHuevosRemoteDataSource>(
    () => ProduccionHuevosRemoteDataSourceImpl(getIt()),
  );

  // Repository
  getIt.registerLazySingleton<ProduccionHuevosRepository>(
    () => ProduccionHuevosRepositoryImpl(getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => RegistrarProduccionUseCase(getIt()));
  getIt.registerLazySingleton(() => ObtenerHistorialProduccionUseCase(getIt()));

  // ========== SANIDAD ==========
  // Datasources
  getIt.registerLazySingleton<SanidadRemoteDataSource>(
    () => SanidadRemoteDataSourceImpl(getIt()),
  );

  // Repository
  getIt.registerLazySingleton<SanidadRepository>(
    () => SanidadRepositoryImpl(getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => RegistrarEventoSanitarioUseCase(getIt()));
  getIt.registerLazySingleton(() => ObtenerHistorialSanitarioUseCase(getIt()));

  // ========== ALIMENTACIÓN ==========
  // Datasources
  getIt.registerLazySingleton<AlimentacionRemoteDataSource>(
    () => AlimentacionRemoteDataSourceImpl(getIt()),
  );

  // Repository
  getIt.registerLazySingleton<AlimentacionRepository>(
    () => AlimentacionRepositoryImpl(getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => RegistrarAlimentacionUseCase(getIt()));
  getIt.registerLazySingleton(
      () => ObtenerHistorialAlimentacionUseCase(getIt()));

  // ========== INVENTARIO POR FOTO ==========
  // Datasources
  getIt.registerLazySingleton<InventarioFotoRemoteDataSource>(
    () => InventarioFotoRemoteDataSourceImpl(getIt()),
  );

  // Repository
  getIt.registerLazySingleton<InventarioFotoRepository>(
    () => InventarioFotoRepositoryImpl(getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => ProcesarImagenConteoUseCase(getIt()));
  getIt.registerLazySingleton(() => ConfirmarInventarioUseCase(getIt()));

  // ========== REPORTES ==========
  // Datasources
  getIt.registerLazySingleton<ReportesRemoteDataSource>(
    () => ReportesRemoteDataSourceImpl(getIt()),
  );

  // Repository
  getIt.registerLazySingleton<ReportesRepository>(
    () => ReportesRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GenerarReporte(getIt()));
  getIt.registerLazySingleton(() => ExportarReporte(getIt()));
  getIt.registerLazySingleton(() => ObtenerDatosDashboard(getIt()));

  // ========== TRAZABILIDAD ==========
  getIt.registerLazySingleton<TrazabilidadRemoteDataSource>(
    () => TrazabilidadRemoteDataSourceImpl(getIt()),
  );

  // ========== SETTINGS ==========
  // Datasources
  getIt.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(),
  );

  // Repository
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(
      localDataSource: getIt(),
    ),
  );
}
