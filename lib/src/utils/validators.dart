/// A utility class containing static methods for validating various input strings
/// used within the CLI, such as project names and package names.
class Validators {
  /// Validates that the [value] is a valid Flutter/Dart project name.
  ///
  /// A valid project name must be snake_case, starting with a letter
  /// and containing only lowercase letters, numbers, and underscores.
  static String? projectName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    if (!RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(value)) {
      return 'Must be snake_case (e.g. my_app)';
    }
    return null;
  }

  /// Validates that the [value] is a valid package name (e.g., com.example.app).
  ///
  /// If [isFinal] is true, it enforces a strict package name structure
  /// requiring at least two segments. Otherwise, it allows partial
  /// input during interactive typing.
  static String? packageName(String? value, {bool isFinal = false}) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }

    // Interactive: Allows typing one segment at a time and a trailing dot.
    // Final: Requires at least two segments and no trailing dot (e.g. com.example).
    // Extremely lenient interactive regex to avoid blocking input
    // Only enforces lowercase and basic characters, allowing dots anywhere during typing.
    final pattern = isFinal
        ? r'^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)*$'
        : r'^[a-z0-9._]*$';

    if (!RegExp(pattern).hasMatch(value)) {
      return 'Please use lowercase letters, numbers, dots, and underscores';
    }
    return null;
  }

  /// Validates the output directory path.
  ///
  /// Returns null if the path is valid or empty (which defaults to the current directory).
  static String? outputPath(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Output path can be empty (defaults to current dir)
    }
    return null;
  }
}

