import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';
import 'base_state_adapter.dart';

class RiverpodAdapter extends BaseStateAdapter {
  @override
  StateManagement get type => StateManagement.riverpod;

  @override
  List<Dependency> get dependencies => [
    const Dependency('flutter_riverpod', '^2.4.9'),
    const Dependency('riverpod_annotation', '^2.3.3'),
  ];

  @override
  Map<String, dynamic> get templateVars => {
    'isRiverpod': true,
    'stateFolderName': 'riverpod',
  };
}
