---
name: testing
description: Use for test layout, running tests, coverage, fixtures, and credential handling in this repo.
---
# Testing – Contentstack Dart SDK

## When to use

- Adding or changing tests under `test/`
- Running the suite locally or generating coverage
- Dealing with API keys and environment variables for integration-style tests

## Instructions

### Layout and runner

- Tests live in `test/` (e.g. `stack_test.dart`, `query_test.dart`, `entry_test.dart`)
- Run all: `dart test`
- Optional coverage workflow and LCOV steps are documented in [`test/run_test.sh`](../../test/run_test.sh) (`dart test --coverage=./coverage`, `coverage:format_coverage`, etc.)

### Credentials policy

- Tests such as [`test/stack_test.dart`](../../test/stack_test.dart) load credentials via `dotenv` (`apiKey`, `deliveryToken`, `environment`, optional `host`)
- **Do not commit secrets**—use local `.env` or CI secrets only as your team documents; never paste real tokens into the repo or PR descriptions

### Scope

- Prefer unit tests for pure logic; use guarded integration tests only when stack credentials are available
- After codegen changes, ensure tests still pass and coverage excludes generated files if you use the scripts in `test/run_test.sh`

## References

- [../dev-workflow/SKILL.md](../dev-workflow/SKILL.md) — `dart test` in CI workflow
- [../contentstack-dart-sdk/SKILL.md](../contentstack-dart-sdk/SKILL.md) — behavior under test
- [package:test](https://pub.dev/packages/test)
