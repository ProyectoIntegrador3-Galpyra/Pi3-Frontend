import 'package:intl/intl.dart';

/// Date utility functions
class AppDateUtils {
  AppDateUtils._();

  /// Date format patterns
  static const String datePattern = 'dd/MM/yyyy';
  static const String timePattern = 'HH:mm';
  static const String dateTimePattern = 'dd/MM/yyyy HH:mm';
  static const String apiDatePattern = 'yyyy-MM-dd';
  static const String apiDateTimePattern = "yyyy-MM-dd'T'HH:mm:ss";

  /// Format date to display string
  static String formatDate(DateTime date) {
    return DateFormat(datePattern).format(date);
  }

  /// Format time to display string
  static String formatTime(DateTime date) {
    return DateFormat(timePattern).format(date);
  }

  /// Format datetime to display string
  static String formatDateTime(DateTime date) {
    return DateFormat(dateTimePattern).format(date);
  }

  /// Format date for API
  static String formatForApi(DateTime date) {
    return DateFormat(apiDatePattern).format(date);
  }

  /// Format datetime for API
  static String formatDateTimeForApi(DateTime date) {
    return DateFormat(apiDateTimePattern).format(date);
  }

  /// Parse date from API format
  static DateTime parseFromApi(String dateString) {
    return DateTime.parse(dateString);
  }

  /// Parse date from display format
  static DateTime? parseDate(String dateString) {
    try {
      return DateFormat(datePattern).parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Get start of day
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get end of day
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  /// Get start of week (Monday)
  static DateTime startOfWeek(DateTime date) {
    final weekday = date.weekday;
    return startOfDay(date.subtract(Duration(days: weekday - 1)));
  }

  /// Get end of week (Sunday)
  static DateTime endOfWeek(DateTime date) {
    final weekday = date.weekday;
    return endOfDay(date.add(Duration(days: 7 - weekday)));
  }

  /// Get start of month
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Get end of month
  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0, 23, 59, 59);
  }

  /// Get relative time string (ej: "hace 5 min")
  static String getRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return 'hace $years ${years == 1 ? 'año' : 'años'}';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return 'hace $months ${months == 1 ? 'mes' : 'meses'}';
    } else if (difference.inDays > 0) {
      return 'hace ${difference.inDays} ${difference.inDays == 1 ? 'día' : 'días'}';
    } else if (difference.inHours > 0) {
      return 'hace ${difference.inHours} ${difference.inHours == 1 ? 'hora' : 'horas'}';
    } else if (difference.inMinutes > 0) {
      return 'hace ${difference.inMinutes} ${difference.inMinutes == 1 ? 'minuto' : 'minutos'}';
    } else {
      return 'ahora';
    }
  }

  /// Check if two dates are the same day
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Check if date is today
  static bool isToday(DateTime date) {
    return isSameDay(date, DateTime.now());
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDay(date, yesterday);
  }

  /// Get date range for last N days
  static DateRange getLastNDays(int days) {
    final end = DateTime.now();
    final start = end.subtract(Duration(days: days - 1));
    return DateRange(start: startOfDay(start), end: endOfDay(end));
  }

  /// Get date range for current month
  static DateRange getCurrentMonth() {
    final now = DateTime.now();
    return DateRange(start: startOfMonth(now), end: endOfMonth(now));
  }
}

/// Represents a date range
class DateRange {
  final DateTime start;
  final DateTime end;

  const DateRange({required this.start, required this.end});

  int get daysDifference => end.difference(start).inDays;
}
