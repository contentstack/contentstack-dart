///The Image Delivery API is used to retrieve, manipulate and/or convert image
///files of your Contentstack account and deliver it to your web or mobile properties.

import 'dart:async';
import 'package:contentstack/client.dart';
import 'package:logging/logging.dart';

class ImageTransformation {

  final Logger log = Logger('ImageTransformation');
  final String _imageUrl;
  final HttpClient client;
  final Map<String, String> _queryParameter = <String, String>{};
  ImageTransformation(this._imageUrl, this.client);

  /// The auto function lets you enable the functionality that automates certain image optimization features.
  /// As of now, there is only one possible value for this field, i.e., webp. When the auto parameter is set to webp,
  /// it enables WebP image support. WebP images have higher compression rate with minimum loss of quality.

  /// For more details read the documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#automate-optimization
  ImageTransformation auto({String auto, String format}) {
    if (auto != null) {
      _queryParameter["auto"] = auto;
    }
    if (format != null) {
      _queryParameter["formate"] = format;
    }
    return this;
  }

  ///The quality function lets you control the compression level of images that have Lossy file format.
  ///The value for this parameters can be entered in any whole number (taken as a percentage)
  /// between 1 and 100. The lower the number, the smaller will be file size and lower quality, and vice versa.
  /// If the source image file is not of Lossy file format, this parameter will be ignored.
  ///
  /// For more details read the documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#quality
  ImageTransformation quality(int quality) {
    _queryParameter["quality"] = quality.toString();
    return this;
  }

  /// The format function lets you converts a given image from one format to another.
  /// The formats that the source image can be converted to are gif, png, jpg (for JPEG),
  /// pjpg (for Progressive JPEG), webp, webpll (Lossless), and webply (Lossy).
  ///
  /// for more details read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#convert-formats
  ImageTransformation convert(Format format) {
    _queryParameter['format'] = format.toString();
    return this;
  }

  ///this function lets you dynamically resize the width of the output image by specifying pixels or percentage values
  /// for more details read documentation:
  ///   ///The disable function disables the functionality that is enabled by default.
  ///For instance, upscale is always enabled, in which the image is upscaled
  ///if the output image (by specifying the width or height) is bigger than the source image.
  ///To disable this feature, you can use the query ?disable=upscale.
  ///This ensures that even if the specified height or width is much bigger than the actual image,
  ///it will not be rendered disproportionately.
  ///
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#resize-images
  ImageTransformation resize({int width, int height, bool disable}) {
    if (width != null) {
      _queryParameter['width'] = width.toString();
    }
    if (height != null) {
      _queryParameter['height'] = height.toString();
    }
    if (disable != null && disable) {
      _queryParameter["disable"] = "upscale";
    }
    return this;
  }

  /// The crop function allows you to remove pixels from an image.
  /// You can crop an image by specifying the height and width in
  /// pixels or percentage value, or defining height and width in aspect ratio.
  /// You can also define a sub region (i.e., define the starting point for crop)
  /// before cropping the image, or you can offset the image on its
  /// X and Y axis (i.e., define the centre point of the crop) before cropping the image.

  ///[cropRatio]
  ///You can set the X-axis and Y-axis position of the top left corner of the crop by
  ///using the query ?crop={width_value},{height_value},x{value},y{value}.
  ///This lets you define the starting point of the crop region.
  ///The x-axis value and y-axis value can be defined in pixels or percentage.
  ///
  ///An example of this would be ?crop=300,400,x150,y75 or ?crop=300,400,x0.50,y0.60.
  ///Compulsory parameters [width] and [height]
  ///Optional parameters: [cropRatio]
  /// For more details read the doc: https://www.contentstack.com/docs/developers/apis/image-delivery-api/#crop-images
  /// Example:
  /*
      With Aspect Ratio:
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.cropBy(150, 100, cropRatio: '1:3').fetch();
     log.fine(response);

      Without aspect Ratio:
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final imageTransformation = stack.imageTransform(imageUrl);
      final response = await imageTransformation.cropBy(150, 100).fetch();
      log.fine(response);
   */
  ImageTransformation cropBy({int width, int height, String cropValue}) {
    // checks if cropRatio is not null then takes height, width and cropRatio as prams
    // else it takes crop params and comas separated width & height
    if (width != null && height !=null) {
      // example: width=300&height=400&crop=1:3
      _queryParameter['width'] = width.toString();
      _queryParameter['height'] = height.toString();
      _queryParameter['crop'] = cropValue.toString();
    } else {
      _queryParameter['crop'] = cropValue.toString();
    }
    return this;
  }

