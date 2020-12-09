import 'package:logger/logger.dart';
import 'package:test/test.dart';

import 'package:contentstack/src/image/filter.dart';
import 'package:contentstack/src/image/fit.dart';
import 'package:contentstack/src/image/format.dart';
import 'package:contentstack/src/image/orientation.dart';
import 'package:contentstack/src/image_transform.dart';

import 'credentials.dart';

void main() {
  var logger = Logger(printer: PrettyPrinter());

  group('ImageTransformation functional testcases', () {
    const imageUrl =
        'https://images.contentstack.io/v3/assets/blteae40eb499811073/bltc5064f36b5855343/59e0c41ac0eddd140d5a8e3e/download';
    ImageTransformation imageTransformation;

    setUp(() {
      final stack = Credential.stack();
      imageTransformation = stack.imageTransform(imageUrl);
    });

    test('auto in ImageTransformation', () {
      final response = imageTransformation
        ..auto(auto: 'webp')
        ..getUrl();
      logger.i(response);
    });

    test('formate in ImageTransformation', () {
      final response = imageTransformation
        ..auto(format: 'pjpg')
        ..getUrl();
      expect('formate=pjpg', response.query.toString());
    });

    test('auto and formate in ImageTransformation', () {
      final response = imageTransformation
        ..auto(auto: 'webp', format: 'pjpg')
        ..getUrl();
      expect('auto=webp&formate=pjpg', response.query.toString());
    });

    test('quality in ImageTransformation', () {
      final response = imageTransformation
        ..quality(2)
        ..getUrl();
      expect('quality=2', response.query.toString());
    });

    test('convert to gif in ImageTransformation', () {
      final response = imageTransformation
        ..convert(Format.gif())
        ..getUrl();
      expect('format=gif', response.query.toString());
    });

    test('convert to png in ImageTransformation', () {
      final response = imageTransformation
        ..convert(Format.png())
        ..getUrl();
      expect('format=png', response.query.toString());
    });

    test('convert to jpeg in ImageTransformation', () {
      final response = imageTransformation
        ..convert(Format.pjpg())
        ..getUrl();
      expect('format=pjpg', response.query.toString());
    });

    test('convert to jpeg in ImageTransformation', () {
      final response = imageTransformation
        ..convert(Format.jpg())
        ..getUrl();
      expect('format=jpg', response.query.toString());
    });

    test('convert to jpeg in ImageTransformation', () {
      final response = imageTransformation
        ..convert(Format.webp())
        ..getUrl();
      expect('format=webp', response.query.toString());
    });

    test('convert to jpeg in ImageTransformation', () {
      final response = imageTransformation
        ..convert(Format.webplossy())
        ..getUrl();
      expect('format=webply', response.query.toString());
    });

    test('convert to jpeg in ImageTransformation', () {
      final response = imageTransformation
        ..convert(Format.webplossless())
        ..getUrl();
      expect('format=webpll', response.query.toString());
    });

    test('width resize image in ImageTransformation', () {
      final response = imageTransformation
        ..resize(width: 100)
        ..getUrl();
      expect('width=100', response.query.toString());
    });

    test('height resize image in ImageTransformation', () {
      final response = imageTransformation
        ..resize(height: 100)
        ..getUrl();
      expect('height=100', response.query.toString());
    });

    test('width and height resize image in ImageTransformation', () {
      final response = imageTransformation
        ..resize(width: 100, height: 100)
        ..getUrl();
      expect('width=100&height=100', response.query.toString());
    });

    test('disable resize image in ImageTransformation', () {
      final response = imageTransformation
        ..resize(width: 100, disable: true)
        ..getUrl();
      expect('width=100&disable=upscale', response.query.toString());
    });

    test('crop by width and height in ImageTransformation', () {
      final response = imageTransformation
        ..cropBy(150, 100)
        ..getUrl();
      expect('crop=150%2C+100', response.query.toString());
    });

    test('crop with aspect ratio in ImageTransformation', () {
      final response = imageTransformation
        ..crop('1:3')
        ..getUrl();
      expect('crop=1%3A3', response.query.toString());
    });

    test('crop subregion  in ImageTransformation', () {
      final response = imageTransformation
        ..crop('50,75,x0.10,y0.20')
        ..getUrl();
      expect('crop=50%2C75%2Cx0.10%2Cy0.20', response.query.toString());
    });

    test('Crop in fail-safe mode  in ImageTransformation', () {
      final response = imageTransformation
        ..crop('300,400,x50,y50,safe')
        ..getUrl();
      expect('crop=300%2C400%2Cx50%2Cy50%2Csafe', response.query.toString());
    });

    test('Smart Crop  in ImageTransformation', () {
      final response = imageTransformation
        ..crop('2:5,smart')
        ..getUrl();
      expect('crop=2%3A5%2Csmart', response.query.toString());
    });

    test('Fit To Bound  in ImageTransformation', () {
      final response = imageTransformation
        ..fit(0.50, 0.50, Fit.bounds())
        ..getUrl();
      expect('width=0.5&height=0.5&fit=bounds', response.query.toString());
    });

    test('Fit By Cropping  in ImageTransformation', () {
      final response = imageTransformation
        ..fit(0.50, 0.50, Fit.crop())
        ..getUrl();
      expect('width=0.5&height=0.5&fit=crop', response.query.toString());
    });

    test('trim  in ImageTransformation with all params', () {
      final response = imageTransformation
        ..trim(25, 50, 75, 100)
        ..getUrl();
      expect('trim=25%2C+25%2C+75%2C+100', response.query.toString());
    });

    test('trim  in ImageTransformation with 3 params', () {
      final response = imageTransformation
        ..trim(25, 50, 75)
        ..getUrl();
      expect('trim=25%2C+25%2C+75', response.query.toString());
    });

    test('trim  in ImageTransformation with 2 params', () {
      final response = imageTransformation
        ..trim(25, 50)
        ..getUrl();
      expect('trim=25%2C+25', response.query.toString());
    });

    test('trim  in ImageTransformation with 1 params', () {
      final response = imageTransformation
        ..trim(25)
        ..getUrl();
      expect('trim=25', response.query.toString());
    });

    test('orientation vertical in ImageTransformation check params', () {
      final response = imageTransformation
        ..orientation(Orientation.vertically())
        ..getUrl();
      expect('orient=4', response.query.toString());
    });

    test('orientation horizontal in ImageTransformation check params', () {
      final response = imageTransformation
        ..orientation(Orientation.horizontally())
        ..getUrl();
      expect('orient=2', response.query.toString());
    });

    test(
        'orientation degrees90TowardsRight in ImageTransformation check params',
        () {
      final response = imageTransformation
        ..orientation(Orientation.degrees90TowardsRight())
        ..getUrl();
      expect('orient=6', response.query.toString());
    });

    test('orientation horizontallyAndRotate90DegreeLeft', () {
      final response = imageTransformation
        ..orientation(Orientation.horizontallyAndRotate90DegreeLeft())
        ..getUrl();
      expect('orient=5', response.query.toString());
    });

    test('orientation horizontallyAndRotate90DegreesRight', () {
      final response = imageTransformation
        ..orientation(Orientation.horizontallyAndRotate90DegreesRight())
        ..getUrl();
      expect('orient=7', response.query.toString());
    });

    test('orientation horizontallyAndVertically', () {
      final response = imageTransformation
        ..orientation(Orientation.horizontallyAndVertically())
        ..getUrl();
      expect('orient=3', response.query.toString());
    });

    test('orientation toDefault in ImageTransformation check params', () {
      final response = imageTransformation
        ..orientation(Orientation.toDefault())
        ..getUrl();
      expect('orient=1', response.query.toString());
    });

    test('orientation rotate90DegreesLeft in ImageTransformation check params',
        () {
      final response = imageTransformation
        ..orientation(Orientation.rotate90DegreesLeft())
        ..getUrl();
      expect('orient=8', response.query.toString());
    });

    test('overlay  overlayAlign in ImageTransformation', () {
      final response = imageTransformation
        ..overlay(
            '/v3/assets/blteae40eb499811073/bltb21dacdd20d0e24c/59e0c401462a293417405f34/download',
            overlayAlign: 'left,bottom')
        ..getUrl();
      const String expectedResult =
          'overlay=%2Fv3%2Fassets%2Fblteae40eb499811073%2Fbltb21dacdd20d0e24c%2F59e0c401462a293417405f34%2Fdownload&overlay-align=left%2Cbottom';
      expect(expectedResult, response.query.toString());
    });

    test('overlay  overlayHeight in ImageTransformation', () {
      final response = imageTransformation
        ..overlay('overlayUrl', overlayHeight: 150)
        ..getUrl();
      expect(
          'overlay=overlayUrl&overlay-height=150', response.query.toString());
    });

    test('overlay  overlayRepeat in ImageTransformation', () {
      final response = imageTransformation
        ..overlay('overlayUrl', overlayRepeat: 'y')
        ..getUrl();
      expect('overlay=overlayUrl&overlay-repeat=y', response.query.toString());
    });

    test('overlay  overlayWidth in ImageTransformation', () {
      final response = imageTransformation
        ..overlay('overlayUrl', overlayWidth: 100)
        ..getUrl();
      expect('overlay=overlayUrl&overlay-width=100', response.query.toString());
    });

    test('padding   in ImageTransformation result of Padding', () {
      final response = imageTransformation
        ..padding('25,50,75,100')
        ..getUrl();
      expect('pad=25%2C50%2C75%2C100', response.query.toString());
    });

    test('overlay-padding  in ImageTransformation result of Padding', () {
      final response = imageTransformation
        ..overlayPadding('25,50,75,100')
        ..getUrl();
      expect('overlay-pad=25%2C50%2C75%2C100', response.query.toString());
    });

    test('bg-color  in ImageTransformation', () {
      final response = imageTransformation
        ..bgColor('cccccc')
        ..getUrl();
      expect('bg-color=cccccc', response.query.toString());
    });

    test('dpr  in ImageTransformation', () {
      final response = imageTransformation
        ..dpr(4)
        ..getUrl();
      expect('dpr=4', response.query.toString());
    });

    test('blur  in ImageTransformation', () {
      final response = imageTransformation
        ..blur(40)
        ..getUrl();
      expect('blur=40', response.query.toString());
    });

    test('frame  in ImageTransformation', () {
      final response = imageTransformation
        ..frame(1)
        ..getUrl();
      expect('frame=1', response.query.toString());
    });

    test('increase sharpen  in ImageTransformation', () {
      final response = imageTransformation
        ..sharpen(5, 1000, 2)
        ..getUrl();
      expect('sharpen=a5%2Cr1000%2Ct2', response.query.toString());
    });

    test('saturation  in ImageTransformation', () {
      final response = imageTransformation
        ..saturation(20)
        ..getUrl();
      expect('saturation=20', response.query.toString());
    });

    test('contrast  in ImageTransformation', () {
      final response = imageTransformation
        ..contrast(20)
        ..getUrl();
      expect('contrast=20', response.query.toString());
    });

    test('brightness  in ImageTransformation', () {
      final response = imageTransformation
        ..brightness(20)
        ..getUrl();
      expect('brightness=20', response.query.toString());
    });

    test('resize-filter  type nearest in ImageTransformation', () {
      final response = imageTransformation
        ..resizeFilter(width: 20, height: 40, filter: Filter.nearest())
        ..getUrl();
      expect('width=20&height=40&resize-filter=nearest',
          response.query.toString());
    });

    test('resize-filter  type Filter.bicubic in ImageTransformation', () {
      final response = imageTransformation
        ..resizeFilter(width: 20, height: 40, filter: Filter.bicubic())
        ..getUrl();
      expect('width=20&height=40&resize-filter=bicubic',
          response.query.toString());
    });

    test('resize-filter type Filter.bilinear  in ImageTransformation', () {
      final response = imageTransformation
        ..resizeFilter(width: 20, height: 40, filter: Filter.bilinear())
        ..getUrl();
      expect('width=20&height=40&resize-filter=bilinear',
          response.query.toString());
    });

    test('resize-filter  type lanczos in ImageTransformation', () {
      final response = imageTransformation
        ..resizeFilter(width: 20, height: 40, filter: Filter.lanczos())
        ..getUrl();
      expect('width=20&height=40&resize-filter=lanczos3',
          response.query.toString());
    });

    test('canvas by width and height in ImageTransformation', () {
      final response = imageTransformation
        ..canvas('700,800')
        ..getUrl();
      expect('canvas=700%2C800', response.query.toString());
    });

    test('canvas by ratio in ImageTransformation', () {
      final response = imageTransformation
        ..canvas('2:3')
        ..getUrl();
      expect('canvas=2%3A3', response.query.toString());
    });

    test('canvas by sub-region in ImageTransformation', () {
      final response = imageTransformation
        ..canvas('700,800,x0.50,y0.60')
        ..getUrl();
      expect('canvas=700%2C800%2Cx0.50%2Cy0.60', response.query.toString());
    });

    test('canvas by Offset in ImageTransformation', () {
      final response = imageTransformation
        ..canvas('700,800,offset-x0.65,offset-y0.80')
        ..getUrl();
      expect('canvas=700%2C800%2Coffset-x0.65%2Coffset-y0.80',
          response.query.toString());
    });

    test('canvas by Offset in ImageTransformation API Request', () async {
      imageTransformation.fit(200, 100, Fit.crop());
      await imageTransformation.fetch().then((response) {
        if (response['error_code'] == 200) {
          expect('80', response.query.toString());
        } else {
          expect(178, response['error_code']);
        }
      }).catchError((onError) {
        expect('Unexpected character', onError.message.toString());
      });
    });
  });
}
