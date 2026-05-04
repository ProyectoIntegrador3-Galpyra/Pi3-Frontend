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
  final int cantidadAvesActuales;
  final int cantidadLotesActivos;
  final int espacioDisponible;
  // Campos de control offline
  final bool sincronizado;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const Galpon({
    required this.id,
    required this.nombre,
    this.descripcion,
    required this.capacidadMaxima,
    this.cantidadActual = 0,
    this.ubicacion,
    this.activo = true,
    this.cantidadAvesActuales = 0,
    this.cantidadLotesActivos = 0,
    this.espacioDisponible = 0,
    this.sincronizado = false,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  double get porcentajeOcupacion {
    if (capacidadMaxima == 0) return 0;
    return (cantidadActual / capacidadMaxima) * 100;
  }

  bool get estaLleno => cantidadActual >= capacidadMaxima;
  
  bool get isPendingSync => !sincronizado;

  @override
  List<Object?> get props => [
        id,
        nombre,
        descripcion,
        capacidadMaxima,
        cantidadActual,
        ubicacion,
        activo,
        cantidadAvesActuales,
        cantidadLotesActivos,
        espacioDisponible,
        sincronizado,
        createdAt,
        updatedAt,
        deletedAt,
      ];

  Galpon copyWith({
    String? id,
    String? nombre,
    String? descripcion,
    int? capacidadMaxima,
    int? cantidadActual,
    String? ubicacion,
    bool? activo,
    int? cantidadAvesActuales,
    int? cantidadLotesActivos,
    int? espacioDisponible,
    bool? sincronizado,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Galpon(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      capacidadMaxima: capacidadMaxima ?? this.capacidadMaxima,
      cantidadActual: cantidadActual ?? this.cantidadActual,
      ubicacion: ubicacion ?? this.ubicacion,
      activo: activo ?? this.activo,
      cantidadAvesActuales: cantidadAvesActuales ?? this.cantidadAvesActuales,
      cantidadLotesActivos: cantidadLotesActivos ?? this.cantidadLotesActivos,
      espacioDisponible: espacioDisponible ?? this.espacioDisponible,
      sincronizado: sincronizado ?? this.sincronizado,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'capacidad_maxima': capacidadMaxima,
      'cantidad_actual': cantidadActual,
      'ubicacion': ubicacion,
      'activo': activo,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  factory Galpon.fromJson(Map<String, dynamic> json) {
    return Galpon(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      capacidadMaxima: json['capacidad_maxima'],
      cantidadActual: json['cantidad_actual'] ?? 0,
      ubicacion: json['ubicacion'],
      activo: json['activo'] ?? true,
      sincronizado: true, // Si viene del servidor está sincronizado
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
    );
  }
}
