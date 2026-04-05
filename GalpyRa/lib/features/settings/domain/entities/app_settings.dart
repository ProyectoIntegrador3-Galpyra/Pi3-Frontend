import 'package:equatable/equatable.dart';

/// Entidad que representa la configuración del usuario
class AppSettings extends Equatable {
  final String? userId;
  final String? nombreGranja;
  final String idioma;
  final bool notificacionesActivas;
  final bool modOscuro;
  final bool sincronizacionAutomatica;
  final int intervaloSincronizacion; // en minutos
  final bool alertasProduccion;
  final bool alertasSanidad;
  final bool alertasInventario;
  final double umbralProduccionBaja; // porcentaje
  final double umbralMortalidadAlta; // porcentaje
  final String formatoFecha;
  final String unidadPeso;

  const AppSettings({
    this.userId,
    this.nombreGranja,
    this.idioma = 'es',
    this.notificacionesActivas = true,
    this.modOscuro = false,
    this.sincronizacionAutomatica = true,
    this.intervaloSincronizacion = 30,
    this.alertasProduccion = true,
    this.alertasSanidad = true,
    this.alertasInventario = true,
    this.umbralProduccionBaja = 70.0,
    this.umbralMortalidadAlta = 5.0,
    this.formatoFecha = 'dd/MM/yyyy',
    this.unidadPeso = 'kg',
  });

  AppSettings copyWith({
    String? userId,
    String? nombreGranja,
    String? idioma,
    bool? notificacionesActivas,
    bool? modOscuro,
    bool? sincronizacionAutomatica,
    int? intervaloSincronizacion,
    bool? alertasProduccion,
    bool? alertasSanidad,
    bool? alertasInventario,
    double? umbralProduccionBaja,
    double? umbralMortalidadAlta,
    String? formatoFecha,
    String? unidadPeso,
  }) {
    return AppSettings(
      userId: userId ?? this.userId,
      nombreGranja: nombreGranja ?? this.nombreGranja,
      idioma: idioma ?? this.idioma,
      notificacionesActivas: notificacionesActivas ?? this.notificacionesActivas,
      modOscuro: modOscuro ?? this.modOscuro,
      sincronizacionAutomatica: sincronizacionAutomatica ?? this.sincronizacionAutomatica,
      intervaloSincronizacion: intervaloSincronizacion ?? this.intervaloSincronizacion,
      alertasProduccion: alertasProduccion ?? this.alertasProduccion,
      alertasSanidad: alertasSanidad ?? this.alertasSanidad,
      alertasInventario: alertasInventario ?? this.alertasInventario,
      umbralProduccionBaja: umbralProduccionBaja ?? this.umbralProduccionBaja,
      umbralMortalidadAlta: umbralMortalidadAlta ?? this.umbralMortalidadAlta,
      formatoFecha: formatoFecha ?? this.formatoFecha,
      unidadPeso: unidadPeso ?? this.unidadPeso,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        nombreGranja,
        idioma,
        notificacionesActivas,
        modOscuro,
        sincronizacionAutomatica,
        intervaloSincronizacion,
        alertasProduccion,
        alertasSanidad,
        alertasInventario,
        umbralProduccionBaja,
        umbralMortalidadAlta,
        formatoFecha,
        unidadPeso,
      ];
}
