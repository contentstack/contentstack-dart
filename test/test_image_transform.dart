import 'package:contentstack/src/image_transform.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';
import 'package:contentstack/contentstack.dart' as contentstack;

void main() {
  group('String', () {

    final Logger log = Logger('ImageTransformation testcases');
    const apiKey = 'blteae40eb499811073';
    const deliveryToken = 'bltc5064f36b5855343';
    const environment = 'development';
    const imageUrl = "https://images.contentstack.io/v3/assets/blteae40eb499811073/bltc5064f36b5855343/59e0c41ac0eddd140d5a8e3e/download";

    test('initialise ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.auto(auto: 'webp').fetch();
      expect('actual', response);
    });

    test('auto in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.auto(auto: 'webp').fetch();
      expect('actual', response);
    });

    test('formate in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.auto(format: 'pjpg').fetch();
      expect('actual', response);
    });

    test('auto and formate in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response =
          await imageTransformation.auto(auto: 'webp', format: 'pjpg').fetch();
      expect('actual', response);
    });

    test('quality in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.quality(2).fetch();
      expect('actual', response);
    });

    test('convert to gif in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.convert(Format.gif).fetch();
      expect('actual', response);
    });

    test('convert to png in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.convert(Format.png).fetch();
      expect('actual', response);
    });

    test('convert to jpeg in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.convert(Format.pjpg).fetch();
      expect('actual', response);
    });

    test('width resize image in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.resize(width: 100).fetch();
      expect('actual', response);
    });

    test('height resize image in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.resize(height: 100).fetch();
      expect('actual', response);
    });

    test('width and height resize image in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.resize(width: 100, height: 100).fetch();
      expect('actual', response);
    });

    test('disable resize image in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.resize(width: 100, disable: true ).fetch();
      expect('actual', response);
    });

    test('crop by width and height in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.cropBy(width: 150, height: 100).fetch();
      expect('actual', response);
    });

    test('crop with aspect ratio in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.cropBy(width: 150, height: 100, cropValue: '1:3').fetch();
      expect('actual', response);
    });

    test('crop subregion  in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.cropBy( cropValue: "50,75,x0.10,y0.20").fetch();
      expect('actual', response);
    });

    test('Crop in fail-safe mode  in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.cropBy( cropValue: "300,400,x50,y50,safe").fetch();
      expect('actual', response);
    });

    test('Smart Crop  in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.cropBy( width: 300, height: 400, cropValue: "2:5,smart").fetch();
      expect('actual', response);
    });

    test('Fit To Bound  in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.fitBy(250,  250, Fit.bounds).fetch();
      expect('actual', response);
    });

    test('Fit By Cropping  in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.fitBy(  250,  250, Fit.crop).fetch();
      expect('actual', response);
    });

    test('trim  in ImageTransformation with all params', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.trim(25,50,75,100).fetch();
      expect('actual', response);
    });

    test('trim  in ImageTransformation with 3 params', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.trim(25,50,75).fetch();
      expect('actual', response);
    });

    test('trim  in ImageTransformation with 2 params', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.trim(25,50).fetch();
      expect('actual', response);
    });

    test('trim  in ImageTransformation with 1 params', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.trim(25).fetch();
      expect('actual', response);
    });

    test('orientation  in ImageTransformation check params', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.orientation(Orientation.vertically).fetch();
      expect('actual', response);
    });

    test('overlay  overlayAlign in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.overlay('overlayUrl', overlayAlign: '').fetch();
      expect('actual', response);
    });

    test('overlay  overlayHeight in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.overlay('overlayUrl', overlayHeight: '').fetch();
      expect('actual', response);
    });

    test('overlay  overlayRepeat in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.overlay('overlayUrl', overlayRepeat: '').fetch();
      expect('actual', response);
    });

    test('overlay  overlayWidth in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.overlay('overlayUrl', overlayWidth: '').fetch();
      expect('actual', response);
    });

    test('padding   in ImageTransformation result of Padding', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.overlay('overlayUrl', overlayWidth: '').fetch();
      expect('actual', response);
    });

    test('bg-color  in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.bgColor('bgColor').fetch();
      expect('actual', response);
    });

    test('dpr  in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.dpr(20, 30, 4).fetch();
      expect('actual', response);
    });


    test('blur  in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.blur( 4).fetch();
      expect('actual', response);
    });

    test('frame  in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.frame( 4).fetch();
      expect('actual', response);
    });

    test('increase sharpen  in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.increaseSharpen('sharpen').fetch();
      expect('actual', response);
    });

    test('saturation  in ImageTransformation', () async {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.saturation(20).fetch();
      expect('actual', response);
    });



  });
}
