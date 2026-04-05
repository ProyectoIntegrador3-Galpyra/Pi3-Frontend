import 'package:equatable/equatable.dart';

/// Lote de aves entity
class LoteAves extends Equatable {
  final String id;
  final String galponId;
  final String? raza;
  final int cantidad;
  final DateTime fechaIngreso;
  final int edadSemanas;
  final double? pesoPromedio;
  final String? observaciones;
  final DateTime createdAt;

  const LoteAves({
    required this.id,
    required this.galponId,
    this.raza,
    required this.cantidad,
    required this.fechaIngreso,
    required this.edadSemanas,
    this.pesoPromedio,
    this.observaciones,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        galponId,
        raza,
        cantidad,
        fechaIngreso,
        edadSemanas,
        pesoPromedio,
        observaciones,
        createdAt,
      ];

  LoteAves copyWith({
    String? id,
    String? galponId,
    String? raza,
    int? cantidad,
    DateTime? fechaIngreso,
    int? edadSemanas,
    double? pesoPromedio,
    String? observaciones,
    DateTime? createdAt,
  }) {
    return LoteAves(
      id: id ?? this.id,
      galponId: galponId ?? this.galponId,
      raza: raza ?? this.raza,
      cantidad: cantidad ?? this.cantidad,
      fechaIngreso: fechaIngreso ?? this.fechaIngreso,
      edadSemanas: edadSemanas ?? this.edadSemanas,
      pesoPromedio: pesoPromedio ?? this.pesoPromedio,
      observaciones: observaciones ?? this.observaciones,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
