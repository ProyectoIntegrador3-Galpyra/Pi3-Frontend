import 'package:equatable/equatable.dart';

/// Galpon entity
class Galpon extends Equatable {
  final String id;
  final String nombre;
  final String? descripcion;
  final int capacidadMaxima;
  final int cantidadActual;
  final String? ubicacion;
  final bool activo;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Galpon({
    required this.id,
    required this.nombre,
    this.descripcion,
    required this.capacidadMaxima,
    this.cantidadActual = 0,
    this.ubicacion,
    this.activo = true,
    required this.createdAt,
    this.updatedAt,
  });

  double get porcentajeOcupacion {
    if (capacidadMaxima == 0) return 0;
    return (cantidadActual / capacidadMaxima) * 100;
  }

  bool get estaLleno => cantidadActual >= capacidadMaxima;

  @override
  List<Object?> get props => [
        id,
        nombre,
        descripcion,
        capacidadMaxima,
        cantidadActual,
        ubicacion,
        activo,
        createdAt,
        updatedAt,
      ];

  Galpon copyWith({
    String? id,
    String? nombre,
    String? descripcion,
    int? capacidadMaxima,
    int? cantidadActual,
    String? ubicacion,
    bool? activo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Galpon(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      capacidadMaxima: capacidadMaxima ?? this.capacidadMaxima,
      cantidadActual: cantidadActual ?? this.cantidadActual,
      ubicacion: ubicacion ?? this.ubicacion,
      activo: activo ?? this.activo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
