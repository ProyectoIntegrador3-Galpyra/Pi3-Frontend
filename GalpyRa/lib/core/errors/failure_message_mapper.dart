import 'failure.dart';

String mapFailureMessage(Failure failure) {
  if (failure is ServerFailure) {
    switch (failure.statusCode) {
      case 401:
        return 'Tu sesion expiro o no estas autorizado. Inicia sesion nuevamente.';
      case 410:
        return 'El recurso solicitado ya no esta disponible o el token expiro.';
      case 422:
        return failure.message.isNotEmpty
            ? failure.message
            : 'Hay datos invalidos. Revisa los campos e intentalo otra vez.';
      case 429:
        return 'Demasiadas solicitudes. Espera unos segundos e intentalo nuevamente.';
      case 500:
        return 'El servidor tuvo un problema temporal. Intenta nuevamente en unos minutos.';
      default:
        return failure.message;
    }
  }

  if (failure is NetworkFailure) {
    return 'Sin conexion a internet. Verifica tu red e intenta nuevamente.';
  }

  if (failure is ValidationFailure) {
    return failure.message;
  }

  return failure.message;
}
