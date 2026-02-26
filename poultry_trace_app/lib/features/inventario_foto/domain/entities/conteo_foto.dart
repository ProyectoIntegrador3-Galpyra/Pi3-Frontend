import 'package:equatable/equatable.dart';

/// Estado del conteo por foto
enum EstadoConteo {
  pendiente,
  procesando,
  completado,
  error,
}

/// Entidad de conteo por foto
class ConteoFoto extends Equatable {
  final String id;
  final String galponId;
  final String imagePath;
  final DateTime fechaCaptura;
  final EstadoConteo estado;
  final int? conteoAutomatico;
  final int? conteoManual;
  final int? conteoFinal;
  final double? confianza;
  final String? mensajeError;
  final Map<String, dynamic>? metadatos;
  final DateTime createdAt;

  const ConteoFoto({
    required this.id,
    required this.galponId,
    required this.imagePath,
    required this.fechaCaptura,
    this.estado = EstadoConteo.pendiente,
    this.conteoAutomatico,
    this.conteoManual,
    this.conteoFinal,
    this.confianza,
    this.mensajeError,
    this.metadatos,
    required this.createdAt,
  });

  /// Diferencia entre conteo manual y automático
  int? get diferencia {
    if (conteoAutomatico != null && conteoManual != null) {
      return conteoManual! - conteoAutomatico!;
    }
    return null;
  }

  /// Porcentaje de diferencia
  double? get porcentajeDiferencia {
    if (diferencia != null && conteoAutomatico != null && conteoAutomatico! > 0) {
      return (diferencia!.abs() / conteoAutomatico!) * 100;
    }
    return null;
  }

  /// Verificar si el conteo fue revisado
  bool get fueRevisado => conteoManual != null;

  /// Verificar si hay alta discrepancia
  bool get altaDiscrepancia =>
      porcentajeDiferencia != null && porcentajeDiferencia! > 10;

  ConteoFoto copyWith({
    String? id,
    String? galponId,
    String? imagePath,
    DateTime? fechaCaptura,
    EstadoConteo? estado,
    int? conteoAutomatico,
    int? conteoManual,
    int? conteoFinal,
    double? confianza,
    String? mensajeError,
    Map<String, dynamic>? metadatos,
    DateTime? createdAt,
  }) {
    return ConteoFoto(
      id: id ?? this.id,
      galponId: galponId ?? this.galponId,
      imagePath: imagePath ?? this.imagePath,
      fechaCaptura: fechaCaptura ?? this.fechaCaptura,
      estado: estado ?? this.estado,
      conteoAutomatico: conteoAutomatico ?? this.conteoAutomatico,
      conteoManual: conteoManual ?? this.conteoManual,
      conteoFinal: conteoFinal ?? this.conteoFinal,
      confianza: confianza ?? this.confianza,
      mensajeError: mensajeError ?? this.mensajeError,
      metadatos: metadatos ?? this.metadatos,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        galponId,
        imagePath,
        fechaCaptura,
        estado,
        conteoAutomatico,
        conteoManual,
        conteoFinal,
        confianza,
        mensajeError,
        metadatos,
        createdAt,
      ];
}
