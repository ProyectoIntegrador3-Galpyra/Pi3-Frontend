import 'package:drift/drift.dart';
import '../../features/sanidad/domain/entities/registro_sanitario.dart';
import '../../core/storage/database/app_database.dart';

/// Mapper para convertir entre RegistroSanitario (domain) y EventosSanitariosTableData (Drift)
class SanidadMapper {
  SanidadMapper._();

  /// Convierte String a TipoEventoSanitario
  static TipoEventoSanitario _parseTipo(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'vacunacion':
        return TipoEventoSanitario.vacunacion;
      case 'tratamiento':
        return TipoEventoSanitario.tratamiento;
      case 'inspeccion':
        return TipoEventoSanitario.inspeccion;
      case 'cuarentena':
        return TipoEventoSanitario.cuarentena;
      case 'desparasitacion':
        return TipoEventoSanitario.desparasitacion;
      default:
        return TipoEventoSanitario.tratamiento;
    }
  }

  /// Convierte TipoEventoSanitario a String
  static String _tipoToString(TipoEventoSanitario tipo) {
    return tipo.name;
  }

  /// Convierte de modelo Drift a entidad de dominio
  static RegistroSanitario fromDrift(EventosSanitariosTableData data) {
    return RegistroSanitario(
      id: data.id,
      galponId: data.galponId,
      tipo: _parseTipo(data.tipo),
      fecha: data.fecha,
      descripcion: data.descripcion,
      medicamento: data.medicamento,
      dosis: data.dosis,
      veterinario: data.veterinario,
      avesAfectadas: data.avesAfectadas,
      observaciones: data.observaciones,
      createdAt: data.createdAt,
    );
  }

  /// Convierte de entidad de dominio a companion de Drift para insertar/actualizar
  static EventosSanitariosTableCompanion toDriftCompanion(RegistroSanitario entity, {
    String? loteId,
    bool sincronizado = false,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return EventosSanitariosTableCompanion.insert(
      id: entity.id,
      galponId: entity.galponId,
      loteId: Value(loteId),
      tipo: _tipoToString(entity.tipo),
      fecha: entity.fecha,
      descripcion: entity.descripcion,
      medicamento: Value(entity.medicamento),
      dosis: Value(entity.dosis),
      veterinario: Value(entity.veterinario),
      avesAfectadas: Value(entity.avesAfectadas ?? 0),
      observaciones: Value(entity.observaciones),
      sincronizado: Value(sincronizado),
      createdAt: entity.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      deletedAt: Value(deletedAt),
    );
  }

  /// Convierte de JSON del API a entidad de dominio
  static RegistroSanitario fromJson(Map<String, dynamic> json) {
    return RegistroSanitario(
      id: json['id'] as String,
      galponId: json['galpon_id'] as String? ?? json['galponId'] as String,
      tipo: _parseTipo(json['tipo'] as String? ?? 'tratamiento'),
      fecha: DateTime.parse(json['fecha'] as String),
      descripcion: json['descripcion'] as String? ?? '',
      medicamento: json['medicamento'] as String?,
      dosis: json['dosis'] as String?,
      veterinario: json['veterinario'] as String?,
      avesAfectadas: json['aves_afectadas'] as int? ?? json['avesAfectadas'] as int?,
      fechaProximaAplicacion: json['fecha_proxima_aplicacion'] != null 
          ? DateTime.parse(json['fecha_proxima_aplicacion'] as String)
          : null,
      observaciones: json['observaciones'] as String?,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  /// Convierte de entidad de dominio a JSON para enviar al API
  static Map<String, dynamic> toJson(RegistroSanitario entity) {
    return {
      'id': entity.id,
      'galpon_id': entity.galponId,
      'tipo': _tipoToString(entity.tipo),
      'fecha': entity.fecha.toIso8601String(),
      'descripcion': entity.descripcion,
      'medicamento': entity.medicamento,
      'dosis': entity.dosis,
      'veterinario': entity.veterinario,
      'aves_afectadas': entity.avesAfectadas,
      if (entity.fechaProximaAplicacion != null) 
        'fecha_proxima_aplicacion': entity.fechaProximaAplicacion!.toIso8601String(),
      'observaciones': entity.observaciones,
      'created_at': entity.createdAt.toIso8601String(),
    };
  }

  /// Convierte lista de modelos Drift a lista de entidades
  static List<RegistroSanitario> fromDriftList(List<EventosSanitariosTableData> dataList) {
    return dataList.map(fromDrift).toList();
  }

  /// Convierte lista de JSON a lista de entidades
  static List<RegistroSanitario> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((e) => fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
