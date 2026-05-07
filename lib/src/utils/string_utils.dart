class StringUtils {
  static String toSnakeCase(String input) {
    return input
        .replaceAllMapped(
            RegExp(r'([A-Z])'), (match) => '_${match.group(0)!.toLowerCase()}')
        .replaceAll(RegExp(r'[^a-z0-9_]'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceFirst(RegExp(r'^_'), '')
        .replaceFirst(RegExp(r'_$'), '');
  }

  static String toPascalCase(String input) {
    final snake = toSnakeCase(input);
    return snake
        .split('_')
        .map((part) => part.isEmpty
            ? ''
            : part[0].toUpperCase() + part.substring(1).toLowerCase())
        .join();
  }

  static String toCamelCase(String input) {
    final pascal = toPascalCase(input);
    if (pascal.isEmpty) return '';
    return pascal[0].toLowerCase() + pascal.substring(1);
  }

  static String toPackageName(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9_.]'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceFirst(RegExp(r'^_'), '')
        .replaceFirst(RegExp(r'_$'), '');
  }

  static bool isValidSnakeCase(String input) {
    return RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(input);
  }

  static bool isValidPackageName(String input) {
    return RegExp(r'^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*){2,}$').hasMatch(input);
  }
}