import '../../../../core/network/http_client.dart';
import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/galpon_model.dart';

/// Galpon remote data source interface
abstract class GalponRemoteDataSource {
  Future<List<GalponModel>> listarGalpones();
  Future<GalponModel> obtenerGalpon(String id);
  Future<GalponModel> crearGalpon(GalponModel galpon);
  Future<GalponModel> editarGalpon(GalponModel galpon);
  Future<void> eliminarGalpon(String id);
}

/// Galpon remote data source implementation
class GalponRemoteDataSourceImpl implements GalponRemoteDataSource {
  final HttpClient _httpClient;

  GalponRemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<GalponModel>> listarGalpones() async {
    try {
      // TODO: Implement actual API call
      // final response = await _httpClient.get(ApiEndpoints.galpones);
      // return (response.data as List)
      //     .map((json) => GalponModel.fromJson(json))
      //     .toList();

      // Mock response for development
      await Future.delayed(const Duration(milliseconds: 500));
      return [
        GalponModel(
          id: '1',
          nombre: 'Galpón A',
          descripcion: 'Galpón principal de ponedoras',
          capacidadMaxima: 5000,
          cantidadActual: 4500,
          ubicacion: 'Sector Norte',
          activo: true,
          createdAt: DateTime.now().subtract(const Duration(days: 365)),
        ),
        GalponModel(
          id: '2',
          nombre: 'Galpón B',
          descripcion: 'Galpón secundario',
          capacidadMaxima: 3000,
          cantidadActual: 2800,
          ubicacion: 'Sector Sur',
          activo: true,
          createdAt: DateTime.now().subtract(const Duration(days: 180)),
        ),
        GalponModel(
          id: '3',
          nombre: 'Galpón C',
          descripcion: 'Galpón de cría',
          capacidadMaxima: 2000,
          cantidadActual: 1500,
          ubicacion: 'Sector Este',
          activo: true,
          createdAt: DateTime.now().subtract(const Duration(days: 90)),
        ),
      ];
    } catch (e) {
      throw ServerException(
        message: 'Error al obtener galpones',
        originalException: e,
      );
    }
  }

  @override
  Future<GalponModel> obtenerGalpon(String id) async {
    try {
      // TODO: Implement actual API call
      // final response = await _httpClient.get(ApiEndpoints.galponById(id));
      // return GalponModel.fromJson(response.data);

      await Future.delayed(const Duration(milliseconds: 300));
      return GalponModel(
        id: id,
        nombre: 'Galpón $id',
        descripcion: 'Descripción del galpón',
        capacidadMaxima: 5000,
        cantidadActual: 4500,
        ubicacion: 'Sector Norte',
        activo: true,
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
      );
    } catch (e) {
      throw ServerException(
        message: 'Error al obtener galpón',
        originalException: e,
      );
    }
  }

  @override
  Future<GalponModel> crearGalpon(GalponModel galpon) async {
    try {
      // TODO: Implement actual API call
      // final response = await _httpClient.post(
      //   ApiEndpoints.galpones,
      //   data: galpon.toJson(),
      // );
      // return GalponModel.fromJson(response.data);

      await Future.delayed(const Duration(milliseconds: 500));
      return galpon;
    } catch (e) {
      throw ServerException(
        message: 'Error al crear galpón',
        originalException: e,
      );
    }
  }

  @override
  Future<GalponModel> editarGalpon(GalponModel galpon) async {
    try {
      // TODO: Implement actual API call
      // final response = await _httpClient.put(
      //   ApiEndpoints.galponById(galpon.id),
      //   data: galpon.toJson(),
      // );
      // return GalponModel.fromJson(response.data);

      await Future.delayed(const Duration(milliseconds: 500));
      return galpon;
    } catch (e) {
      throw ServerException(
        message: 'Error al editar galpón',
        originalException: e,
      );
    }
  }

  @override
  Future<void> eliminarGalpon(String id) async {
    try {
      // TODO: Implement actual API call
      // await _httpClient.delete(ApiEndpoints.galponById(id));

      await Future.delayed(const Duration(milliseconds: 300));
    } catch (e) {
      throw ServerException(
        message: 'Error al eliminar galpón',
        originalException: e,
      );
    }
  }
}
