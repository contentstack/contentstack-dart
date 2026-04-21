---
name: dart-style
description: Use for package layout, imports, naming, and analyzer/linter alignment in this Dart repo.
---
# Dart style & layout – Contentstack Dart SDK

## When to use

- Adding new files under `lib/` or `test/`
- Fixing analyzer or lint findings
- Choosing import style (`package:` vs relative) consistent with this repo

## Instructions

### Layout

- Public API: `lib/contentstack.dart` and `lib/src/`
- Tests: `test/*.dart` alongside optional scripts like `test/run_test.sh`
- Analyzer config: root [`analysis_options.yaml`](../../analysis_options.yaml)

### Conventions reflected in `analysis_options.yaml`

- Prefer `package:` imports for public code; `avoid_relative_lib_imports` is enabled
- `directives_ordering`, `package_api_docs` (document public APIs), `always_declare_return_types`, strong null-safety practices
- Generated `*.g.dart` files are excluded from analysis—do not hand-edit them

### Naming

- Follow `file_names`, `camel_case_types`, `non_constant_identifier_names` as enforced by the configured lints

## References

- [../dev-workflow/SKILL.md](../dev-workflow/SKILL.md) — `dart analyze` / format
- [Effective Dart](https://dart.dev/effective-dart)
- [Analyzer options](https://dart.dev/tools/analysis)
