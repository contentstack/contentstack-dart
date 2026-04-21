---
name: code-review
description: Use when preparing a pull request or reviewing changes for this SDK repository.
---
# Code review – Contentstack Dart SDK

## When to use

- Before requesting review or approving a PR
- When triaging risk (API breaks, security, test gaps)

## Instructions

### Checklist

- **Behavior:** Change matches CDA semantics; no accidental Management API assumptions
- **API:** Public exports updated deliberately in `lib/contentstack.dart`; breaking changes documented and versioned
- **Quality:** `dart analyze` clean; `dart test` passes; codegen committed if `*.g.dart` changed
- **Security:** No API keys, tokens, or `.env` with secrets in the diff
- **Style:** Matches `analysis_options.yaml` and project patterns ([../dart-style/SKILL.md](../dart-style/SKILL.md))

### Severity (optional)

- **Blocker:** Breaks consumers, leaks credentials, or ships broken analyze/tests
- **Major:** Incorrect API usage, missing tests for risky logic, undocumented breaking change
- **Minor:** Naming, small refactors, doc nits

### Process

- Respect branch rules in [.github/workflows/check-branch.yml](../../.github/workflows/check-branch.yml) for target branches

## References

- [../dev-workflow/SKILL.md](../dev-workflow/SKILL.md)
- [../testing/SKILL.md](../testing/SKILL.md)
- [AGENTS.md](../../AGENTS.md)
