/// Supported state management solutions.
enum StateManagement {
  /// Riverpod state management.
  riverpod('riverpod', 'Riverpod'),

  /// BLoC (Business Logic Component) state management.
  bloc('bloc', 'BLoC'),

  /// GetX state management.
  getx('getx', 'GetX');

  /// The internal key used for templates.
  final String key;

  /// The human-readable label.
  final String label;

  /// Creates a [StateManagement] option.
  const StateManagement(this.key, this.label);

  /// The folder name used when generating state-specific code.
  String get folderName => key;
}

/// Supported backend services.
enum Backend {
  /// Google Firebase backend.
  firebase('firebase', 'Firebase'),

  /// Custom REST API backend.
  rest('rest', 'REST API'),

  /// Supabase backend.
  supabase('supabase', 'Supabase'),

  /// No backend integration (manual setup).
  none('none', 'None (add later)');

  /// The internal key used for templates.
  final String key;

  /// The human-readable label.
  final String label;

  /// Creates a [Backend] option.
  const Backend(this.key, this.label);
}

/// Supported email verification methods.
enum EmailVerificationMethod {
  /// Verification via a magic link sent to the email.
  link('link', 'Link Verification'),

  /// Verification via a One-Time Password (OTP).
  otp('otp', 'Email OTP');

  /// The internal key used for templates.
  final String key;

  /// The human-readable label.
  final String label;

  /// Creates an [EmailVerificationMethod] option.
  const EmailVerificationMethod(this.key, this.label);
}

/// Available screen templates that can be generated.
enum Screen {
  /// A simple splash screen.
  splash('splash', 'Splash Screen'),

  /// An onboarding flow with multiple pages.
  onboarding('onboarding', 'Onboarding Flow'),

  /// A standard login screen.
  login('login', 'Login'),

  /// A user registration screen.
  register('register', 'Register'),

  /// An email verification screen.
  verifyEmail('verify_email', 'Verify Email'),

  /// A password recovery/reset screen.
  forgotPassword('forgot_password', 'Forgot Password'),

  /// A screen for managing account deletion.
  accountDeletion('account_deletion', 'Account Deletion');

  /// The internal key used for templates.
  final String key;

  /// The human-readable label.
  final String label;

  /// Creates a [Screen] option.
  const Screen(this.key, this.label);
}

/// Defines where the project files will be generated.
enum ProjectStructure {
  /// Generates the project in a new subdirectory.
  separate('separate', 'Create in new directory'),

  /// Generates the project directly in the current directory.
  inplace('inplace', 'Generate in current directory');

  /// The internal key used for templates.
  final String key;

  /// The human-readable label.
  final String label;

  /// Creates a [ProjectStructure] option.
  const ProjectStructure(this.key, this.label);
}

/// Supported third-party social authentication providers.
enum SocialProvider {
  /// Google authentication.
  google('google', 'Google'),

  /// Facebook authentication.
  facebook('facebook', 'Facebook'),

  /// Apple authentication.
  apple('apple', 'Apple'),

  /// GitHub authentication.
  github('github', 'GitHub');

  /// The internal key used for templates.
  final String key;

  /// The human-readable label.
  final String label;

  /// Creates a [SocialProvider] option.
  const SocialProvider(this.key, this.label);
}

