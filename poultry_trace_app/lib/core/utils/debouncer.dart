import 'dart:async';

/// Debouncer utility to limit function calls
class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({this.delay = const Duration(milliseconds: 500)});

  /// Run function after delay, canceling any previous pending call
  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  /// Cancel any pending call
  void cancel() {
    _timer?.cancel();
  }

  /// Check if debouncer is active
  bool get isActive => _timer?.isActive ?? false;

  /// Dispose debouncer
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}

/// Throttler utility to limit function calls to once per interval
class Throttler {
  final Duration interval;
  DateTime? _lastExecution;

  Throttler({this.interval = const Duration(milliseconds: 500)});

  /// Run function if enough time has passed since last execution
  void run(void Function() action) {
    final now = DateTime.now();
    if (_lastExecution == null ||
        now.difference(_lastExecution!) >= interval) {
      _lastExecution = now;
      action();
    }
  }

  /// Reset throttler
  void reset() {
    _lastExecution = null;
  }
}
