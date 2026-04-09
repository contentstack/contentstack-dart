# Deprecation notice: Contentstack Dart SDK (pub.dev)

This page is for **developers using the Contentstack Dart SDK** published on **pub.dev** as [`contentstack`](https://pub.dev/packages/contentstack).

## What this means for you

**We are deprecating this SDK as the recommended path for new Dart and Flutter work.** If you are **starting a new project**, use our **[Content Delivery API (CDA)](https://www.contentstack.com/docs/developers/apis/content-delivery-api/)** directly with your preferred HTTP client (for example `package:http` or your app’s existing networking stack).

**If you already ship an app** that depends on `contentstack`, you can **keep using it**. Your integration continues to work. Plan a move to direct CDA usage when it fits your release schedule—you do not have to change immediately.

## What to use for new projects

| | Link |
|---|------|
| **Content Delivery API** | [Content Delivery API documentation](https://www.contentstack.com/docs/developers/apis/content-delivery-api/) |

## Why we are making this change

We are focusing investment on **direct API usage** and **documented integration patterns** for Dart and Flutter. This repository will remain in **maintenance**: we may address critical or security issues where we can, but **we do not plan new features** in the Dart SDK.

## Support for this SDK going forward

This repository will stay in **maintenance** as described above. Feature work and new capabilities should be built against the **Content Delivery API** and your application code.

If you need help choosing a migration path or timing, contact **[Contentstack support](https://www.contentstack.com/)** or your account team.
