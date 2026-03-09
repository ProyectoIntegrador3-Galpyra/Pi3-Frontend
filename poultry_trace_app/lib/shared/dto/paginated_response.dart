/// DTO para respuestas paginadas del API
class PaginatedResponse<T> {
  final List<T> items;
  final int total;
  final int page;
  final int pageSize;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;

  PaginatedResponse({
    required this.items,
    required this.total,
    required this.page,
    required this.pageSize,
  })  : totalPages = (total / pageSize).ceil(),
        hasNextPage = page < (total / pageSize).ceil(),
        hasPreviousPage = page > 1;

  /// Factory constructor desde JSON del API
  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final itemsList = json['items'] as List? ?? json['data'] as List? ?? [];
    
    return PaginatedResponse(
      items: itemsList.map((e) => fromJsonT(e as Map<String, dynamic>)).toList(),
      total: json['total'] as int? ?? json['totalItems'] as int? ?? itemsList.length,
      page: json['page'] as int? ?? json['currentPage'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? json['perPage'] as int? ?? 20,
    );
  }

  /// Convierte a JSON
  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'items': items.map(toJsonT).toList(),
      'total': total,
      'page': page,
      'pageSize': pageSize,
      'totalPages': totalPages,
      'hasNextPage': hasNextPage,
      'hasPreviousPage': hasPreviousPage,
    };
  }

  /// Crea una copia con items mapeados
  PaginatedResponse<R> map<R>(R Function(T) transform) {
    return PaginatedResponse<R>(
      items: items.map(transform).toList(),
      total: total,
      page: page,
      pageSize: pageSize,
    );
  }

  /// Response vacía
  static PaginatedResponse<T> empty<T>() {
    return PaginatedResponse<T>(
      items: [],
      total: 0,
      page: 1,
      pageSize: 20,
    );
  }

  @override
  String toString() {
    return 'PaginatedResponse(items: ${items.length}, total: $total, page: $page/$totalPages)';
  }
}

/// Request para paginación
class PaginationParams {
  final int page;
  final int pageSize;
  final String? sortBy;
  final bool sortDescending;
  final Map<String, dynamic>? filters;

  const PaginationParams({
    this.page = 1,
    this.pageSize = 20,
    this.sortBy,
    this.sortDescending = false,
    this.filters,
  });

  Map<String, dynamic> toQueryParameters() {
    return {
      'page': page,
      'pageSize': pageSize,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortBy != null) 'sortOrder': sortDescending ? 'desc' : 'asc',
      if (filters != null) ...filters!,
    };
  }

  PaginationParams copyWith({
    int? page,
    int? pageSize,
    String? sortBy,
    bool? sortDescending,
    Map<String, dynamic>? filters,
  }) {
    return PaginationParams(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      sortBy: sortBy ?? this.sortBy,
      sortDescending: sortDescending ?? this.sortDescending,
      filters: filters ?? this.filters,
    );
  }

  /// Primera página
  static const PaginationParams first = PaginationParams(page: 1);

  /// Siguiente página
  PaginationParams get nextPage => copyWith(page: page + 1);

  /// Página anterior
  PaginationParams get previousPage => copyWith(page: page > 1 ? page - 1 : 1);
}
