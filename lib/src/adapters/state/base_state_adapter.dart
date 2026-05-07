import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';

abstract class BaseStateAdapter {
  StateManagement get type;

  List<Dependency> get dependencies;

  /// Returns variables to inject into templates for this state manager
  Map<String, dynamic> get templateVars;
}
