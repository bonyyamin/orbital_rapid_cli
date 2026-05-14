import 'package:orbital_rapid_cli/src/generators/base_generator.dart';
import 'package:orbital_rapid_cli/src/models/dependency.dart';
import 'package:orbital_rapid_cli/src/models/generated_file.dart';

/// Generates the account deletion flow, including screens and state management.
class DeleteAccountGenerator extends BaseGenerator {
  /// Creates a [DeleteAccountGenerator] instance.
  DeleteAccountGenerator({
    required super.config,
    required super.engine,
    required super.logger,
  });


  @override
  String get name => 'Delete Account';

  @override
  List<Dependency> get requiredDependencies => [];

  @override
  Future<List<GeneratedFile>> generate() async {
    final files = <GeneratedFile>[
      await renderToFile(
        templatePath: 'templates/account/delete/$sm/delete_account_screen.dart.tmpl',
        outputPath: 'lib/features/account/presentation/delete/delete_account_screen.dart',
      ),
    ];

    if (config.isRiverpod) {
      files.addAll([
        await renderToFile(
          templatePath: 'templates/account/delete/riverpod/delete_account_notifier.dart.tmpl',
          outputPath: 'lib/features/account/presentation/delete/riverpod/delete_account_notifier.dart',
        ),
        await renderToFile(
          templatePath: 'templates/account/delete/riverpod/delete_account_provider.dart.tmpl',
          outputPath: 'lib/features/account/presentation/delete/riverpod/delete_account_provider.dart',
        ),
        await renderToFile(
          templatePath: 'templates/account/delete/riverpod/delete_account_state.dart.tmpl',
          outputPath: 'lib/features/account/presentation/delete/riverpod/delete_account_state.dart',
        ),
      ]);
    }

    if (config.isBloc) {
      files.addAll([
        await renderToFile(
          templatePath: 'templates/account/delete/bloc/delete_account_bloc.dart.tmpl',
          outputPath: 'lib/features/account/presentation/delete/bloc/delete_account_bloc.dart',
        ),
        await renderToFile(
          templatePath: 'templates/account/delete/bloc/delete_account_event.dart.tmpl',
          outputPath: 'lib/features/account/presentation/delete/bloc/delete_account_event.dart',
        ),
        await renderToFile(
          templatePath: 'templates/account/delete/bloc/delete_account_state.dart.tmpl',
          outputPath: 'lib/features/account/presentation/delete/bloc/delete_account_state.dart',
        ),
      ]);
    }

    if (config.isGetX) {
      files.addAll([
        await renderToFile(
          templatePath: 'templates/account/delete/getx/delete_account_controller.dart.tmpl',
          outputPath: 'lib/features/account/presentation/delete/getx/delete_account_controller.dart',
        ),
        await renderToFile(
          templatePath: 'templates/account/delete/getx/delete_account_binding.dart.tmpl',
          outputPath: 'lib/features/account/presentation/delete/getx/delete_account_binding.dart',
        ),
      ]);
    }

    return files;
  }
}
 
