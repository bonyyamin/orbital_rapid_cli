import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/enums.dart';
import 'base_state_adapter.dart';

class BlocAdapter extends BaseStateAdapter {
  @override
  StateManagement get type => StateManagement.bloc;

  @override
  List<Dependency> get dependencies => [
    const Dependency('flutter_bloc', '^9.1.1'),
    const Dependency('equatable', '^2.0.8'),
  ];

  @override
  Map<String, dynamic> get templateVars => {
    'isBloc': true,
    'stateFolderName': 'bloc',
  };
}
