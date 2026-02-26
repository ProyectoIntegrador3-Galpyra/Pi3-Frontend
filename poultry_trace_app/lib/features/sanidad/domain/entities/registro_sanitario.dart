import 'package:equatable/equatable.dart';

/// Tipos de evento sanitario
enum TipoEventoSanitario {
  vacunacion,
  tratamiento,
  inspeccion,
  cuarentena,
  desparasitacion,
}

/// Entidad de registro sanitario
class RegistroSanitario extends Equatable {
  final String id;
  final String galponId;
  final TipoEventoSanitario tipo;
  final DateTime fecha;
  final String descripcion;
  final String? medicamento;
  final String? dosis;
  final String? veterinario;
  final int? avesAfectadas;
  final DateTime? fechaProximaAplicacion;
  final String? observaciones;
  final DateTime createdAt;

  const RegistroSanitario({
    required this.id,
    required this.galponId,
    required this.tipo,
    required this.fecha,
    required this.descripcion,
    this.medicamento,
    this.dosis,
    this.veterinario,
    this.avesAfectadas,
    this.fechaProximaAplicacion,
    this.observaciones,
    required this.createdAt,
  });

  /// Nombre legible del tipo
  String get tipoNombre {
    switch (tipo) {
      case TipoEventoSanitario.vacunacion:
        return 'Vacunación';
      case TipoEventoSanitario.tratamiento:
        return 'Tratamiento';
      case TipoEventoSanitario.inspeccion:
        return 'Inspección';
      case TipoEventoSanitario.cuarentena:
        return 'Cuarentena';
      case TipoEventoSanitario.desparasitacion:
        return 'Desparasitación';
    }
  }

  /// Verificar si tiene próxima aplicación pendiente
  bool get tienePendiente =>
      fechaProximaAplicacion != null &&
      fechaProximaAplicacion!.isAfter(DateTime.now());

  @override
  List<Object?> get props => [
        id,
        galponId,
        tipo,
        fecha,
        descripcion,
        medicamento,
        dosis,
        veterinario,
        avesAfectadas,
        fechaProximaAplicacion,
        observaciones,
        createdAt,
      ];
}
