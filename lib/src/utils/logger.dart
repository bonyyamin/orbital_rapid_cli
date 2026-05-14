import 'package:mason_logger/mason_logger.dart';

/// A utility class for logging messages to the terminal using [mason_logger].
class AppLogger {
  final Logger _logger = Logger();

  /// Logs an informational message.
  void info(String message) => _logger.info(message);

  /// Logs a success message in green.
  void success(String message) => _logger.success(message);

  /// Logs an error message in red.
  void err(String message) => _logger.err(message);

  /// Logs a warning message in yellow.
  void warn(String message) => _logger.warn(message);

  /// Starts a progress spinner with the given [message].
  Progress progress(String message) => _logger.progress(message);

  /// Prints the CLI's ASCII art banner.
  void printBanner() { /* ASCII art banner */ }
}