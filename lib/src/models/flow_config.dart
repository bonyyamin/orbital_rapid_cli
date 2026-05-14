// The single config object that drives all generation.
// Every generator reads from this.
import 'package:orbital_rapid_cli/src/models/enums.dart';

/// The single configuration object that drives the entire generation process.
///
/// Every generator within the CLI reads from this object to determine
/// which files to generate and what content to include.
class FlowConfig {
  /// The name of the project in snake_case (e.g., my_awesome_app).
  final String projectName;

  /// The name of the project in PascalCase (e.g., MyAwesomeApp).
  final String projectNamePascal;

  /// The package name / bundle ID (e.g., com.example.app).
  final String packageName;

  /// The absolute path where the project will be generated.
  final String outputPath;

  /// The state management solution to implement.
  final StateManagement stateManagement;

  /// The backend service to integrate.
  final Backend backend;

  /// The method used for email verification if applicable.
  final EmailVerificationMethod emailVerificationMethod;

  /// The list of screens to be generated.
  final List<Screen> screens;

  /// The list of social authentication providers to enable.
  final List<SocialProvider> socialProviders;

  /// The number of pages for the onboarding flow.
  final int onboardingPageCount;

  /// Whether to include dark mode support.
  final bool hasDarkMode;

  /// Whether to include localization (l10n) support.
  final bool hasL10n;

  /// Whether to generate unit and widget tests.
  final bool generateTests;

  /// If true, the CLI will simulate the generation without writing files.
  final bool dryRun;

  /// The directory structure style for the project.
  final ProjectStructure projectStructure;

  /// Creates a new [FlowConfig] instance with the specified parameters.
  const FlowConfig({
    required this.projectName,
    required this.projectNamePascal,
    required this.packageName,
    required this.outputPath,
    required this.stateManagement,
    required this.backend,
    required this.emailVerificationMethod,
    required this.screens,
    required this.socialProviders,
    required this.onboardingPageCount,
    required this.hasDarkMode,
    required this.hasL10n,
    required this.generateTests,
    required this.dryRun,
    required this.projectStructure,
  });

  /// Returns true if Riverpod is selected for state management.
  bool get isRiverpod => stateManagement == StateManagement.riverpod;

  /// Returns true if BLoC is selected for state management.
  bool get isBloc => stateManagement == StateManagement.bloc;

  /// Returns true if GetX is selected for state management.
  bool get isGetX => stateManagement == StateManagement.getx;

  /// Returns true if Firebase is selected as the backend.
  bool get isFirebase => backend == Backend.firebase;

  /// Returns true if a REST API is selected as the backend.
  bool get isRest => backend == Backend.rest;

  /// Returns true if Supabase is selected as the backend.
  bool get isSupabase => backend == Backend.supabase;

  /// Returns true if no backend is selected.
  bool get isNoneBackend => backend == Backend.none;

  /// Returns true if the separate project structure is selected.
  bool get isSeparate => projectStructure == ProjectStructure.separate;

  /// Returns true if the in-place project structure is selected.
  bool get isInplace => projectStructure == ProjectStructure.inplace;

  /// Returns true if Google authentication is enabled.
  bool get hasGoogleAuth => socialProviders.contains(SocialProvider.google);

  /// Returns true if Facebook authentication is enabled.
  bool get hasFacebookAuth => socialProviders.contains(SocialProvider.facebook);

  /// Returns true if Apple authentication is enabled.
  bool get hasAppleAuth => socialProviders.contains(SocialProvider.apple);

  /// Returns true if GitHub authentication is enabled.
  bool get hasGithubAuth => socialProviders.contains(SocialProvider.github);

  /// Returns true if any social authentication provider is enabled.
  bool get hasSocialAuth => socialProviders.isNotEmpty;

  /// Returns true if email verification should be implemented.
  bool get shouldVerifyEmail => !isNoneBackend;

  /// Converts the configuration into a map of variables suitable for
  /// Mustache template rendering.
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
        'isNoneBackend': isNoneBackend,
        'isNone': isNoneBackend,
        'isEmailLink': emailVerificationMethod == EmailVerificationMethod.link,
        'isEmailOtp': emailVerificationMethod == EmailVerificationMethod.otp,
        'shouldVerifyEmail': shouldVerifyEmail,
        'hasDarkMode': hasDarkMode,
        'hasL10n': hasL10n,
        'hasGoogleAuth': hasGoogleAuth,
        'hasFacebookAuth': hasFacebookAuth,
        'hasAppleAuth': hasAppleAuth,
        'hasGithubAuth': hasGithubAuth,
        'hasSocialAuth': hasSocialAuth,
        'colorsClass': 'AppColors',
        'textStylesClass': 'AppTextStyles',
        'dimensionsClass': 'AppDimensions',
        'gradientsClass': 'AppGradients',
        'fontsClass': 'AppFonts',
        'stringsClass': 'AppStrings',
        'assetsClass': 'AppAssets',
        'routesClass': 'AppRoutes',
      };

  /// Creates a copy of this [FlowConfig] but with the given fields replaced
  /// with new values.
  FlowConfig copyWith({
    String? projectName,
    String? projectNamePascal,
    String? packageName,
    String? outputPath,
    StateManagement? stateManagement,
    Backend? backend,
    EmailVerificationMethod? emailVerificationMethod,
    List<Screen>? screens,
    List<SocialProvider>? socialProviders,
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
      emailVerificationMethod:
          emailVerificationMethod ?? this.emailVerificationMethod,
      screens: screens ?? this.screens,
      socialProviders: socialProviders ?? this.socialProviders,
      onboardingPageCount: onboardingPageCount ?? this.onboardingPageCount,
      hasDarkMode: hasDarkMode ?? this.hasDarkMode,
      hasL10n: hasL10n ?? this.hasL10n,
      generateTests: generateTests ?? this.generateTests,
      dryRun: dryRun ?? this.dryRun,
      projectStructure: projectStructure ?? this.projectStructure,
    );
  }
}