  ///This parameter enables you to fit the given image properly within the specified height and width.
  ///You need to provide values for the height, width and fit parameters.
  ///The two available values for the fit parameter are bounds and crop.
  ///fit accepts optional parameters [width], [height]  of type [int] and fir of type [FIt]
  ImageTransformation fitBy(int width, int height, Fit fit) {
    if (width != null) {
      _queryParameter["width"] = width.toString();
    }
    if (height != null) {
      _queryParameter["height"] = height.toString();
    }
    if (fit != null) {
      _queryParameter["fit"] = fit.toString();
    }
    return this;
  }

  ///The trim parameter lets you trim an image from the edges.
  ///This is especially useful for removing border or white spaces
  ///that the downloaded images usually come with.
  ///The value for this parameter can be given in pixels or percentage.
  ///You can specify values for [top], [right], [bottom], and [left] edges of an image.
  ///For example, to trim the top edge by 25px, right edge by 50px, bottom edge by 75px and left edge by 100
  /// provide [trim] as comma separated value like, 25,50,75,100
  ImageTransformation trim([int top, int right, int bottom, int left]) {
   final  trimLRBL = [];
    if(top!=null){
      trimLRBL.add(top);
    }
    if(right !=null ){
      trimLRBL.add(top);
    }
   if(bottom !=null ){
     trimLRBL.add(bottom);
   }
   if(left !=null ){
     trimLRBL.add(left);
   }
   final joinedValue = trimLRBL.join(', ');
    _queryParameter["trim"] = joinedValue;
    return this;
  }

  ///The orient parameter lets you control the cardinal orientation of the given image.
  ///Using this parameter, you can orient the image right or left, flip horizontally
  ///or vertically or both, and do a lot more. It can automatically correct the
  ///orientation of the image if the source image contains orientation details
  ///within its EXIF data (Exchangeable Image File Format).
  ///
  ///[orient] parameter should be enum type of  [Orientation]
  ImageTransformation orientation(Orientation orient) {
    // toDefault = '1';
    //  horizontally = '2';
    //  horizontallyAndVertically = '3';
    //  vertically = '4';
    //  horizontallyAndRotate90DegreeLeft = '5';
    //  degrees90TowardsRight = '6';
    //  horizontallyAndRotate90DegreesRight = '7';
    //  rotate90DegreesLeft = '8';
    if (orient != null) {
      _queryParameter["orient"] = _orientToString(orient) as String;
    }
    return this;
  }

  /// The overlay parameter allows you to put one image on top of another.
  /// You need to specify the relative URL of the image as value for this parameter.
  /// By default, the cropping alignment will be middle, center. See overlay-align for more details.
  /// It accepts [overlayUrl]  as a parameter to put one [overlayUrl] on top of [_imageUrl]
  /// There are optional params also like [overlayAlign], [overlayRepeat], [overlayWidth], [overlayHeight]
  /// Fr more details read the documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#overlay
  ImageTransformation overlay(String overlayUrl,
      {String overlayAlign,
      String overlayRepeat,
      String overlayWidth,
      String overlayHeight}) {
    if (overlayUrl != null) {
      _queryParameter['overlay'] = overlayUrl;
    } else if (overlayAlign != null) {
      _queryParameter['overlay-align'] = overlayAlign;
    } else if (overlayRepeat != null) {
      _queryParameter['overlay-align'] = overlayRepeat;
    } else if (overlayWidth != null) {
      _queryParameter['overlay-align'] = overlayWidth;
    } else if (overlayHeight != null) {
      _queryParameter['overlay-align'] = overlayHeight;
    }
    return this;
  }

  /// This function lets you add extra pixels to the edges of an image.
  /// This is useful if you want to add whitespace or border to an image.
  /// The value for this parameter can be given in pixels or percentage.
  ///
  /// You can specify values for top, right, bottom, and left padding for an image.
  /// For example, to add padding to the top edge by 25px, right edge by 50px, bottom edge by 75px and left edge by 100,
  ImageTransformation addPadding(String padding) {
    _queryParameter["pad"] = padding;
    return this;
  }

  ///The bg-color function lets you set a backgroud color for the given image.
  ///This is useful when applying padding or for replacing the transparent pixels of an image.
  ///There are three possible types of values for this [bgColor] is string .
  ///It can accept hexadecimal, combination of (Red, Blue, Green) and (Red, Blue, Green, Alpha).
  ImageTransformation bgColor(String bgColor) {
    _queryParameter["bg-color"] = bgColor;
    return this;
  }

