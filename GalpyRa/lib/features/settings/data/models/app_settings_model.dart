import '../../domain/entities/app_settings.dart';

/// Modelo de datos para AppSettings
class AppSettingsModel extends AppSettings {
  const AppSettingsModel({
    super.userId,
    super.nombreGranja,
    super.idioma,
    super.notificacionesActivas,
    super.modOscuro,
    super.sincronizacionAutomatica,
    super.intervaloSincronizacion,
    super.alertasProduccion,
    super.alertasSanidad,
    super.alertasInventario,
    super.umbralProduccionBaja,
    super.umbralMortalidadAlta,
    super.formatoFecha,
    super.unidadPeso,
  });

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      userId: json['userId'] as String?,
      nombreGranja: json['nombreGranja'] as String?,
      idioma: json['idioma'] as String? ?? 'es',
      notificacionesActivas: json['notificacionesActivas'] as bool? ?? true,
      modOscuro: json['modOscuro'] as bool? ?? false,
      sincronizacionAutomatica: json['sincronizacionAutomatica'] as bool? ?? true,
      intervaloSincronizacion: json['intervaloSincronizacion'] as int? ?? 30,
      alertasProduccion: json['alertasProduccion'] as bool? ?? true,
      alertasSanidad: json['alertasSanidad'] as bool? ?? true,
      alertasInventario: json['alertasInventario'] as bool? ?? true,
      umbralProduccionBaja: (json['umbralProduccionBaja'] as num?)?.toDouble() ?? 70.0,
      umbralMortalidadAlta: (json['umbralMortalidadAlta'] as num?)?.toDouble() ?? 5.0,
      formatoFecha: json['formatoFecha'] as String? ?? 'dd/MM/yyyy',
      unidadPeso: json['unidadPeso'] as String? ?? 'kg',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nombreGranja': nombreGranja,
      'idioma': idioma,
      'notificacionesActivas': notificacionesActivas,
      'modOscuro': modOscuro,
      'sincronizacionAutomatica': sincronizacionAutomatica,
      'intervaloSincronizacion': intervaloSincronizacion,
      'alertasProduccion': alertasProduccion,
      'alertasSanidad': alertasSanidad,
      'alertasInventario': alertasInventario,
      'umbralProduccionBaja': umbralProduccionBaja,
      'umbralMortalidadAlta': umbralMortalidadAlta,
      'formatoFecha': formatoFecha,
      'unidadPeso': unidadPeso,
    };
  }

  factory AppSettingsModel.fromEntity(AppSettings entity) {
    return AppSettingsModel(
      userId: entity.userId,
      nombreGranja: entity.nombreGranja,
      idioma: entity.idioma,
      notificacionesActivas: entity.notificacionesActivas,
      modOscuro: entity.modOscuro,
      sincronizacionAutomatica: entity.sincronizacionAutomatica,
      intervaloSincronizacion: entity.intervaloSincronizacion,
      alertasProduccion: entity.alertasProduccion,
      alertasSanidad: entity.alertasSanidad,
      alertasInventario: entity.alertasInventario,
      umbralProduccionBaja: entity.umbralProduccionBaja,
      umbralMortalidadAlta: entity.umbralMortalidadAlta,
      formatoFecha: entity.formatoFecha,
      unidadPeso: entity.unidadPeso,
    );
  }
}
