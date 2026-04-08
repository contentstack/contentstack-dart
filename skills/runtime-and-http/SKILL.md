---
name: runtime-and-http
description: Use for HTTP client usage, env configuration, logging, retries, and dependency packaging for this SDK.
---
# Runtime & HTTP – Contentstack Dart SDK

## When to use

- Changing how requests are built or executed
- Working with `http`, headers, hosts/regions, or error mapping from responses
- Adjusting runtime dependencies (`pubspec.yaml`) or environment loading (`dotenv`)

## Instructions

### HTTP stack

- HTTP calls use the [`http`](https://pub.dev/packages/http) package—keep usage consistent with Dart async/await patterns elsewhere in `lib/src/`
- Do not introduce an alternate HTTP client for the same code paths without team agreement

### Configuration

- `dotenv` is used in tests and may be used for local/dev configuration—never commit real credentials ([../testing/SKILL.md](../testing/SKILL.md))
- `path` and `file` support path handling where needed; keep imports minimal

### Logging

- `logger` is a dependency; avoid logging sensitive tokens or full auth headers

### Packaging

- Keep `pubspec.yaml` constraints coherent with Dart SDK bounds (`>=2.12.0 <4.0.0`)
- Publishing flow: see [.github/workflows/publish.yml](../../.github/workflows/publish.yml)

### Retries and resilience

- If adding retries, backoff, or timeouts, document behavior in public API or internal modules and add tests where feasible

## References

- [../contentstack-dart-sdk/SKILL.md](../contentstack-dart-sdk/SKILL.md)
- [http package](https://pub.dev/packages/http)
- [../dev-workflow/SKILL.md](../dev-workflow/SKILL.md)
