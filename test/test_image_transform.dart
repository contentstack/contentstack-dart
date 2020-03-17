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

    setUp((){
      const apiKey = 'blteae40eb499811073';
      const deliveryToken = 'bltc5064f36b5855343';
      const environment = 'development';
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
        imageTransformation = stack.imageTransform(imageUrl);
    });

    test('initialise ImageTransformation functional', () {
      final checkUrl = imageTransformation.imageUrl;
      expect(imageUrl, checkUrl);
    });

    test('auto in ImageTransformation', () async {
      final response = imageTransformation.auto(auto: 'webp');
      expect(true, response.queryParameter.containsKey('auto'));
      expect(true, response.queryParameter.containsValue('webp'));
    });

    test('formate in ImageTransformation', () async {
      final response = imageTransformation.auto(format: 'pjpg');
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('auto and formate in ImageTransformation', () async {
      final response = imageTransformation.auto(auto: 'webp', format: 'pjpg');
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('quality in ImageTransformation', () async {
      final response = imageTransformation.quality(2);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('convert to gif in ImageTransformation', () async {
      final response = imageTransformation.convert(Format.gif);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('convert to png in ImageTransformation', () async {
      final response = imageTransformation.convert(Format.png);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('convert to jpeg in ImageTransformation', () async {
      final response = imageTransformation.convert(Format.pjpg);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('width resize image in ImageTransformation', () async {
      final response = imageTransformation.resize(width: 100);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('height resize image in ImageTransformation', () async {
      final response = imageTransformation.resize(height: 100);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('width and height resize image in ImageTransformation', () async {
      final response = imageTransformation.resize(width: 100, height: 100);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('disable resize image in ImageTransformation', () async {
      final response = imageTransformation.resize(width: 100, disable: true);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('crop by width and height in ImageTransformation', () async {
      final response = imageTransformation.cropBy(width: 150, height: 100);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('crop with aspect ratio in ImageTransformation', () async {
      final response =
          imageTransformation.cropBy(width: 150, height: 100, cropValue: '1:3');
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('crop subregion  in ImageTransformation', () async {
      final response =
          imageTransformation.cropBy(cropValue: "50,75,x0.10,y0.20");
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('Crop in fail-safe mode  in ImageTransformation', () async {
      final response =
          imageTransformation.cropBy(cropValue: "300,400,x50,y50,safe");
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('Smart Crop  in ImageTransformation', () async {
      final response = imageTransformation.cropBy(
          width: 300, height: 400, cropValue: "2:5,smart");
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('Fit To Bound  in ImageTransformation', () async {
      final response = imageTransformation.fitBy(250, 250, Fit.bounds);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('Fit By Cropping  in ImageTransformation', () async {
      final response = imageTransformation.fitBy(250, 250, Fit.crop);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('trim  in ImageTransformation with all params', () async {
      final response = imageTransformation.trim(25, 50, 75, 100);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('trim  in ImageTransformation with 3 params', () async {
      final response = imageTransformation.trim(25, 50, 75);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('trim  in ImageTransformation with 2 params', () async {
      final response = imageTransformation.trim(25, 50);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('trim  in ImageTransformation with 1 params', () async {
      final response = imageTransformation.trim(25);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('orientation  in ImageTransformation check params', () async {
      final response = imageTransformation.orientation(Orientation.vertically);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('overlay  overlayAlign in ImageTransformation', () async {
      final response =
          imageTransformation.overlay('overlayUrl', overlayAlign: '');
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('overlay  overlayHeight in ImageTransformation', () async {
      final response =
          imageTransformation.overlay('overlayUrl', overlayHeight: '');
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('overlay  overlayRepeat in ImageTransformation', () async {
      final response =
          imageTransformation.overlay('overlayUrl', overlayRepeat: '');
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('overlay  overlayWidth in ImageTransformation', () async {
      final response =
          imageTransformation.overlay('overlayUrl', overlayWidth: '');
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('padding   in ImageTransformation result of Padding', () async {
      final response = imageTransformation.addPadding("25,50,75,100");
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('bg-color  in ImageTransformation', () async {
      final response = imageTransformation.bgColor('bgColor');
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('dpr  in ImageTransformation', () async {
      final response = imageTransformation.dpr(20, 30, 4);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('blur  in ImageTransformation', () async {
      final response = imageTransformation.blur(4);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('frame  in ImageTransformation', () async {
      final response = imageTransformation.frame(4);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('increase sharpen  in ImageTransformation', () async {
      final response = imageTransformation.increaseSharpen('sharpen');
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('saturation  in ImageTransformation', () async {
      final response = imageTransformation.saturation(20);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('contrast  in ImageTransformation', () async {
      final response = imageTransformation.contrast(20);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('brightness  in ImageTransformation', () async {
      final response = imageTransformation.brightness(20);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('resize-filter  type nearest in ImageTransformation', () {
      final response = imageTransformation.resizeFilter(
          width: 20, height: 40, filter: Filter.nearest);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('resize-filter  type Filter.bicubic in ImageTransformation', () {
      final response = imageTransformation.resizeFilter(
          width: 20, height: 40, filter: Filter.bicubic);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('resize-filter type Filter.bilinear  in ImageTransformation', () {
      final response = imageTransformation.resizeFilter(
          width: 20, height: 40, filter: Filter.bilinear);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('resize-filter  type lanczos in ImageTransformation', () {
      final response = imageTransformation.resizeFilter(
          width: 20, height: 40, filter: Filter.lanczos);
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('canvas by width and height in ImageTransformation', () {
      final response = imageTransformation.canvas('700,800');
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('canvas by ratio in ImageTransformation', () {
      final response = imageTransformation.canvas('2:3');
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('canvas by sub-region in ImageTransformation', () {
      final response = imageTransformation.canvas("700,800,x0.50,y0.60");
      expect(true, response.queryParameter.containsKey('auto'));
    });

    test('canvas by Offset in ImageTransformation', () {
      final response =
          imageTransformation.canvas("700,800,offset-x0.65,offset-y0.80");
      expect(true, response.queryParameter.containsKey('auto'));
    });
  });
}
