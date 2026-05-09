// The single config object that drives all generation.
// Every generator reads from this.
import 'package:orbital_rapid_cli/src/models/enums.dart';

class FlowConfig {
  final String projectName;
  final String projectNamePascal;
  final String packageName;
  final String outputPath;
  final StateManagement stateManagement;
  final Backend backend;
  final List<Screen> screens;
  final int onboardingPageCount;
  final bool hasDarkMode;
  final bool hasL10n;
  final bool generateTests;
  final bool dryRun;
  final ProjectStructure projectStructure;

  const FlowConfig({
    required this.projectName,
    required this.projectNamePascal,
    required this.packageName,
    required this.outputPath,
    required this.stateManagement,
    required this.backend,
    required this.screens,
    required this.onboardingPageCount,
    required this.hasDarkMode,
    required this.hasL10n,
    required this.generateTests,
    required this.dryRun,
    required this.projectStructure,
  });

  bool get isRiverpod => stateManagement == StateManagement.riverpod;
  bool get isBloc => stateManagement == StateManagement.bloc;
  bool get isGetX => stateManagement == StateManagement.getx;
  bool get isFirebase => backend == Backend.firebase;
  bool get isRest => backend == Backend.rest;
  bool get isSupabase => backend == Backend.supabase;
  bool get isSeparate => projectStructure == ProjectStructure.separate;
  bool get isInplace => projectStructure == ProjectStructure.inplace;

  Map<String, dynamic> toTemplateVars() => {
        'projectName': projectName,
        'projectNamePascal': projectNamePascal,
        'packageName': packageName,
        'isRiverpod': isRiverpod,
        'isBloc': isBloc,
        'isGetX': isGetX,
        'isFirebase': isFirebase,
        'isRest': isRest,
        'isSupabase': isSupabase,
        'hasDarkMode': hasDarkMode,
        'hasL10n': hasL10n,
        'colorsClass': 'AppColors',
        'textStylesClass': 'AppTextStyles',
        'dimensionsClass': 'AppDimensions',
        'gradientsClass': 'AppGradients',
        'fontsClass': 'AppFonts',
        'stringsClass': 'AppStrings',
        'assetsClass': 'AppAssets',
        'routesClass': 'AppRoutes',
      };
  FlowConfig copyWith({
    String? projectName,
    String? projectNamePascal,
    String? packageName,
    String? outputPath,
    StateManagement? stateManagement,
    Backend? backend,
    List<Screen>? screens,
    int? onboardingPageCount,
    bool? hasDarkMode,
    bool? hasL10n,
    bool? generateTests,
    bool? dryRun,
    ProjectStructure? projectStructure,
  }) {
    return FlowConfig(
      projectName: projectName ?? this.projectName,
      projectNamePascal: projectNamePascal ?? this.projectNamePascal,
      packageName: packageName ?? this.packageName,
      outputPath: outputPath ?? this.outputPath,
      stateManagement: stateManagement ?? this.stateManagement,
      backend: backend ?? this.backend,
      screens: screens ?? this.screens,
      onboardingPageCount: onboardingPageCount ?? this.onboardingPageCount,
      hasDarkMode: hasDarkMode ?? this.hasDarkMode,
      hasL10n: hasL10n ?? this.hasL10n,
      generateTests: generateTests ?? this.generateTests,
      dryRun: dryRun ?? this.dryRun,
      projectStructure: projectStructure ?? this.projectStructure,
    );
  }
}
