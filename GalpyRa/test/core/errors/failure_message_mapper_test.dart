import 'package:flutter_test/flutter_test.dart';
import 'package:poultry_trace_app/core/errors/failure.dart';
import 'package:poultry_trace_app/core/errors/failure_message_mapper.dart';

void main() {
  group('mapFailureMessage', () {
    test('maps 401 to session expiration message', () {
      final failure = ServerFailure(message: 'ignored', statusCode: 401);

      final result = mapFailureMessage(failure);

      expect(result, 'Tu sesion expiro o no estas autorizado. Inicia sesion nuevamente.');
    });

    test('maps 410 to unavailable resource message', () {
      final failure = ServerFailure(message: 'ignored', statusCode: 410);

      final result = mapFailureMessage(failure);

      expect(result, 'El recurso solicitado ya no esta disponible o el token expiro.');
    });

    test('keeps server message for 422 when provided', () {
      final failure = ServerFailure(message: 'campo cantidad es requerido', statusCode: 422);

      final result = mapFailureMessage(failure);

      expect(result, 'campo cantidad es requerido');
    });

    test('maps 422 to generic validation message when message is empty', () {
      final failure = ServerFailure(message: '', statusCode: 422);

      final result = mapFailureMessage(failure);

      expect(result, 'Hay datos invalidos. Revisa los campos e intentalo otra vez.');
    });

    test('maps 429 to throttle message', () {
      final failure = ServerFailure(message: 'ignored', statusCode: 429);

      final result = mapFailureMessage(failure);

      expect(result, 'Demasiadas solicitudes. Espera unos segundos e intentalo nuevamente.');
    });

    test('maps 500 to temporary server issue message', () {
      final failure = ServerFailure(message: 'ignored', statusCode: 500);

      final result = mapFailureMessage(failure);

      expect(result, 'El servidor tuvo un problema temporal. Intenta nuevamente en unos minutos.');
    });

    test('uses server message for unknown status code', () {
      final failure = ServerFailure(message: 'mensaje original', statusCode: 418);

      final result = mapFailureMessage(failure);

      expect(result, 'mensaje original');
    });

    test('maps network failure to connectivity message', () {
      const failure = NetworkFailure(message: 'ignored');

      final result = mapFailureMessage(failure);

      expect(result, 'Sin conexion a internet. Verifica tu red e intenta nuevamente.');
    });

    test('returns validation failure message as is', () {
      const failure = ValidationFailure(message: 'campo email invalido');

      final result = mapFailureMessage(failure);

      expect(result, 'campo email invalido');
    });

    test('returns fallback failure message for other failure types', () {
      const failure = UnexpectedFailure(message: 'error inesperado');

      final result = mapFailureMessage(failure);

      expect(result, 'error inesperado');
    });
  });
}