  ///To implement the device pixel ratio functionality of the Image Delivery API, you require two parameters "dpr" and "height or width".
  ///For more details read the documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#set-device-pixel-ratio
  ImageTransformation dpr(int width, int height, int dpr) {
    _queryParameter["width"] = width.toString();
    _queryParameter["height"] = height.toString();
    _queryParameter["dpr"] = dpr.toString();
    return this;
  }


///
  /// The blur parameter allows you to decrease the focus and clarity of a given image.
  /// To specify the extent to which you need to increase the blurriness of an image,
  /// use any decimal number (float) between 1 and 1000.
  ///
  ///
  ImageTransformation blur(int blur) {
    _queryParameter["blur"] = blur.toString();
    return this;
  }

  ///The frame parameter fetches the first frame from an animated GIF
  ///(Graphics Interchange Format) file that comprises a sequence of moving images.
  ImageTransformation frame(int frame){
    _queryParameter["frame"] = frame.toString();
    return this;
  }

  ///The frame parameter fetches the first frame from an animated GIF
  ///(Graphics Interchange Format) file that comprises a sequence of moving images.
  ///Increase the sharpness of a given image by amount, radius and threshold
  ImageTransformation increaseSharpen(String sharpen){
    _queryParameter["sharpen"] = sharpen.toString();
    return this;
  }

  ///The saturation parameter allows you to increase or decrease the intensity
  /// of the colors in a given image. To specify the saturation
  /// for an image, use a whole number (integer) between -100 and 100.
  /// You can also define saturation using any decimal number between -100.00 and 100.00
  ImageTransformation saturation(int saturation){
    _queryParameter["saturation"] = saturation.toString();
    return this;
  }


  ///The contrast parameter allows you to increase or decrease
  ///the difference between the darkest and lightest tones in a given image.
  ///To specify contrast for an image, use a whole number (integer)
  /// between -100 and 100. You can also define contrast using any decimal number between -100.00 and 100.00.
  ///
  /// To increase the value of the contrast parameter of an image, pass a positive value or negative value
  ImageTransformation contrast(int contrast){
    _queryParameter["contrast"] = contrast.toString();
    return this;
  }

  ///The brightness parameter allows you to increase or decrease the intensity
  ///with which an image reflects or radiates perceived light.
  ///To specify brightness for an image, use a whole number (integer) between -100 and 100.
  ///You can also define brightness using any decimal number between -100.00 and 100.00
  ///
  /// To increase the value of the brightness parameter of an image, pass a positive value or negative value
  ImageTransformation brightness(int brightness){
    _queryParameter["brightness"] = brightness.toString();
    return this;
  }


  ///The resize-filter parameter allows you to use the resizing
  ///filter to increase or decrease the number of pixels in a given image.
  ///This parameter resizes the given image without adding or removing any data from it.
  ///
  /// The following values are acceptable for the resize-filter parameter
  ImageTransformation resizeFilter(){

  }


  Future fetch() async {
    final bool _validURL = Uri.parse(_imageUrl).isAbsolute;
    if (!_validURL) {
      throw Exception('Invalid url requested');
    }
    final uri = Uri.https(_imageUrl, '', _queryParameter);
    final String imageLink = uri.toString();

    final response = await client.sendRequest(imageLink);
    if (response.statusCode != 200) {
      throw Exception('getEntry failed');
    }
    return null;
  }


  int _orientToString(Orientation orient){
    switch (orient) {
      case Orientation.toDefault:
        return  1;
      case Orientation.horizontally:
        return 2;
      case Orientation.horizontallyAndVertically:
        return 3;
      case Orientation.vertically:
        return 4;
      case Orientation.horizontallyAndRotate90DegreeLeft:
        return 5;
      case Orientation.degrees90TowardsRight:
        return 6;
      case Orientation.horizontallyAndRotate90DegreesRight:
        return 7;
      case Orientation.rotate90DegreesLeft:
        return 8;
      default:
        return 1;
    }
  }

}

enum Filter{
  nearest, bilinear, bicubic, lanczos, lanczos3,
}

enum Orientation{
  toDefault, horizontally, horizontallyAndVertically, vertically,
  horizontallyAndRotate90DegreeLeft,  degrees90TowardsRight,
  horizontallyAndRotate90DegreesRight, rotate90DegreesLeft
}
enum Format { gif, png, jpg, pjpg, webp, webply, webpll }
enum Fit { bounds , crop }
