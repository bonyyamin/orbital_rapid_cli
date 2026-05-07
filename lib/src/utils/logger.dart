class AppLogger {
  final Logger _logger = Logger();

  void info(String message) => _logger.info(message);
  void success(String message) => _logger.success(message);
  void err(String message) => _logger.err(message);
  void warn(String message) => _logger.warn(message);
  Progress progress(String message) => _logger.progress(message);
  void printBanner() { /* ASCII art banner */ }
}