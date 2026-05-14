/// A utility class for common string manipulations required by the CLI.
class StringUtils {
  /// Converts a string to snake_case.
  static String toSnakeCase(String input) {
    return input
        .replaceAllMapped(
            RegExp(r'([A-Z])'), (match) => '_${match.group(0)!.toLowerCase()}')
        .replaceAll(RegExp(r'[^a-z0-9_]'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceFirst(RegExp(r'^_'), '')
        .replaceFirst(RegExp(r'_$'), '');
  }

  /// Converts a string to PascalCase.
  static String toPascalCase(String input) {
    final snake = toSnakeCase(input);
    return snake
        .split('_')
        .map((part) => part.isEmpty
            ? ''
            : part[0].toUpperCase() + part.substring(1).toLowerCase())
        .join();
  }

  /// Converts a string to camelCase.
  static String toCamelCase(String input) {
    final pascal = toPascalCase(input);
    if (pascal.isEmpty) return '';
    return pascal[0].toLowerCase() + pascal.substring(1);
  }

  /// Formats a string to be suitable for use as a package name/bundle ID.
  static String toPackageName(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9_.]'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceFirst(RegExp(r'^_'), '')
        .replaceFirst(RegExp(r'_$'), '');
  }

  /// Returns true if the input string is in valid snake_case format.
  static bool isValidSnakeCase(String input) {
    return RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(input);
  }

  /// Returns true if the input string is in a valid package name format
  /// (e.g., com.example.app).
  static bool isValidPackageName(String input) {
    return RegExp(r'^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*){2,}$').hasMatch(input);
  }
}