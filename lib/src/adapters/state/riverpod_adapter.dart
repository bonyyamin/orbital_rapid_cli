import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';
import 'base_state_adapter.dart';

/// An adapter for the Riverpod state management solution.
///
/// It provides dependencies for `flutter_riverpod` and `riverpod_annotation`.
class RiverpodAdapter extends BaseStateAdapter {

  @override
  StateManagement get type => StateManagement.riverpod;

  @override
  List<Dependency> get dependencies => [
    const Dependency('flutter_riverpod', '^3.3.1'),
    const Dependency('riverpod_annotation', '^4.0.2'),
  ];

  @override
  Map<String, dynamic> get templateVars => {
    'isRiverpod': true,
    'stateFolderName': 'riverpod',
  };
}
