# Orbital Rapid CLI — Complete Documentation

**Version**: 1.0.0
**Last updated**: May 2026
**Dart SDK**: >=3.0.0

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [Installation](#2-installation)
3. [Getting Started](#3-getting-started)
4. [CLI Reference](#4-cli-reference)
5. [Configuration](#5-configuration)
6. [Generated Project Guide](#6-generated-project-guide)
7. [Design System Guide](#7-design-system-guide)
8. [State Management Guide](#8-state-management-guide)
9. [Backend Guide](#9-backend-guide)
10. [Screen Reference](#10-screen-reference)
11. [Customization Guide](#11-customization-guide)
12. [Contributing](#12-contributing)
13. [Troubleshooting](#13-troubleshooting)
14. [FAQ](#14-faq)
15. [Changelog](#15-changelog)

---

## 1. Introduction

### What is Orbital Rapid CLI?

Orbital Rapid CLI is a command-line tool that generates production-ready Flutter application flows. In a single command, it scaffolds a complete project with:

- Splash screen
- Onboarding flow
- Login screen
- Registration screen
- Forgot password screen
- Logout flow
- Account deletion flow

Every generated project uses clean architecture, feature-first folder structure, and a token-based design system that you customize once to brand your entire app.

### Why Orbital Rapid CLI?

Most Flutter developers spend the first 3–7 days of every project writing the same boilerplate:
- Same auth screens
- Same state management wiring
- Same folder structure
- Same utils files
- Same pubspec setup

Orbital Rapid CLI eliminates all of that. You go from zero to a running, structured project in under 2 minutes.

### What Orbital Rapid CLI is NOT

- It is not a low-code tool. It generates real, editable Dart code.
- It is not a runtime dependency. Once generated, your project has zero dependency on the CLI.
- It is not opinionated about your business logic. It generates structure and boilerplate, not your app's logic.
- It does not lock you in. Generated code is 100% yours.

---

## 2. Installation

### Prerequisites

| Requirement | Version |
|---|---|
| Dart SDK | >=3.0.0 |
| Flutter SDK | >=3.10.0 (for generated project) |
| Operating System | macOS, Linux, Windows |

### Install from pub.dev

```bash
dart pub global activate orbital_rapid_cli
```

### Verify Installation

```bash
orbitalRapid --version
# Orbital Rapid CLI v1.0.0
```

### PATH Setup

If `orbitalRapid` is not found after activation, add the Dart pub cache bin to your PATH:

**macOS / Linux (bash)**
```bash
echo 'export PATH="$PATH":"$HOME/.pub-cache/bin"' >> ~/.bashrc
source ~/.bashrc
```

**macOS / Linux (zsh)**
```bash
echo 'export PATH="$PATH":"$HOME/.pub-cache/bin"' >> ~/.zshrc
source ~/.zshrc
```

**Windows (PowerShell)**
```powershell
$env:PATH += ";$env:APPDATA\Pub\Cache\bin"
```

### Upgrade to Latest

```bash
orbitalRapid upgrade
```

### Uninstall

```bash
dart pub global deactivate orbital_rapid_cli
```

---

## 3. Getting Started

### Your First Project

```bash
cd ~/projects
orbitalRapid init
```

You will be guided through a short set of prompts:

```
Orbital Rapid CLI v1.0.0
━━━━━━━━━━━━━━━━━━━━━━

? Project name (snake_case): my_awesome_app
? Package identifier: com.mycompany.myawesomeapp
? State management:
  ❯ Riverpod
    BLoC
    GetX
? Backend:
  ❯ Firebase
    REST API
    Supabase
    None (I'll add it later)
? Screens to generate (space to select, enter to confirm):
  ❯ ✅ Splash
    ✅ Onboarding
    ✅ Login
    ✅ Register
    ✅ Forgot Password
    ✅ Account Deletion
? Number of onboarding pages: 3
? Include dark mode support? Yes
? Include localization scaffolding? No

⠸ Generating project structure...    ✅
⠸ Generating core utils...           ✅
⠸ Generating theme...                ✅
⠸ Generating splash...               ✅
⠸ Generating onboarding...           ✅
⠸ Generating auth screens...         ✅
⠸ Generating account screens...      ✅
⠸ Injecting dependencies...          ✅

✅ 47 files generated in 1.8s
📁 ./my_awesome_app/

Next steps:
  cd my_awesome_app
  flutter pub get
  flutter run
```

### Run Your Generated App

```bash
cd my_awesome_app
flutter pub get
flutter run
```

The app runs immediately with placeholder content. Your next step is customizing the design system.

### Customize Your Design System

Open `lib/core/utils/` and update these files:

```
app_colors.dart      ← swap hex values to your brand colors
app_fonts.dart       ← set your font family name
app_text_styles.dart ← adjust font sizes and weights
app_dimensions.dart  ← adjust spacing values if needed
app_strings.dart     ← replace all text content
app_gradients.dart   ← update gradient colors
```

Every screen in your app reads from these files. Change a value once, it updates everywhere.

---

## 4. CLI Reference

### `orbitalRapid init`

Scaffolds a complete new Flutter project.

**Usage**

```bash
orbitalRapid init [options]
```

**Options**

| Option | Type | Description | Default |
|---|---|---|---|
| `--name` | String | Project name in snake_case | Prompted |
| `--package` | String | Package identifier (com.company.app) | Prompted |
| `--state` | Enum | State management: `riverpod`, `bloc`, `getx` | Prompted |
| `--backend` | Enum | Backend: `firebase`, `rest`, `supabase`, `none` | Prompted |
| `--screens` | List/String | Comma-separated screen names or `all` | Prompted |
| `--onboarding-pages` | Int | Number of onboarding pages (1–10) | `3` |
| `--dark-mode` | Bool | Generate dark mode support | `false` |
| `--l10n` | Bool | Generate localization scaffolding | `false` |
| `--tests` | Bool | Generate test files | `false` |
| `--dry-run` | Bool | Preview files without writing | `false` |
| `--output` | String | Output directory path | `.` |
| `--config` | String | Path to `orbitalRapid.yaml` | — |

**Examples**

```bash
# Interactive mode
orbitalRapid init

# Fully non-interactive
orbitalRapid init \
  --name=my_app \
  --package=com.example.myapp \
  --state=riverpod \
  --backend=firebase \
  --screens=all \
  --dark-mode \
  --tests

# Preview without writing
orbitalRapid init --name=test_app --state=bloc --dry-run

# From config file
orbitalRapid init --config=./orbitalRapid.yaml
```

---

### `orbitalRapid add`

Adds a single screen or flow to an existing Flutter project.

**Usage**

```bash
orbitalRapid add <screen> [options]
```

**Screens**

| Screen | Command |
|---|---|
| Splash | `orbitalRapid add splash` |
| Onboarding | `orbitalRapid add onboarding` |
| Login | `orbitalRapid add login` |
| Register | `orbitalRapid add register` |
| Forgot Password | `orbitalRapid add forgot-password` |
| Logout | `orbitalRapid add logout` |
| Account Deletion | `orbitalRapid add account-deletion` |

**Options**

| Option | Description |
|---|---|
| `--state` | Override state management |
| `--backend` | Override backend |
| `--pages` | Onboarding page count (onboarding only) |
| `--dry-run` | Preview without writing |

**Examples**

```bash
# Add login with auto-detected state manager (reads orbitalRapid.yaml)
orbitalRapid add login

# Explicitly set state and backend
orbitalRapid add login --state=bloc --backend=rest

# Add onboarding with 5 pages
orbitalRapid add onboarding --pages=5

# Preview what would be added
orbitalRapid add register --dry-run
```

> **Note**: When running `add` inside an existing project, the CLI reads `orbitalRapid.yaml` for project config. If not found, it prompts for the missing values.

---

### `orbitalRapid upgrade`

Upgrades the CLI to the latest published version.

```bash
orbitalRapid upgrade
```

---

### `orbitalRapid --version`

Prints the installed CLI version.

```bash
orbitalRapid --version
# Orbital Rapid CLI v1.0.0
```

---

### `orbitalRapid --help`

Prints help for any command.

```bash
orbitalRapid --help
orbitalRapid init --help
orbitalRapid add --help
```

---

## 5. Configuration

### Interactive Prompts

When no flags are provided, the CLI presents an interactive prompt session. This is the recommended mode for first-time use.

### Inline Flags

Pass all options as flags to skip prompts entirely. Useful for scripts and CI pipelines.

```bash
orbitalRapid init \
  --name=my_app \
  --package=com.example.myapp \
  --state=riverpod \
  --backend=firebase \
  --screens=splash,onboarding,login,register \
  --dark-mode
```

### orbitalRapid.yaml (Team Config)

Save your configuration to a `orbitalRapid.yaml` file and commit it to your repository. This ensures every team member generates identical project structure.

**Full Schema**

```yaml
version: 1

project:
  name: my_awesome_app           # snake_case, required
  package: com.company.myapp     # required

generation:
  state_management: riverpod     # riverpod | bloc | getx
  backend: firebase              # firebase | rest | supabase | none
  screens: all                   # 'all' or list below:
    # - splash
    # - onboarding
    # - login
    # - register
    # - forgot_password
    # - account_deletion
  onboarding_pages: 3            # 1–10, default 3

features:
  dark_mode: true                # default false
  localization: false            # default false
  generate_tests: false          # default false

output:
  path: ./                       # where to create project dir
```

**Usage**

```bash
orbitalRapid init --config=orbitalRapid.yaml
```

When using a config file, you are never prompted. All values come from the file.

---

## 6. Generated Project Guide

### Project Structure

```
my_app/
│
├── lib/
│   ├── core/
│   │   ├── utils/                 ← Customize your design system here
│   │   │   ├── app_colors.dart
│   │   │   ├── app_gradients.dart
│   │   │   ├── app_text_styles.dart
│   │   │   ├── app_fonts.dart
│   │   │   ├── app_dimensions.dart
│   │   │   └── app_strings.dart
│   │   │
│   │   ├── theme/
│   │   │   ├── app_theme.dart
│   │   │   └── app_dark_theme.dart
│   │   │
│   │   ├── constants/
│   │   │   ├── app_assets.dart
│   │   │   ├── app_routes.dart
│   │   │   └── app_enums.dart
│   │   │
│   │   ├── network/               ← REST backend only
│   │   │   ├── api_client.dart
│   │   │   ├── api_endpoints.dart
│   │   │   └── interceptors/
│   │   │       ├── auth_interceptor.dart
│   │   │       └── logging_interceptor.dart
│   │   │
│   │   └── services/
│   │       ├── storage_service.dart
│   │       ├── navigation_service.dart
│   │       └── auth_service.dart
│   │
│   ├── features/
│   │   ├── splash/
│   │   │   └── presentation/
│   │   │       └── splash_screen.dart
│   │   │
│   │   ├── onboarding/
│   │   │   ├── data/
│   │   │   │   └── onboarding_content.dart
│   │   │   └── presentation/
│   │   │       ├── onboarding_screen.dart
│   │   │       ├── riverpod/               ← or bloc/ or getx/
│   │   │       │   ├── onboarding_provider.dart
│   │   │       │   └── onboarding_state.dart
│   │   │       └── widgets/
│   │   │           ├── onboarding_page.dart
│   │   │           └── page_indicator.dart
│   │   │
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   │   ├── auth_repository.dart
│   │   │   │   └── models/
│   │   │   │       └── user_model.dart
│   │   │   ├── domain/
│   │   │   │   └── usecases/
│   │   │   │       ├── login_usecase.dart
│   │   │   │       ├── register_usecase.dart
│   │   │   │       ├── logout_usecase.dart
│   │   │   │       └── forgot_password_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── login/
│   │   │       │   ├── login_screen.dart
│   │   │       │   ├── riverpod/
│   │   │       │   └── widgets/
│   │   │       ├── register/
│   │   │       │   ├── register_screen.dart
│   │   │       │   ├── riverpod/
│   │   │       │   └── widgets/
│   │   │       └── forgot_password/
│   │   │           ├── forgot_password_screen.dart
│   │   │           └── riverpod/
│   │   │
│   │   └── account/
│   │       ├── data/
│   │       │   └── account_repository.dart
│   │       └── presentation/
│   │           ├── account_screen.dart
│   │           ├── delete_account_screen.dart
│   │           ├── riverpod/
│   │           └── widgets/
│   │
│   └── main.dart
│
├── assets/
│   ├── images/
│   ├── icons/
│   ├── fonts/
│   └── lottie/
│
├── test/                          ← if --tests flag used
│
├── pubspec.yaml
├── analysis_options.yaml
├── .gitignore
└── orbitalRapid.yaml
```

### Architecture Pattern

Generated projects follow **clean architecture** with a **feature-first** folder structure:

```
Data Layer        → API calls, local storage, models
Domain Layer      → Business logic, use cases, repository interfaces
Presentation Layer → Screens, widgets, state management
```

Dependencies only flow inward:

```
Presentation → Domain ← Data
```

The `Domain` layer has zero Flutter dependencies — it is pure Dart.

---

## 7. Design System Guide

The design system lives entirely in `lib/core/utils/`. This is the **only folder you need to modify** to fully brand your app. Every screen, widget, and component reads values from these files.

### app_colors.dart

Defines all color tokens used throughout the app.

```dart
class AppColors {
  AppColors._();

  // ─── Brand Colors ───────────────────────────────────
  static const Color primary      = Color(0xFF6C63FF); // ← Change to your brand color
  static const Color primaryLight = Color(0xFF9D97FF);
  static const Color primaryDark  = Color(0xFF3D35CC);
  static const Color secondary    = Color(0xFFFF6584);

  // ─── Backgrounds ────────────────────────────────────
  static const Color background   = Color(0xFFFFFFFF);
  static const Color surface      = Color(0xFFF5F5F5);
  static const Color card         = Color(0xFFFFFFFF);

  // ─── Text ───────────────────────────────────────────
  static const Color textPrimary   = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint      = Color(0xFFB0B7C3);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ─── Status ─────────────────────────────────────────
  static const Color success = Color(0xFF4CAF50);
  static const Color error   = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFC107);
  static const Color info    = Color(0xFF2196F3);

  // ─── UI Elements ────────────────────────────────────
  static const Color divider    = Color(0xFFE5E7EB);
  static const Color inputBorder = Color(0xFFD1D5DB);
  static const Color inputFill  = Color(0xFFF9FAFB);

  // ─── Dark Mode ──────────────────────────────────────
  static const Color backgroundDark = Color(0xFF0F0F1A);
  static const Color surfaceDark    = Color(0xFF1A1A2E);
  static const Color cardDark       = Color(0xFF252540);
}
```

**How to customize**: Replace hex values. The change propagates to every screen instantly.

---

### app_fonts.dart

Defines font family names.

```dart
class AppFonts {
  AppFonts._();

  static const String primary   = 'Poppins';    // ← Change to your font
  static const String secondary = 'Inter';
  static const String mono      = 'JetBrainsMono';
}
```

**How to add a custom font**:
1. Download your font `.ttf` files
2. Place them in `assets/fonts/`
3. Add to `pubspec.yaml`:
   ```yaml
   flutter:
     fonts:
       - family: YourFont
         fonts:
           - asset: assets/fonts/YourFont-Regular.ttf
           - asset: assets/fonts/YourFont-Bold.ttf
             weight: 700
   ```
4. Update `AppFonts.primary` to `'YourFont'`

---

### app_text_styles.dart

Defines all text style tokens. Built on top of `AppColors` and `AppFonts`.

```dart
class AppTextStyles {
  AppTextStyles._();

  static TextStyle get displayLarge => TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 32,                    // ← Adjust sizes here
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get heading1 => TextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get heading2 => TextStyle(...);
  static TextStyle get bodyLarge => TextStyle(...);
  static TextStyle get bodyMedium => TextStyle(...);
  static TextStyle get label => TextStyle(...);
  static TextStyle get button => TextStyle(...);
  static TextStyle get input => TextStyle(...);
  static TextStyle get caption => TextStyle(...);
}
```

---

### app_dimensions.dart

Defines all spacing, sizing, and radius tokens.

```dart
class AppDimensions {
  AppDimensions._();

  // ─── Spacing ─────────────────────────────────────────
  static const double xs  = 4;    // ← Adjust spacing scale here
  static const double sm  = 8;
  static const double md  = 16;
  static const double lg  = 24;
  static const double xl  = 32;
  static const double xxl = 48;

  // ─── Border Radius ───────────────────────────────────
  static const double radiusSm   = 8;
  static const double radiusMd   = 12;
  static const double radiusLg   = 16;
  static const double radiusXl   = 24;
  static const double radiusFull = 999;

  // ─── Component Sizes ─────────────────────────────────
  static const double buttonHeight = 52;
  static const double inputHeight  = 52;
  static const double iconSm       = 16;
  static const double iconMd       = 24;
  static const double iconLg       = 32;
  static const double avatarMd     = 56;
  static const double avatarLg     = 96;

  // ─── Screen-specific ─────────────────────────────────
  static const double splashLogoSize        = 120;
  static const double onboardingImageHeight = 300;
}
```

---

### app_strings.dart

Defines all text content. Replace these strings with your app's copy.

```dart
class AppStrings {
  AppStrings._();

  // App
  static const String appName = 'MyApp';          // ← Start here

  // Onboarding pages content
  static const List<OnboardingContent> onboardingPages = [
    OnboardingContent(
      title: 'Welcome to MyApp',
      subtitle: 'Your first value proposition',
      image: AppAssets.onboarding1,
    ),
    // Add/remove pages here
  ];

  // Login
  static const String loginTitle    = 'Welcome Back';
  static const String loginSubtitle = 'Sign in to continue';
  static const String loginButton   = 'Sign In';
  // ...all other strings
}
```

**Localization Note**: If you chose `--l10n` during generation, the CLI generates ARB files and the app uses Flutter's `AppLocalizations`. The strings above are replaced with `l10n.loginTitle` etc.

---

### app_gradients.dart

Defines gradient tokens. Colors are referenced from `AppColors`.

```dart
class AppGradients {
  AppGradients._();

  static const LinearGradient primary = LinearGradient(
    colors: [AppColors.primary, AppColors.primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient splash = LinearGradient(
    colors: [AppColors.primary, AppColors.secondary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
```

---

## 8. State Management Guide

### Riverpod

Generated with `--state=riverpod`.

**Files generated per screen**:
- `*_screen.dart` — `ConsumerWidget` or `ConsumerStatefulWidget`
- `*_provider.dart` — `StateNotifierProvider` or `AsyncNotifierProvider`
- `*_state.dart` — Immutable state class
- `*_notifier.dart` — `StateNotifier` or `AsyncNotifier`

**Login example**:

```
features/auth/presentation/login/
├── login_screen.dart         (ConsumerWidget)
├── riverpod/
│   ├── login_provider.dart   (StateNotifierProvider)
│   ├── login_notifier.dart   (StateNotifier<LoginState>)
│   └── login_state.dart      (sealed class / freezed)
└── widgets/
    ├── login_form.dart
    └── social_login_button.dart
```

**Dependencies injected**:
```yaml
flutter_riverpod: ^2.4.0
riverpod_annotation: ^2.3.0  # if code gen chosen
```

---

### BLoC

Generated with `--state=bloc`.

**Files generated per screen**:
- `*_screen.dart` — `BlocBuilder` / `BlocConsumer`
- `*_bloc.dart` — `Bloc<Event, State>`
- `*_event.dart` — Sealed event classes
- `*_state.dart` — Sealed state classes

**Login example**:

```
features/auth/presentation/login/
├── login_screen.dart         (BlocConsumer)
├── bloc/
│   ├── login_bloc.dart       (Bloc<LoginEvent, LoginState>)
│   ├── login_event.dart      (sealed LoginEvent)
│   └── login_state.dart      (sealed LoginState)
└── widgets/
```

**Dependencies injected**:
```yaml
flutter_bloc: ^8.1.4
bloc: ^8.1.3
get_it: ^7.6.7             # service locator for DI
injectable: ^2.3.2
```

---

### GetX

Generated with `--state=getx`.

**Files generated per screen**:
- `*_screen.dart` — `GetView<Controller>`
- `*_controller.dart` — `GetxController`
- `*_binding.dart` — `Bindings`

**Login example**:

```
features/auth/presentation/login/
├── login_screen.dart         (GetView<LoginController>)
├── getx/
│   ├── login_controller.dart (GetxController)
│   └── login_binding.dart    (Bindings)
└── widgets/
```

**Dependencies injected**:
```yaml
get: ^4.6.6
```

---

## 9. Backend Guide

### Firebase

Generated with `--backend=firebase`.

**Setup required after generation**:

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Add Android and iOS apps
3. Download `google-services.json` → place in `android/app/`
4. Download `GoogleService-Info.plist` → place in `ios/Runner/`
5. Run `flutterfire configure` (if using FlutterFire CLI)

**Generated auth repository**:

```dart
class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<UserModel> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel.fromFirebase(credential.user!);
  }

  @override
  Future<void> logout() => _auth.signOut();

  @override
  Future<void> deleteAccount() async {
    final user = _auth.currentUser!;
    await user.delete();
  }

  // ... register, forgotPassword, etc.
}
```

**Dependencies injected**:
```yaml
firebase_core: ^2.27.0
firebase_auth: ^4.19.0
google_sign_in: ^6.2.1
cloud_firestore: ^4.17.0
```

---

### REST API

Generated with `--backend=rest`.

**Setup required after generation**:

Open `lib/core/network/api_endpoints.dart` and set your base URL:

```dart
class ApiEndpoints {
  static const String baseUrl = 'https://api.yourapp.com'; // ← Set this

  // Auth
  static const String login          = '/auth/login';
  static const String register       = '/auth/register';
  static const String logout         = '/auth/logout';
  static const String forgotPassword = '/auth/forgot-password';
  static const String deleteAccount  = '/auth/account';
  static const String refreshToken   = '/auth/refresh';
}
```

**Generated features**:
- `Dio` client with base options
- Auth interceptor (auto-attaches Bearer token)
- Token refresh interceptor (handles 401, refreshes and retries)
- Logging interceptor (dev mode only)
- Secure token storage via `flutter_secure_storage`

**Dependencies injected**:
```yaml
dio: ^5.4.3+1
flutter_secure_storage: ^9.0.0
pretty_dio_logger: ^1.3.1
```

---

### Supabase

Generated with `--backend=supabase`.

**Setup required after generation**:

Update `main.dart` with your Supabase credentials:

```dart
await Supabase.initialize(
  url: 'https://YOUR_PROJECT.supabase.co',     // ← Set this
  anonKey: 'YOUR_ANON_KEY',                    // ← Set this
);
```

**Dependencies injected**:
```yaml
supabase_flutter: ^2.3.0
```

---

### None (Custom Backend)

Generated with `--backend=none`.

An abstract `AuthRepository` interface is generated with stub implementations. You implement the interface for your backend.

```dart
abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String name, String email, String password);
  Future<void> logout();
  Future<void> forgotPassword(String email);
  Future<void> deleteAccount();
  Stream<UserModel?> get authStateChanges;
}

// Generated stub — replace with your implementation
class CustomAuthRepository implements AuthRepository {
  @override
  Future<UserModel> login(String email, String password) {
    // TODO: Implement with your backend
    throw UnimplementedError();
  }
  // ...
}
```

---

## 10. Screen Reference

### Splash Screen

**What it does**:
- Displays app logo and optionally a tagline
- Checks auth state in background
- Navigates to onboarding (first time) or home (returning user) or login (unauthenticated)

**Customize**:
- `AppAssets.splashLogo` — replace with your logo
- `AppColors.primary` — changes background gradient
- `AppStrings.splashTagline` — changes tagline text
- `AppDimensions.splashLogoSize` — changes logo size

---

### Onboarding Screen

**What it does**:
- Multi-page horizontal swipe flow
- Skip button (goes directly to login/register)
- Next button (advances pages)
- Get Started button (last page, goes to login/register)
- Saves "seen" flag to SharedPreferences (never shows again)

**Customize**:
- `AppStrings.onboardingPages` — set title, subtitle, image per page
- `AppAssets.onboarding1/2/3` — set images per page
- Add/remove pages by editing the list

---

### Login Screen

**What it does**:
- Email + password form with real-time validation
- Loading state on submit
- Error display (wrong credentials, network error)
- Navigation to Register, Forgot Password

**Customize**:
- `AppStrings.loginTitle/Subtitle` — change headline
- `AppStrings.loginButton` — change button text
- Backend implementation in `AuthRepository.login()`

---

### Register Screen

**What it does**:
- Full name, email, password, confirm password fields
- Real-time validation with error messages
- Terms & conditions checkbox
- Success → navigates to home or email verification

**Customize**:
- `AppStrings.registerTitle/Subtitle`
- Terms URL in `AppStrings.registerTermsUrl`
- Backend implementation in `AuthRepository.register()`

---

### Forgot Password Screen

**What it does**:
- Email input
- Sends password reset email/link
- Success and error states

**Customize**:
- `AppStrings.forgotTitle/Subtitle/Button`
- Backend implementation in `AuthRepository.forgotPassword()`

---

### Account Deletion Screen

**What it does**:
- Re-authenticates user (security requirement)
- Shows confirmation dialog
- Requires user to type `DELETE` to confirm
- Calls backend delete
- Clears all local data and tokens
- Navigates to login

**Customize**:
- `AppStrings.deleteTitle/Message/Button`
- `AppStrings.deleteConfirmKey` — the word user must type (default `DELETE`)

**Security note**: Re-authentication before deletion is a Firebase requirement and a security best practice for all backends.

---

## 11. Customization Guide

### Adding a New Screen Manually

If you want to add a screen following the same clean architecture pattern:

```
lib/features/my_feature/
├── data/
│   ├── models/
│   │   └── my_model.dart
│   └── repositories/
│       └── my_repository.dart
├── domain/
│   └── usecases/
│       └── my_usecase.dart
└── presentation/
    ├── my_screen.dart
    ├── riverpod/                    ← match your chosen state manager
    │   ├── my_provider.dart
    │   └── my_state.dart
    └── widgets/
        └── my_widget.dart
```

Follow the same pattern as generated screens:
- Reference only `AppColors`, `AppTextStyles`, `AppDimensions`, `AppStrings`
- Never hardcode colors, sizes, or strings
- Keep domain layer Flutter-free

### Replacing the Font

1. Download font files
2. Place in `assets/fonts/`
3. Register in `pubspec.yaml` under `flutter.fonts`
4. Change `AppFonts.primary` to your font name
5. Run `flutter pub get`

All text styles automatically use the new font.

### Adding a New Color

1. Add to `AppColors`:
   ```dart
   static const Color brand500 = Color(0xFFYOURCOLOR);
   ```
2. Use it anywhere: `color: AppColors.brand500`

### Switching State Management (After Generation)

Not recommended as it requires rewriting all state classes. Instead, run `orbitalRapid init` with the correct state manager from the start.

If you must switch, use `orbitalRapid add <screen> --state=newmanager` to regenerate individual screens.

---

## 12. Contributing

### Ways to Contribute

- **Bug reports**: [Open an issue](https://github.com/YOUR_USERNAME/orbital_rapid_cli/issues/new?template=bug_report.md)
- **Feature requests**: [Open a discussion](https://github.com/YOUR_USERNAME/orbital_rapid_cli/discussions/new)
- **New screen templates**: Add generator + templates (see below)
- **New backend adapters**: Add adapter class + auth repository template
- **New state management**: Add adapter + template folders
- **Documentation**: Fix typos, improve examples, translate
- **Tests**: Increase test coverage

### Development Setup

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/orbital_rapid_cli.git
cd orbital_rapid_cli

# Get dependencies
dart pub get

# Run tests
dart test

# Activate locally
dart pub global activate --source path .

# Test your changes
orbitalRapid init --dry-run
```

### Adding a New Screen Template

**1. Create generator class**

```dart
// lib/src/generators/my_screen_generator.dart
class MyScreenGenerator extends BaseGenerator {
  @override
  String get name => 'My Screen';

  @override
  List<Dependency> get requiredDependencies => [];

  @override
  Future<List<GeneratedFile>> generate() async {
    final files = <GeneratedFile>[];
    final statePath = config.stateManagement.folderName;

    files.add(GeneratedFile(
      relativePath: 'lib/features/my_screen/presentation/my_screen.dart',
      content: await render('templates/my_screen/$statePath/my_screen.dart.tmpl', {}),
      type: FileType.dart,
    ));

    return files;
  }
}
```

**2. Create template files**

```
lib/src/templates/my_screen/
├── riverpod/
│   └── my_screen.dart.tmpl
├── bloc/
│   └── my_screen.dart.tmpl
└── getx/
    └── my_screen.dart.tmpl
```

**3. Register generator**

In `generator_orchestrator.dart`, add to `_resolveGenerators()`:

```dart
if (config.screens.contains(Screen.myScreen))
  MyScreenGenerator(config: config),
```

**4. Add to Screen enum and prompts**

**5. Submit a PR**

### Pull Request Guidelines

- One feature or fix per PR
- Include tests for new generators
- Update CHANGELOG.md
- Follow existing code style
- Ensure `dart analyze` passes with no warnings
- Ensure `dart test` passes

### Code Style

This project follows [Dart's official style guide](https://dart.dev/guides/language/effective-dart/style) and uses `dart analyze` with the rules in `analysis_options.yaml`.

```bash
dart analyze
dart format .
```

---

## 13. Troubleshooting

### `orbitalRapid: command not found`

Your Dart pub cache bin is not in your PATH.

**Fix**:
```bash
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

Add this line to `~/.zshrc` or `~/.bashrc` to make it permanent.

---

### Generation fails halfway

The CLI writes atomically. If generation fails, no files are written. Check the error message — it will point to the exact failure.

Common causes:
- Output directory already exists and is not empty
- No write permission in the output directory
- Invalid project name (must be snake_case, no hyphens)

---

### `flutter pub get` fails after generation

A generated dependency may have been updated and the specified version no longer exists.

**Fix**:
```bash
dart pub global activate orbital_rapid_cli  # reinstall latest CLI
orbitalRapid init ...  # regenerate
```

Or manually update the version in `pubspec.yaml` and run `flutter pub get`.

---

### Generated Firebase app doesn't compile

You need to add your Firebase config files before the app compiles.

**Fix**: Follow the [Firebase setup steps](#firebase) in the Backend Guide.

---

### Fonts not showing after changing app_fonts.dart

1. Ensure font files are in `assets/fonts/`
2. Ensure `pubspec.yaml` `flutter.fonts` section has the correct family name and asset paths
3. Run `flutter pub get`
4. Do a full hot restart (not just hot reload)

---

### `orbitalRapid add` not detecting my project config

The `add` command looks for `orbitalRapid.yaml` in the current directory. Ensure you are running the command from your project root.

---

## 14. FAQ

**Q: Does the CLI require internet access?**
A: No. The CLI runs entirely locally. All templates are bundled with the package. However, the generated app may need internet for Firebase/REST/Supabase.

---

**Q: Can I use the CLI to add screens to a project not created by the CLI?**
A: Yes, with `orbitalRapid add`. You will be prompted for your state manager and backend if `orbitalRapid.yaml` is not present. However, the generated files assume the `lib/core/utils/` token structure exists. You may need to create those files first.

---

**Q: Can I use the CLI with an existing custom design system?**
A: The CLI always generates its own `lib/core/utils/` files. After generation, you can delete those files and replace the import references in generated screens with your own file paths and class names.

---

**Q: Is the generated code production-ready?**
A: The structure and patterns are production-grade. The UI is functional but minimal — you will need to apply your own design polish (illustrations, animations, brand styling).

---

**Q: Does the CLI generate tests?**
A: Yes, if you pass `--tests`. This generates unit tests for state management classes and repository stubs.

---

**Q: Can I contribute a new backend (e.g., Appwrite, Amplify)?**
A: Absolutely. See the [Contributing](#12-contributing) section. Adding a backend adapter is a self-contained change.

---

**Q: Will there be a GUI version?**
A: Not planned currently. The CLI is intentionally minimal and composable. A VS Code extension is being considered.

---

**Q: The CLI generated something wrong. What do I do?**
A: Delete the output directory, fix the issue or report it, and re-run. Since generation is fast, re-running is always the easiest recovery.

---

**Q: Can I publish my own fork to pub.dev?**
A: Yes, under a different package name. The project is MIT licensed.

---

## 15. Changelog

### v1.0.0 — Initial Release

**Added**
- `orbitalRapid init` command with full interactive prompts
- `orbitalRapid add <screen>` command
- `orbitalRapid upgrade` command
- State management support: Riverpod, BLoC, GetX
- Backend support: Firebase, REST API, Supabase, None
- Screens: Splash, Onboarding, Login, Register, Forgot Password, Account Deletion
- Design system generation: colors, fonts, text styles, dimensions, strings, gradients
- Dark mode support
- Localization scaffolding
- `orbitalRapid.yaml` config file support
- `--dry-run` flag
- Atomic file writing (all or nothing)
- pubspec.yaml auto-injection
- GitHub Actions CI/CD pipeline

---

*Orbital Rapid CLI is maintained by the open source community. Contributions welcome.*

*Documentation issues? [Open a PR](https://github.com/YOUR_USERNAME/orbital_rapid_cli/pulls) — docs live in the repo.*