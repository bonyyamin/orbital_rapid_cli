class Validators {
  static String? projectName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    if (!RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(value)) {
      return 'Must be snake_case (e.g. my_app)';
    }
    return null;
  }

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

  static String? outputPath(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Output path can be empty (defaults to current dir)
    }
    return null;
  }
}
