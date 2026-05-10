# Contributing to Orbital Rapid CLI

Thank you for your interest in contributing! This document explains how to get involved.

## Code of Conduct

Be respectful, inclusive, and constructive. We follow the [Contributor Covenant](https://www.contributor-covenant.org/).

## How to Contribute

### Reporting Bugs

Use the [Bug Report template](https://github.com/bonyyamin/orbital_rapid_cli/issues/new?template=bug_report.md).

Include:
- CLI version (`orbitalRapid --version`)
- Operating system and version
- Dart SDK version (`dart --version`)
- Exact command that failed
- Full error output
- Expected vs actual behavior

### Requesting Features

Use [GitHub Discussions](https://github.com/bonyyamin/orbital_rapid_cli/discussions/new).

Describe:
- The problem you're solving
- Your proposed solution
- Alternatives you considered

### Submitting Code

1. Fork the repository
2. Create a branch: `git checkout -b feat/my-feature` or `fix/my-bug`
3. Make your changes
4. Add/update tests
5. Run `dart analyze` and `dart test` — both must pass
6. Update `CHANGELOG.md` under `Unreleased`
7. Submit a pull request

### Branch Naming

| Type | Pattern | Example |
|---|---|---|
| Feature | `feat/description` | `feat/appwrite-backend` |
| Bug fix | `fix/description` | `fix/bloc-template-null-error` |
| Documentation | `docs/description` | `docs/firebase-setup-guide` |
| Test | `test/description` | `test/login-generator-coverage` |
| Refactor | `refactor/description` | `refactor/template-engine` |

### Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add Appwrite backend adapter
fix: null reference in BLoC login template
docs: add Supabase setup steps
test: add splash generator unit tests
chore: bump dependencies
```

## Development Setup

```bash
git clone https://github.com/bonyyamin/orbital_rapid_cli.git
cd orbital_rapid_cli
dart pub get
dart test
dart pub global activate --source path .
orbitalRapid --version
```

## Project Structure

```
orbital_rapid_cli/
├── bin/orbital_rapid.dart          # Entry point
├── lib/src/
│   ├── commands/                  # CLI command classes
│   ├── generators/                # Screen generator classes
│   ├── templates/                 # .tmpl template files
│   ├── adapters/                  # State manager & backend adapters
│   ├── models/                    # Data models (FlowConfig, etc.)
│   └── utils/                     # File writer, pubspec injector, etc.
└── test/
    ├── unit/
    └── integration/
```

## Adding a New Screen

1. Add to `Screen` enum in `lib/src/models/enums.dart`
2. Add prompt option in `lib/src/utils/prompt.dart`
3. Create generator: `lib/src/generators/my_screen_generator.dart`
4. Create templates: `lib/src/templates/my_screen/{riverpod,bloc,getx}/`
5. Register in `GeneratorOrchestrator._resolveGenerators()`
6. Add unit tests in `test/unit/generators/my_screen_generator_test.dart`
7. Add golden output files in `test/golden/`

## Adding a New Backend

1. Add to `Backend` enum
2. Create: `lib/src/adapters/backends/my_backend_adapter.dart`
3. Create auth repository template: `templates/auth/repositories/my_backend_auth_repository.dart.tmpl`
4. Add to prompt options
5. Add to `GeneratorOrchestrator` backend resolution
6. Add tests

## Template Guidelines

- Use `{{variableName}}` for simple variable substitution
- Use `{{#flag}}...{{/flag}}` for conditional blocks
- Use `{{^flag}}...{{/flag}}` for inverted conditions
- Never hardcode colors, sizes, strings, or font names
- Always use token references: `AppColors.primary`, `AppDimensions.md`, etc.
- Keep templates readable — they are the user's reference for best practices

## Testing Requirements

All PRs must include tests:

| Change | Required Tests |
|---|---|
| New generator | Unit test + golden file |
| New backend adapter | Unit test for dependency list and template path |
| Bug fix | Regression test |
| New CLI command | Integration test |

Run tests:
```bash
dart test                          # all tests
dart test test/unit/               # unit only
dart test test/integration/        # integration only
```

## Questions?

Open a [Discussion](https://github.com/bonyyamin/orbital_rapid_cli/discussions) — we're happy to help.
