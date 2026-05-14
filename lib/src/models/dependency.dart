/// Represents a Pub dependency to be added to the generated project's pubspec.yaml.
class Dependency {
  /// The name of the package.
  final String name;

  /// The version constraint (e.g., ^1.0.0).
  final String version;

  /// Whether this is a dev_dependency.
  final bool isDev;

  /// Creates a [Dependency] instance.
  const Dependency(this.name, this.version, {this.isDev = false});
}