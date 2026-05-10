import 'package:orbital_rapid_cli/orbital_rapid_cli.dart';

void main() {
  print('Orbital Rapid CLI Example');
  
  // Using the library's calculate function
  final result = calculate();
  print('Calculation result: $result');
  
  print('\nTo use the CLI, run:');
  print('dart pub global activate orbital_rapid_cli');
  print('orbitalRapid --help');
}
