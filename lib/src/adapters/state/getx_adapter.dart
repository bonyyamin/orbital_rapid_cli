import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';
import 'base_state_adapter.dart';

/// An adapter for the GetX state management solution.
///
/// It provides the `get` package dependency.
class GetXAdapter extends BaseStateAdapter {

  @override
  StateManagement get type => StateManagement.getx;

  @override
  List<Dependency> get dependencies => [
    const Dependency('get', '^4.7.3'),
  ];

  @override
  Map<String, dynamic> get templateVars => {
    'isGetX': true,
    'stateFolderName': 'getx',
  };
}
