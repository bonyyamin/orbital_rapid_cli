# Changelog

All notable changes to Orbital Rapid CLI will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.2+1] — 2026-05-10

### Fixed
- Updated `README.md` with correct PATH configuration instructions for Windows (PowerShell/CMD).

## [1.0.2] — 2026-05-10

### Added
- Welcome banner (ASCII art) to `init` command
- Global `--version` and `-v` flag support

### Fixed
- Version mismatch in `version` command (was hardcoded to v0.1.0)
- Documentation alignment for version checking

## [1.0.0] — 2026-05-07

### Added
- `orbitalrapid init` — full interactive project scaffolding
- `orbitalrapid add <screen>` — add individual screens to existing projects
- `orbitalrapid upgrade` — self-upgrade command
- `orbitalrapid --version` — version display
- State management: Riverpod, BLoC, GetX
- Backend: Firebase Auth, REST API (Dio), Supabase, None
- Screens: Splash, Onboarding, Login, Register, Forgot Password, Account Deletion
- Design system generation: AppColors, AppFonts, AppTextStyles, AppDimensions, AppStrings, AppGradients
- Dark mode support (`--dark-mode` flag)
- Localization scaffolding (`--l10n` flag)
- Test file generation (`--tests` flag)
- `orbitalrapid.yaml` config file support
- `--dry-run` preview mode
- Atomic file writing (all-or-nothing, no partial generation)
- `pubspec.yaml` auto-injection
- GitHub Actions CI/CD pipeline
- MIT License
- Full documentation and contributing guide
