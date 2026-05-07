class Dependency {
  final String name;
  final String version;
  final bool isDev;
  const Dependency(this.name, this.version, {this.isDev = false});
}