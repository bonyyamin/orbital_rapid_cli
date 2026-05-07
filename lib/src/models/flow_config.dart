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
  });

  bool get isRiverpod => stateManagement == StateManagement.riverpod;
  bool get isBloc     => stateManagement == StateManagement.bloc;
  bool get isGetX     => stateManagement == StateManagement.getx;
  bool get isFirebase => backend == Backend.firebase;
  bool get isRest     => backend == Backend.rest;
  bool get isSupabase => backend == Backend.supabase;

  Map<String, dynamic> toTemplateVars() => {
    'projectName':       projectName,
    'projectNamePascal': projectNamePascal,
    'packageName':       packageName,
    'isRiverpod':        isRiverpod,
    'isBloc':            isBloc,
    'isGetX':            isGetX,
    'isFirebase':        isFirebase,
    'isRest':            isRest,
    'isSupabase':        isSupabase,
    'hasDarkMode':       hasDarkMode,
    'hasL10n':           hasL10n,
    'colorsClass':       'AppColors',
    'textStylesClass':   'AppTextStyles',
    'dimensionsClass':   'AppDimensions',
    'gradientsClass':    'AppGradients',
    'fontsClass':        'AppFonts',
    'stringsClass':      'AppStrings',
    'assetsClass':       'AppAssets',
    'routesClass':       'AppRoutes',
  };
}