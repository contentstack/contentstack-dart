---
name: dev-workflow
description: Use for branches, CI, local build/test/lint, codegen, and PR workflow for this repo.
---
# Dev workflow – Contentstack Dart SDK

## When to use

- Starting work in this repository or onboarding
- Before opening a PR (verify analyze, tests, format)
- After editing JSON-serializable models or `part` files

## Instructions

### Dependencies and codegen

- Install deps: `dart pub get`
- If you change files that use `json_serializable` / `part '*.g.dart'`, run:  
  `dart run build_runner build --delete-conflicting-outputs`  
  Generated files are excluded from manual lint in `analysis_options.yaml`

### Quality gates

- Static analysis: `dart analyze` (rules in `analysis_options.yaml`)
- Tests: `dart test`
- Optional format check: `dart format .`

### Branches and automation

- Pull requests run [.github/workflows/check-branch.yml](../../.github/workflows/check-branch.yml) (e.g. restrictions when targeting `master`)
- Publishing: [.github/workflows/publish.yml](../../.github/workflows/publish.yml) on semver tags; dry-run uses `dart pub publish --dry-run`

### Package docs

- HTML API docs: `dartdoc` is listed in `pubspec.yaml`; generate when documenting public API changes

## References

- [../contentstack-dart-sdk/SKILL.md](../contentstack-dart-sdk/SKILL.md) — API surface
- [../testing/SKILL.md](../testing/SKILL.md) — tests and coverage
- [../dart-style/SKILL.md](../dart-style/SKILL.md) — layout and analyzer
- [Dart SDK environment](https://dart.dev/tools/pub/pubspec#sdk)
