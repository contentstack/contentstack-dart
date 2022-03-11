
# ![Contentstack](https://www.contentstack.com/docs/static/images/contentstack.png)

## Dart SDK for Contentstack

![version](https://img.shields.io/github/v/release/contentstack/contentstack-dart)
![Coverage](https://raw.githubusercontent.com/contentstack/contentstack-dart/ae680c33d9efe68938bde585f72b12cca442c7a7/coverage_badge.svg)
![Dart CI](https://github.com/contentstack/contentstack-dart/workflows/Dart%20CI/badge.svg)
![dartdoc](https://img.shields.io/badge/dartdoc-latest-<green>.svg)

![issues](https://img.shields.io/github/issues/contentstack/contentstack-dart)
![fork](https://img.shields.io/github/forks/contentstack/contentstack-dart)
![starts](https://img.shields.io/github/stars/contentstack/contentstack-dart)
![license](https://img.shields.io/github/license/contentstack/contentstack-dart)
![tweet](https://img.shields.io/twitter/url?url=https%3A%2F%2Fgithub.com%2Fcontentstack%2Fcontentstack-dart%2Ftree%2Fdevelopment)

Contentstack is a headless CMS with an API-first approach.
It is a CMS that developers can use to build powerful cross-platform applications
in their favorite languages. Build your application frontend, and Contentstack will
take care of the rest.
[Read More](https://www.contentstack.com/).

Contentstack provides `Dart SDK` to build application on top of Dart.
Given below is the detailed guide and helpful resources to get started with our Dart SDK.

### Prerequisite

You will need Dart installed on your machine.
You can install it from [here](https://dart.dev/get-dart).

### Setup and Installation

To use the Contentstack Dart SDK to your existing project, perform the `steps` given below:

### **Install Dart Package**

```Dart
dependencies:
  contentstack: any
```

### Key Concepts for using Contentstack

#### Stack

A stack is like a container that holds the content of your app.
Learn more about [Stacks](https://www.contentstack.com/docs/developers/set-up-stack/about-stack/).

#### Content Type

Content type lets you define the structure or blueprint of a page or a section of your digital property.
It is a form-like page that gives Content Managers an interface to input and upload content.
[Read more](https://www.contentstack.com/docs/developers/apis/content-delivery-api/#content-types).

#### Entry

An entry is the actual piece of content created using one of the defined content types.
Learn more about [Entries](https://www.contentstack.com/docs/developers/apis/content-delivery-api/#entries).

#### Asset

Assets refer to all the media files (images, videos, PDFs, audio files, and so on) uploaded to Contentstack.
These files can be used in multiple entries.
Read more about [Assets](https://www.contentstack.com/docs/developers/apis/content-delivery-api/#assets).

#### Environment

A publishing environment corresponds to one or more deployment servers or a content delivery
destination where the entries need to be published.
Learn how to work with [Environments](https://www.contentstack.com/docs/developers/set-up-environments/about-environments/).

### Contentstack Dart SDK: 5-minute Quickstart

#### __Initializing your SDK__

To initialize the SDK, specify application  API key, access token, and environment name of the stack
as shown in the snippet given below (config is optional):

```dart
import 'package:contentstack/contentstack.dart' as contentstack;

final stack = Contentstack.stack(apiKey, deliveryToken, environment);
```

To get the API credentials mentioned above, log in to your Contentstack account and then in your
top panel navigation, go to Settings & Stack to view the API Key and Access Token.

#### Querying content from your stack

To retrieve a single entry from a content type use the code snippet given below:

```dart
import 'package:contentstack/contentstack.dart' as contentstack;

final stack = contentstack.Stack(apiKey, deliveryToken, environment);
final entry = stack.contentType('contentTypeUid').entry(entryUid: 'entryUid');
    await entry.fetch().then((response) {
        print(response.toString());
    }).catchError((error) {
        print(error.message.toString());
    });
```

#### Get Multiple Entries

To retrieve multiple entries of a particular content type, use the code snippet given below:

```dart
import 'package:contentstack/contentstack.dart' as contentstack;

final stack = contentstack.Stack(apiKey, deliveryToken, environment);
final query = stack.contentType('contentTypeUid').entry().query();
await query.find().then((response) {
        print(response.toString());
    }).catchError((error) {
        print(error.message.toString());
    });
```

### Advanced Queries

You can query for content types, entries, assets and more using our dart API Reference.
[Dart API Reference Doc](https://www.contentstack.com/docs/platforms/dart/api-reference/)

### Working with Images

We have introduced Image Delivery APIs that let you retrieve images and then manipulate and optimize
them for your digital properties. It lets you perform a host of other actions such as crop, trim,
resize, rotate, overlay, and so on.

For example, if you want to crop an image (with width as 300 and height as 400), you simply need to
append query parameters at the end of the image URL,
such as, <https://images.contentstack.io/v3/assets/download?crop=300,400>.

There are several more parameters that you can use for your images.

[Read Image Delivery API documentation](https://www.contentstack.com/docs/developers/apis/image-delivery-api/).

You can use the Image Delivery API functions in this SDK as well. Here are a few examples of its usage in the SDK.

```dart
import 'package:contentstack/contentstack.dart' as contentstack;

final stack = contentstack.Stack(apiKey, deliveryToken, environment);
imageTransformation = stack.imageTransform(imageUrl);

##set the image quality to 100
imageParams = {'quality': 100}
final imageUrl = imageTransformation..canvas(imageParams)..getUrl();

##resize the image by specifying width and height
imageParams = {'width': 100, 'height': 100}
final response = imageTransformation..canvas(imageParams)..getUrl();

##enable auto optimization for the image
imageParams = {'auto': 'webp'}
final response = imageTransformation..canvas(imageParams)..getUrl();
```

### Helpful Links

- [Contentstack Website](https://www.contentstack.com)
- [Official Documentation](https://contentstack.com/docs)
- [Content Delivery API Docs](https://www.contentstack.com/docs/developers/apis/content-delivery-api/)

### The MIT License (MIT)

MIT License

Copyright (c) 2012 - 2021
[Contentstack](https://www.contentstack.com/). All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
