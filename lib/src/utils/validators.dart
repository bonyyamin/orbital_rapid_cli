class Validators {
  static String? projectName(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (!RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(value))
      return 'Must be snake_case (e.g. my_app)';
    return null;
  }

  static String? packageName(String? value) {
      if (value == null || value.isEmpty) return 'Required';
      if (!RegExp(r'^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*){2,}$').hasMatch(value))
        return 'Must be com.company.app format';
      return null;
  }

  static String? outputPath(String? value) { ... }
}