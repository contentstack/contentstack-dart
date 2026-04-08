---
name: contentstack-dart-sdk
description: Use when changing the public API, Stack, queries, CDA calls, errors, or SDK boundaries.
---
# Contentstack Dart SDK (API) – Contentstack Dart SDK

## When to use

- Adding or changing exported types in `lib/contentstack.dart`
- Working on `Stack`, content types, entries, queries, assets, image transforms, sync, or live preview
- Defining or handling SDK errors and response models

## Instructions

### Entry points

- Main library: [`lib/contentstack.dart`](../../lib/contentstack.dart) re-exports `src/` modules—prefer exporting new public types from there
- Core client: [`lib/src/stack.dart`](../../lib/src/stack.dart) and related `entry.dart`, `query.dart`, `contenttype.dart`, `asset.dart`, `image_transform.dart`

### API boundaries

- This package targets **Content Delivery API** usage (read/query published content), not Management API operations
- HTTP is performed via the `http` package; see [../runtime-and-http/SKILL.md](../runtime-and-http/SKILL.md)

### Models and errors

- JSON models use `json_annotation` + generated `*.g.dart` parts—regenerate after schema changes (see [../dev-workflow/SKILL.md](../dev-workflow/SKILL.md))
- Errors live under [`lib/src/error/`](../../lib/src/error/); keep messages and types consistent with CDA behavior

### Versioning

- Package version and changelog: follow semver in `pubspec.yaml` and `CHANGELOG.md` when releasing

## References

- [Content Delivery API](https://www.contentstack.com/docs/developers/apis/content-delivery-api/)
- [../dart-style/SKILL.md](../dart-style/SKILL.md) — imports and docs
- [../testing/SKILL.md](../testing/SKILL.md) — integration-style tests
