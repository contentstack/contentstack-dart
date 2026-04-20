# Contentstack Dart SDK – Agent guide

*Universal entry point* for contributors and AI agents. Detailed conventions live in **skills/*/SKILL.md**.

## What this repo is

| Field | Detail |
| --- | --- |
| *Name:* | [contentstack/contentstack-dart](https://github.com/contentstack/contentstack-dart) |
| *Purpose:* | Official Dart package for Contentstack’s **Content Delivery API (CDA)**—fetch and query published content (entries, assets, content types), live preview, sync, and image transforms. |
| *Out of scope (if any):* | Not the Management API, not a Flutter UI kit, and not a standalone HTTP server—this is a client library built on the `http` package. |

## Tech stack (at a glance)

| Area | Details |
| --- | --- |
| Language | Dart SDK `>=2.12.0 <4.0.0` (`environment` in `pubspec.yaml`) |
| Build | `dart pub get`; JSON models use `json_serializable`—regenerate with `dart run build_runner build --delete-conflicting-outputs` when `*.dart` parts change (`pubspec.yaml`, `analysis_options.yaml` excludes `*.g.dart`) |
| Tests | `package:test`; tests under `test/*.dart` (see `test/run_test.sh` for optional coverage steps) |
| Lint / coverage | Analyzer + linter rules in `analysis_options.yaml` (`flutter_lints`-aligned custom rule set); coverage via `dart test --coverage=./coverage` and tooling described in `test/run_test.sh` |
| Other | Runtime deps: `http`, `json_annotation`, `logger`, `path`, `dotenv`, `file`; API docs generated with `dartdoc` (dev dependency) |

## Commands (quick reference)

| Command Type | Command |
| --- | --- |
| Build | `dart pub get` |
| Codegen (when models / `part` files change) | `dart run build_runner build --delete-conflicting-outputs` |
| Test | `dart test` |
| Lint | `dart analyze` |
| Format (optional) | `dart format .` |

**CI / automation:** workflows under [.github/workflows/](.github/workflows/) (e.g. branch checks, publish to pub.dev on version tags, policy scan, Jira integration).

## Where the documentation lives: skills

| Skill | Path | What it covers |
| --- | --- | --- |
| Dev workflow | [skills/dev-workflow/SKILL.md](skills/dev-workflow/SKILL.md) | Branches, PR expectations, local commands, optional codegen |
| Contentstack Dart SDK (API) | [skills/contentstack-dart-sdk/SKILL.md](skills/contentstack-dart-sdk/SKILL.md) | Public surface, `Stack`/queries, errors, integration boundaries |
| Dart style & layout | [skills/dart-style/SKILL.md](skills/dart-style/SKILL.md) | Package layout, imports, analyzer conventions |
| Testing | [skills/testing/SKILL.md](skills/testing/SKILL.md) | Test layout, env/credentials, coverage notes |
| Code review | [skills/code-review/SKILL.md](skills/code-review/SKILL.md) | PR checklist and severity hints |
| Runtime & HTTP | [skills/runtime-and-http/SKILL.md](skills/runtime-and-http/SKILL.md) | HTTP client usage, env config, logging, packaging |

An index with “when to use” hints is in [skills/README.md](skills/README.md).

## Using Cursor (optional)

If you use *Cursor*, [.cursor/rules/README.md](.cursor/rules/README.md) only points to *AGENTS.md*—same docs as everyone else.
