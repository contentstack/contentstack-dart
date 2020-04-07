import 'package:contentstack/src/image_transform.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';
import 'package:contentstack/contentstack.dart' as contentstack;

void main() {
  group('ImageTransformation testcases', () {
    final Logger log = Logger('ImageTransformation testcases');
    const imageUrl =
        "https://images.contentstack.io/v3/assets/blteae40eb499811073/bltc5064f36b5855343/59e0c41ac0eddd140d5a8e3e/download";
    ImageTransformation imageTransformation;

    setUp(() {
      const apiKey = 'blteae40eb499811073';
      const deliveryToken = 'bltc5064f36b5855343';
      const environment = 'development';
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      imageTransformation = stack.imageTransform(imageUrl);
    });

    test('auto in ImageTransformation', () {
      final response = imageTransformation..auto(auto: 'webp')..getUrl();
      log.finest(response);
      //expect(true, response.contains('?auto=webp'));
    });

//     test('formate in ImageTransformation', () {
//       final response = imageTransformation.auto(format: 'pjpg').getUrl();
//       log.finest(response);
//       expect(true, response.contains('?formate=pjpg'));
//     });

//     test('auto and formate in ImageTransformation', () {
//       final response =
//           imageTransformation.auto(auto: 'webp', format: 'pjpg').getUrl();
//       log.finest(response);
//       final split = response.split('?');
//       expect('auto=webp&formate=pjpg', split[1]);
//       expect(true, response.contains('?auto=webp&formate=pjpg'));
//     });

//     test('quality in ImageTransformation', () {
//       final response = imageTransformation.quality(2).getUrl();
//       final split = response.split('?');
//       expect('quality=2', split[1]);
//     });

//     test('convert to gif in ImageTransformation', () {
//       final response = imageTransformation.convert(Format.gif).getUrl();
//       final split = response.split('?');
//       expect('format=gif', split[1]);
//     });

//     test('convert to png in ImageTransformation', () {
//       final response = imageTransformation.convert(Format.png).getUrl();
//       final split = response.split('?');
//       expect('format=png', split[1]);
//     });

//     test('convert to jpeg in ImageTransformation', () {
//       final response = imageTransformation.convert(Format.pjpg).getUrl();
//       final split = response.split('?');
//       expect('format=pjpg', split[1]);
//     });

//     test('width resize image in ImageTransformation', () {
//       final response = imageTransformation.resize(width: 100).getUrl();
//       final split = response.split('?');
//       expect('width=100', split[1]);
//     });

//     test('height resize image in ImageTransformation', () {
//       final response = imageTransformation.resize(height: 100).getUrl();
//       final split = response.split('?');
//       expect('height=100', split[1]);
//     });

//     test('width and height resize image in ImageTransformation', () {
//       final response =
//           imageTransformation.resize(width: 100, height: 100).getUrl();
//       final split = response.split('?');
//       expect('width=100&height=100', split[1]);
//     });

//     test('disable resize image in ImageTransformation', () {
//       final response =
//           imageTransformation.resize(width: 100, disable: true).getUrl();
//       final split = response.split('?');
//       expect('width=100&disable=upscale', split[1]);
//     });

//     test('crop by width and height in ImageTransformation', () {
//       final response = imageTransformation.cropBy(150, 100).getUrl();
//       final split = response.split('?');
//       expect('crop=150%2C+100', split[1]);
//     });

//     test('crop with aspect ratio in ImageTransformation', () {
//       final response = imageTransformation.crop('1:3').getUrl();
//       final split = response.split('?');
//       expect('crop=1%3A3', split[1]);
//     });

//     test('crop subregion  in ImageTransformation', () {
//       final response = imageTransformation.crop("50,75,x0.10,y0.20").getUrl();
//       final split = response.split('?');
//       expect('crop=50%2C75%2Cx0.10%2Cy0.20', split[1]);
//     });

//     test('Crop in fail-safe mode  in ImageTransformation', () {
//       final response =
//           imageTransformation.crop("300,400,x50,y50,safe").getUrl();
//       final split = response.split('?');
//       expect('crop=300%2C400%2Cx50%2Cy50%2Csafe', split[1]);
//     });

//     test('Smart Crop  in ImageTransformation', () {
//       final response = imageTransformation.crop("2:5,smart").getUrl();
//       final split = response.split('?');
//       expect('crop=2%3A5%2Csmart', split[1]);
//     });

//     test('Fit To Bound  in ImageTransformation', () {
//       final response = imageTransformation.fit(0.50, 0.50, Fit.bounds).getUrl();
//       final split = response.split('?');
//       expect('width=0.5&height=0.5&fit=bounds', split[1]);
//     });

//     test('Fit By Cropping  in ImageTransformation', () {
//       final response = imageTransformation.fit(0.50, 0.50, Fit.crop).getUrl();
//       final split = response.split('?');
//       expect('width=0.5&height=0.5&fit=crop', split[1]);
//     });

//     test('trim  in ImageTransformation with all params', () {
//       final response = imageTransformation.trim(25, 50, 75, 100).getUrl();
//       final split = response.split('?');
//       expect('trim=25%2C+25%2C+75%2C+100', split[1]);
//     });

//     test('trim  in ImageTransformation with 3 params', () {
//       final response = imageTransformation.trim(25, 50, 75).getUrl();
//       final split = response.split('?');
//       expect('trim=25%2C+25%2C+75', split[1]);
//     });

//     test('trim  in ImageTransformation with 2 params', () {
//       final response = imageTransformation.trim(25, 50).getUrl();
//       final split = response.split('?');
//       expect('trim=25%2C+25', split[1]);
//     });

//     test('trim  in ImageTransformation with 1 params', () {
//       final response = imageTransformation.trim(25).getUrl();
//       final split = response.split('?');
//       expect('trim=25', split[1]);
//     });

//     test('orientation  in ImageTransformation check params', () {
//       final response =
//           imageTransformation.orientation(Orientation.vertically).getUrl();
//       final split = response.split('?');
//       expect('orient=4', split[1]);
//     });

//     test('overlay  overlayAlign in ImageTransformation', () {
//       final response = imageTransformation
//           .overlay(
//               '/v3/assets/blteae40eb499811073/bltb21dacdd20d0e24c/59e0c401462a293417405f34/download',
//               overlayAlign: 'left,bottom')
//           .getUrl();
//       final split = response.split('?');
//       const String expectedResult =
//           "overlay=%2Fv3%2Fassets%2Fblteae40eb499811073%2Fbltb21dacdd20d0e24c%2F59e0c401462a293417405f34%2Fdownload&overlay-align=left%2Cbottom";
//       expect(expectedResult, split[1]);
//     });

//     test('overlay  overlayHeight in ImageTransformation', () {
//       final response = imageTransformation
//           .overlay('overlayUrl', overlayHeight: 150)
//           .getUrl();
//       final split = response.split('?');
//       expect('overlay=overlayUrl&overlay-height=150', split[1]);
//     });

//     test('overlay  overlayRepeat in ImageTransformation', () {
//       final response = imageTransformation
//           .overlay('overlayUrl', overlayRepeat: 'y')
//           .getUrl();
//       final split = response.split('?');
//       expect('overlay=overlayUrl&overlay-repeat=y', split[1]);
//     });

//     test('overlay  overlayWidth in ImageTransformation', () {
//       final response =
//           imageTransformation.overlay('overlayUrl', overlayWidth: 100).getUrl();
//       final split = response.split('?');
//       expect('overlay=overlayUrl&overlay-width=100', split[1]);
//     });

//     test('padding   in ImageTransformation result of Padding', () {
//       final response = imageTransformation.padding("25,50,75,100").getUrl();
//       final split = response.split('?');
//       expect('pad=25%2C50%2C75%2C100', split[1]);
//     });

//     test('overlay-padding  in ImageTransformation result of Padding', () {
//       final response =
//           imageTransformation.overlayPadding("25,50,75,100").getUrl();
//       final split = response.split('?');
//       expect('overlay-pad=25%2C50%2C75%2C100', split[1]);
//     });

//     test('bg-color  in ImageTransformation', () {
//       final response = imageTransformation.bgColor('cccccc').getUrl();
//       final split = response.split('?');
//       expect('bg-color=cccccc', split[1]);
//     });

//     test('dpr  in ImageTransformation', () {
//       final response = imageTransformation.dpr(4).getUrl();
//       final split = response.split('?');
//       expect('dpr=4', split[1]);
//     });

//     test('blur  in ImageTransformation', () {
//       final response = imageTransformation.blur(40).getUrl();
//       final split = response.split('?');
//       expect('blur=40', split[1]);
//     });

//     test('frame  in ImageTransformation', () {
//       final response = imageTransformation.frame(1).getUrl();
//       final split = response.split('?');
//       expect('frame=1', split[1]);
//     });

//     test('increase sharpen  in ImageTransformation', () {
//       final response = imageTransformation.sharpen(5, 1000, 2).getUrl();
//       final split = response.split('?');
//       expect('sharpen=a5%2Cr1000%2Ct2', split[1]);
//     });

//     test('saturation  in ImageTransformation', () {
//       final response = imageTransformation.saturation(20).getUrl();
//       final split = response.split('?');
//       expect('saturation=20', split[1]);
//     });

//     test('contrast  in ImageTransformation', () {
//       final response = imageTransformation.contrast(20).getUrl();
//       final split = response.split('?');
//       expect('contrast=20', split[1]);
//     });

//     test('brightness  in ImageTransformation', () {
//       final response = imageTransformation.brightness(20).getUrl();
//       final split = response.split('?');
//       expect('brightness=20', split[1]);
//     });

//     test('resize-filter  type nearest in ImageTransformation', () {
//       final response = imageTransformation
//           .resizeFilter(width: 20, height: 40, filter: Filter.nearest)
//           .getUrl();
//       final split = response.split('?');
//       expect('width=20&height=40&resize-filter=nearest', split[1]);
//     });

//     test('resize-filter  type Filter.bicubic in ImageTransformation', () {
//       final response = imageTransformation
//           .resizeFilter(width: 20, height: 40, filter: Filter.bicubic)
//           .getUrl();
//       final split = response.split('?');
//       expect('width=20&height=40&resize-filter=bicubic', split[1]);
//     });

//     test('resize-filter type Filter.bilinear  in ImageTransformation', () {
//       final response = imageTransformation
//           .resizeFilter(width: 20, height: 40, filter: Filter.bilinear)
//           .getUrl();
//       final split = response.split('?');
//       expect('width=20&height=40&resize-filter=bilinear', split[1]);
//     });

//     test('resize-filter  type lanczos in ImageTransformation', () {
//       final response = imageTransformation
//           .resizeFilter(width: 20, height: 40, filter: Filter.lanczos)
//           .getUrl();
//       final split = response.split('?');
//       expect('width=20&height=40&resize-filter=lanczos3', split[1]);
//     });

//     test('canvas by width and height in ImageTransformation', () {
//       final response = imageTransformation.canvas('700,800').getUrl();
//       final split = response.split('?');
//       expect('canvas=700%2C800', split[1]);
//     });

//     test('canvas by ratio in ImageTransformation', () {
//       final response = imageTransformation.canvas('2:3').getUrl();
//       final split = response.split('?');
//       expect('canvas=2%3A3', split[1]);
//     });

//     test('canvas by sub-region in ImageTransformation', () {
//       final response =
//           imageTransformation.canvas("700,800,x0.50,y0.60").getUrl();
//       final split = response.split('?');
//       expect('canvas=700%2C800%2Cx0.50%2Cy0.60', split[1]);
//     });

//     test('canvas by Offset in ImageTransformation', () {
//       final response = imageTransformation
//           .canvas("700,800,offset-x0.65,offset-y0.80")
//           .getUrl();
//       final split = response.split('?');
//       expect('canvas=700%2C800%2Coffset-x0.65%2Coffset-y0.80', split[1]);
//     });
   });
 }
