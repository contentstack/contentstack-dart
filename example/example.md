# Contentstack Examples

## Developer's Guide

In order to integrate your Flutter app with Contentstack Dart SDK, follow the steps mentioned below.

### Prerequisites

To get started with Dart SDK, you will need the following:

- [Android Studio](https://developer.android.com/studio/install.html)
- [Visual Studio Code](https://code.visualstudio.com/download)
- [Install the Dart SDK](https://dart.dev/get-dart#install)

### Creating new project using android studio

1. In the IDE, click Create New Project from the Welcome window or File > New > Project from the main IDE window.
2. Select Flutter in the menu, and click Next.
3. Enter your desired Project name and Project location.
4. If you might publish this app, set the company domain.
5. Click Finish.

### Creating new project using Visual Studio Code

1. Open the Command Palette (Ctrl+Shift+P (Cmd+Shift+P on macOS)).
2. Select the Flutter: New Project command and press Enter.
3. Enter your desired Project name.
4. Select a Project location.

### SDK Installation and Setup

To integrate your Flutter project with Contentstack, install the pub dependency Use this package as a library

Add this to your package's pubspec.yaml file:

```dart
dependencies:
  contentstack: latest
```

You can install packages from the command line:
with Flutter:

```dart
flutter pub get
```

### Import package

Now in your dart or flutter code, you can use

    ```

    import 'package:contentstack/contentstack.dart' as contentstack;
    ```

### Initialize SDK

To initialize the SDK, specify application context, stack’s API Key, delivery token, and name of the environment where will publish your content, as shown in the snippet below:

```dart
import 'package:contentstack/contentstack.dart' as contentstack;
final stack = contentstack.Stack("apiKey", "deliveryToken", "environment");
```

## Initialize by configuration

```dart
import 'package:contentstack/contentstack.dart' as contentstack;
final stack = contentstack.Stack("apiKey", "deliveryToken", "environment", host: 'your_host', branch: 'development');
```

## Basic Queries

To retrieve a single entry from a content type use the code snippet given below:

### Make call to get single entry by entry uid

```dart
final stack = contentstack.Stack('apiKey', 'deliveryToken', 'environment');
final entry = stack.contentType('content_type_uid').entry(entryUid: 'entry_uid');
await entry.fetch().then((response) {
    print(response.toString());
}).catchError((error) {
    print(error.message.toString());
});
```

Or, You can get generic objects as well

```dart
final stack = contentstack.Stack('apiKey', 'deliveryToken', 'environment');
final entry = stack.contentType('content_type_uid').entry(entryUid: 'entry_uid');
await entry.fetch<EntryModel, Null>().then((response) {
    print(response.title);
}).catchError((error) {
    print(error.message.toString());
});

```

### Get Multiple Entries

To retrieve multiple entries of a particular content type, use the code snippet given below:

```dart
  final stack = contentstack.Stack('apiKey', 'deliveryToken', 'environment');
  final query = stack.contentType('content_type_uid').entry().query();
  await query.find().then((response) {
      print(response.toString());
  }).catchError((error) {
     print(error.message.toString());
});
```

Or, You can get List of generic objects

```dart
final stack = contentstack.Stack('apiKey', 'deliveryToken', 'environment');
final query = stack.contentType('content_type_uid').entry().query();
await query.find<List<EntryModel>, EntryModel>().then((response) {
    print(response.toString());
}).catchError((error) {
    print(error.message.toString());
});
```

### Make call to get single asset by asset uid

```dart
final stack = contentstack.Stack('apiKey', 'deliveryToken', 'environment');
  await stack.asset('asset_uid').fetch().then((response) {
      print(response.toString());
  }).catchError((error) {
      print(error.message.toString());
  });
```

Or, You can get generic objects as well

```dart
final stack = contentstack.Stack('apiKey', 'deliveryToken', 'environment');
  await stack.asset('asset_uid').fetch<AssetModel, Null>().then((response) {
      print(response.toString());
  }).catchError((error) {
      print(error.message.toString());
  });
```

### Make call to apply query on asset

```dart
final stack = contentstack.Stack('apiKey', 'deliveryToken', 'environment');
final assetQuery = stack.assetQuery();
assetQuery..includeDimension()..relativeUrls();
  await assetQuery.find().then((response) {
      print(response.toString());
  }).catchError((error) {
      print(error.message.toString());
  });
```

Or, You can get List of generic objects

```dart
final stack = contentstack.Stack('apiKey', 'deliveryToken', 'environment');
final assetQuery = stack.assetQuery();
assetQuery..includeDimension()..relativeUrls();
await assetQuery.find<List<AssetModel>, Null>().then((response) {
    print(response.toString());
  }).catchError((error) {
    print(error.message.toString());
  });
```
