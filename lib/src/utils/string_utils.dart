// toSnakeCase('MyApp') → 'my_app'
// toPascalCase('my_app') → 'MyApp'
// toCamelCase('my_app') → 'myApp'
// toPackageName('My App!') → 'my_app'
class StringUtils {
  static String toSnakeCase(String input) { ... }
  static String toPascalCase(String input) { ... }
  static String toCamelCase(String input) { ... }
  static String toPackageName(String input) { ... }
  static bool isValidSnakeCase(String input) { ... }
  static bool isValidPackageName(String input) { ... }
}