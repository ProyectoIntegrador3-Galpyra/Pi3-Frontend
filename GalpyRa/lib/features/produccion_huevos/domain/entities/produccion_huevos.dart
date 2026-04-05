import 'package:equatable/equatable.dart';

/// Entidad de registro de producción de huevos
class ProduccionHuevos extends Equatable {
  final String id;
  final String galponId;
  final String? loteId;
  final DateTime fecha;
  final int cantidadTotal;
  final int huevosRotos;
  final int huevosSucios;
  final int huevosGrandeAA;
  final int huevosGrandeA;
  final int huevosMediano;
  final int huevosPequeno;
  final double porcentajePostura;
  final String? observaciones;
  // Campos de control offline
  final bool sincronizado;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const ProduccionHuevos({
    required this.id,
    required this.galponId,
    this.loteId,
    required this.fecha,
    required this.cantidadTotal,
    this.huevosRotos = 0,
    this.huevosSucios = 0,
    this.huevosGrandeAA = 0,
    this.huevosGrandeA = 0,
    this.huevosMediano = 0,
    this.huevosPequeno = 0,
    this.porcentajePostura = 0.0,
    this.observaciones,
    this.sincronizado = false,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  /// Huevos aptos para venta
  int get huevosAptos => cantidadTotal - huevosRotos - huevosSucios;

  /// Porcentaje de merma
  double get porcentajeMerma => cantidadTotal > 0
      ? ((huevosRotos + huevosSucios) / cantidadTotal) * 100
      : 0.0;

  bool get isPendingSync => !sincronizado;

  @override
  List<Object?> get props => [
        id,
        galponId,
        loteId,
        fecha,
        cantidadTotal,
        huevosRotos,
        huevosSucios,
        huevosGrandeAA,
        huevosGrandeA,
        huevosMediano,
        huevosPequeno,
        porcentajePostura,
        observaciones,
        sincronizado,
        createdAt,
        updatedAt,
        deletedAt,
      ];

  ProduccionHuevos copyWith({
    String? id,
    String? galponId,
    String? loteId,
    DateTime? fecha,
    int? cantidadTotal,
    int? huevosRotos,
    int? huevosSucios,
    int? huevosGrandeAA,
    int? huevosGrandeA,
    int? huevosMediano,
    int? huevosPequeno,
    double? porcentajePostura,
    String? observaciones,
    bool? sincronizado,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return ProduccionHuevos(
      id: id ?? this.id,
      galponId: galponId ?? this.galponId,
      loteId: loteId ?? this.loteId,
      fecha: fecha ?? this.fecha,
      cantidadTotal: cantidadTotal ?? this.cantidadTotal,
      huevosRotos: huevosRotos ?? this.huevosRotos,
      huevosSucios: huevosSucios ?? this.huevosSucios,
      huevosGrandeAA: huevosGrandeAA ?? this.huevosGrandeAA,
      huevosGrandeA: huevosGrandeA ?? this.huevosGrandeA,
      huevosMediano: huevosMediano ?? this.huevosMediano,
      huevosPequeno: huevosPequeno ?? this.huevosPequeno,
      porcentajePostura: porcentajePostura ?? this.porcentajePostura,
      observaciones: observaciones ?? this.observaciones,
      sincronizado: sincronizado ?? this.sincronizado,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'galpon_id': galponId,
      'lote_id': loteId,
      'fecha': fecha.toIso8601String(),
      'cantidad_total': cantidadTotal,
      'huevos_rotos': huevosRotos,
      'huevos_sucios': huevosSucios,
      'huevos_grande_aa': huevosGrandeAA,
      'huevos_grande_a': huevosGrandeA,
      'huevos_mediano': huevosMediano,
      'huevos_pequeno': huevosPequeno,
      'porcentaje_postura': porcentajePostura,
      'observaciones': observaciones,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  factory ProduccionHuevos.fromJson(Map<String, dynamic> json) {
    return ProduccionHuevos(
      id: json['id'],
      galponId: json['galpon_id'],
      loteId: json['lote_id'],
      fecha: DateTime.parse(json['fecha']),
      cantidadTotal: json['cantidad_total'],
      huevosRotos: json['huevos_rotos'] ?? 0,
      huevosSucios: json['huevos_sucios'] ?? 0,
      huevosGrandeAA: json['huevos_grande_aa'] ?? 0,
      huevosGrandeA: json['huevos_grande_a'] ?? 0,
      huevosMediano: json['huevos_mediano'] ?? 0,
      huevosPequeno: json['huevos_pequeno'] ?? 0,
      porcentajePostura: (json['porcentaje_postura'] ?? 0).toDouble(),
      observaciones: json['observaciones'],
      sincronizado: true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
    );
  }
}
