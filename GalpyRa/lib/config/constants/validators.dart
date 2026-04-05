/// Validators for form fields
class Validators {
  Validators._();

  /// Email regex pattern
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  );

  /// Validate email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El correo es requerido';
    }
    if (!_emailRegex.hasMatch(value)) {
      return 'Ingrese un correo válido';
    }
    return null;
  }

  /// Validate password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  /// Validate required field
  static String? validateRequired(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'Este campo'} es requerido';
    }
    return null;
  }

  /// Validate positive number
  static String? validatePositiveNumber(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Este campo'} es requerido';
    }
    final number = num.tryParse(value);
    if (number == null || number < 0) {
      return 'Ingrese un número válido';
    }
    return null;
  }

  /// Validate integer
  static String? validateInteger(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Este campo'} es requerido';
    }
    final number = int.tryParse(value);
    if (number == null) {
      return 'Ingrese un número entero válido';
    }
    return null;
  }

  /// Validate date not in future
  static String? validateDateNotFuture(DateTime? date) {
    if (date == null) {
      return 'La fecha es requerida';
    }
    if (date.isAfter(DateTime.now())) {
      return 'La fecha no puede ser futura';
    }
    return null;
  }
}
