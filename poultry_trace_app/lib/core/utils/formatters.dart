import 'package:intl/intl.dart';

/// Formatting utilities
class Formatters {
  Formatters._();

  /// Format number with thousands separator
  static String formatNumber(num value) {
    final formatter = NumberFormat('#,###', 'es_ES');
    return formatter.format(value);
  }

  /// Format decimal number
  static String formatDecimal(num value, {int decimalPlaces = 2}) {
    final formatter = NumberFormat.decimalPattern('es_ES');
    formatter.minimumFractionDigits = decimalPlaces;
    formatter.maximumFractionDigits = decimalPlaces;
    return formatter.format(value);
  }

  /// Format percentage
  static String formatPercentage(num value, {int decimalPlaces = 1}) {
    return '${formatDecimal(value, decimalPlaces: decimalPlaces)}%';
  }

  /// Format currency (COP)
  static String formatCurrency(num value) {
    final formatter = NumberFormat.currency(
      locale: 'es_CO',
      symbol: '\$',
      decimalDigits: 0,
    );
    return formatter.format(value);
  }

  /// Format weight in kg
  static String formatWeight(num valueInKg) {
    return '${formatDecimal(valueInKg)} kg';
  }

  /// Format weight in grams
  static String formatWeightGrams(num valueInGrams) {
    if (valueInGrams >= 1000) {
      return formatWeight(valueInGrams / 1000);
    }
    return '${formatNumber(valueInGrams)} g';
  }

  /// Format eggs count
  static String formatEggsCount(int count) {
    if (count >= 30) {
      final cartones = count ~/ 30;
      final remainder = count % 30;
      if (remainder == 0) {
        return '$cartones ${cartones == 1 ? 'cartón' : 'cartones'}';
      }
      return '$cartones ${cartones == 1 ? 'cartón' : 'cartones'} + $remainder';
    }
    return '$count ${count == 1 ? 'huevo' : 'huevos'}';
  }

  /// Format phone number
  static String formatPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'\D'), '');
    if (cleaned.length == 10) {
      return '${cleaned.substring(0, 3)} ${cleaned.substring(3, 6)} ${cleaned.substring(6)}';
    }
    return phone;
  }

  /// Truncate text with ellipsis
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return '${text[0].toUpperCase()}${text.substring(1).toLowerCase()}';
  }

  /// Capitalize all words
  static String capitalizeWords(String text) {
    return text.split(' ').map(capitalize).join(' ');
  }

  /// Format file size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }

  /// Format duration
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }
}
