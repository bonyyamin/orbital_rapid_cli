enum StateManagement {
  riverpod('riverpod', 'Riverpod'),
  bloc('bloc', 'BLoC'),
  getx('getx', 'GetX');

  final String key;
  final String label;
  const StateManagement(this.key, this.label);

  String get folderName => key;
}

enum Backend {
  firebase('firebase', 'Firebase'),
  rest('rest', 'REST API'),
  supabase('supabase', 'Supabase'),
  none('none', 'None (add later)');

  final String key;
  final String label;
  const Backend(this.key, this.label);
}

enum EmailVerificationMethod {
  link('link', 'Link Verification'),
  otp('otp', 'Email OTP');

  final String key;
  final String label;
  const EmailVerificationMethod(this.key, this.label);
}

enum Screen {
  splash('splash', 'Splash Screen'),
  onboarding('onboarding', 'Onboarding Flow'),
  login('login', 'Login'),
  register('register', 'Register'),
  verifyEmail('verify_email', 'Verify Email'),
  forgotPassword('forgot_password', 'Forgot Password'),
  accountDeletion('account_deletion', 'Account Deletion');

  final String key;
  final String label;
  const Screen(this.key, this.label);
}

enum ProjectStructure {
  separate('separate', 'Create in new directory'),
  inplace('inplace', 'Generate in current directory');

  final String key;
  final String label;
  const ProjectStructure(this.key, this.label);
}

enum SocialProvider {
  google('google', 'Google'),
  facebook('facebook', 'Facebook'),
  apple('apple', 'Apple'),
  github('github', 'GitHub');

  final String key;
  final String label;
  const SocialProvider(this.key, this.label);
}
