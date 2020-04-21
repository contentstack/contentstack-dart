///The Image Delivery API is used to retrieve, manipulate and/or convert image
///files of your Contentstack account and deliver it to your web or mobile properties.

import 'dart:async';
import 'package:contentstack/client.dart';
import 'package:contentstack/src/query_params.dart';
import 'package:logging/logging.dart';

class ImageTransformation {

  final String _imageUrl;
  final HttpClient client;
  final Logger log = Logger('ImageTransformation');
  final Map<String, String> queryParameter = <String, String>{};
  final URLQueryParams query = URLQueryParams();
  ImageTransformation(this._imageUrl, this.client);

  /// The auto function lets you enable the functionality that automates certain image optimization features.
  /// As of now, there is only one possible value for this field, i.e., webp. When the auto parameter is set to webp,
  /// it enables WebP image support. WebP images have higher compression rate with minimum loss of quality.

  /// For more details, Read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#automate-optimization
  ///
  ///Example:
  ///  final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  ///  final imageTransformation = stack.imageTransform(imageUrl);
  ///  await imageTransformation.auto(auto: 'webp', format: 'pjpg').fetch();
  void auto({String auto, String format}) {
    if (auto != null) {
      query.append('auto', auto);
    }
    if (format != null) {
      query.append("formate", format);
    }
  }

  /// The quality function lets you control the compression level of images that have Lossy file format.
  /// The value for this parameters can be entered in any whole number (taken as a percentage)
  /// between 1 and 100. The lower the number, the smaller will be file size and lower quality, and vice versa.
  /// If the source image file is not of Lossy file format, this parameter will be ignored.
  ///
  /// For more details, Read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#quality
  ///
  /// Example:
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final imageTransformation = stack.imageTransform(imageUrl);
  /// final response = await imageTransformation.quality(2).fetch();
  ///
  void quality(int quality) {
    query.append("quality", quality.toString());
  }

  /// The format function lets you converts a given image from one format to another.
  /// The formats that the source image can be converted to are gif, png, jpg (for JPEG),
  /// pjpg (for Progressive JPEG), webp, webpll (Lossless), and webply (Lossy).
  ///
  /// for more details read documentation:
  /// For more details, Read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#convert-formats
  ///
  ///  Example:
  ///  final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  ///  final imageTransformation = stack.imageTransform(imageUrl);
  ///  final response = await imageTransformation.convert(Format.pjpg).fetch();
  void convert(Format format) {
    query.append("format", _formatToString(format));
  }

  /// this function lets you dynamically resize the width of the output image by specifying pixels or percentage values
  /// for more details read documentation:
  /// The disable function disables the functionality that is enabled by default.
  /// For instance, upscale is always enabled, in which the image is upscaled
  /// if the output image (by specifying the width or height) is bigger than the source image.
  /// To disable this feature, you can use the query ?disable=upscale.
  /// This ensures that even if the specified height or width is much bigger than the actual image,
  /// it will not be rendered disproportionately.
  ///
  /// For more details, Read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#resize-images
  ///
  /// Example:
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final imageTransformation = stack.imageTransform(imageUrl);
  /// final response = await imageTransformation.resize(width: 100, disable: true ).fetch();
  void resize({int width, int height, bool disable}) {
    if (width != null) {
      //queryParameter['width'] = width.toString();
      query.append("width", width.toString());
    }
    if (height != null) {
      query.append("height", height.toString());
    }
    if (disable != null && disable) {
      query.append("disable", "upscale");
    }
  }

  void crop(String cropValue) {
    // checks if cropRatio is not null then takes height, width and cropRatio as prams
    // else it takes crop params and comas separated width & height
    query.append("crop", cropValue);
  }

  /// The crop function allows you to remove pixels from an image.
  /// You can crop an image by specifying the height and width in
  /// pixels or percentage value, or defining height and width in aspect ratio.
  /// You can also define a sub region (i.e., define the starting point for crop)
  /// before cropping the image, or you can offset the image on its
  /// X and Y axis (i.e., define the centre point of the crop) before cropping the image.

  /// You can set the X-axis and Y-axis position of the top left corner of the crop by
  /// using the query ?crop={width_value},{height_value},x{value},y{value}.
  /// This lets you define the starting point of the crop region.
  /// The x-axis value and y-axis value can be defined in pixels or percentage.
  ///
  /// An example of this would be ?crop=300,400,x150,y75 or ?crop=300,400,x0.50,y0.60.
  /// Compulsory parameters [width] and [height]
  /// Optional parameters: [region]
  /// Optional parameters: [offset]
  /// For more details, Read documentation:
  /// For more details read the doc: https://www.contentstack.com/docs/developers/apis/image-delivery-api/#crop-images
  ///
  /// Example: With Aspect Ratio:
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final imageTransformation = stack.imageTransform(imageUrl);
  /// final response = await imageTransformation.cropBy(150, 100, cropRatio: '1:3').fetch();
  /// log.fine(response);
  ///
  /// Example: Without aspect Ratio:
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final imageTransformation = stack.imageTransform(imageUrl);
  /// final response = await imageTransformation.cropBy(150, 100).fetch();
  /// log.fine(response);
  void cropBy(int width, int height,
      {String region, String offset}) {
    // checks if cropRatio is not null then takes height, width and cropRatio as prams
    // else it takes crop params and comas separated width & height
    final cropLRBL = [];
    if (width != null) {
      cropLRBL.add(width);
    }
    if (height != null) {
      cropLRBL.add(height);
    }
    if (region != null) {
      cropLRBL.add(region);
    }
    if (offset != null) {
      cropLRBL.add(offset);
    }
    final commaSeparated = cropLRBL.join(', ');
    query.append("crop", commaSeparated);
  }

  ///This parameter enables you to fit the given image properly within the specified height and width.
  ///You need to provide values for the height, width and fit parameters.
  ///The two available values for the fit parameter are bounds and crop.
  ///fit accepts optional parameters [width], [height]  of type [int] and fir of type [Fit]
  ///
  /// For more details, Read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#fit-mode
  ///
  ///  Example:
  ///   final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  ///   final imageTransformation = stack.imageTransform(imageUrl);
  ///   final response = await imageTransformation.fitBy(  250,  250, Fit.crop).fetch();
  ///

  void fit(double width, double height, Fit fit) {
    if (width != null) {
      query.append("width", width.toString());
    }
    if (height != null) {
      query.append("height", height.toString());
    }
    if (fit != null) {
      query.append("fit", _fitToString(fit));
    }
  }

  ///The trim parameter lets you trim an image from the edges.
  ///This is especially useful for removing border or white spaces
  ///that the downloaded images usually come with.
  ///The value for this parameter can be given in pixels or percentage.
  ///You can specify values for [top], [right], [bottom], and [left] edges of an image.
  ///For example, to trim the top edge by 25px, right edge by 50px, bottom edge by 75px and left edge by 100
  /// provide [trim] as comma separated value like, 25,50,75,100
  ///
  /// For more details, Read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#trim-images
  ///
  /// Example:
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  ///   final imageTransformation = stack.imageTransform(imageUrl);
  ///   final response = await imageTransformation.trim(25).fetch();
  void trim([int top, int right, int bottom, int left]) {
    final trimLRBL = [];
    if (top != null) {
      trimLRBL.add(top);
    }
    if (right != null) {
      trimLRBL.add(top);
    }
    if (bottom != null) {
      trimLRBL.add(bottom);
    }
    if (left != null) {
      trimLRBL.add(left);
    }
    final joinedValue = trimLRBL.join(', ');
    query.append("trim", joinedValue);
  }

  ///The orient parameter lets you control the cardinal orientation of the given image.
  ///Using this parameter, you can orient the image right or left, flip horizontally
  ///or vertically or both, and do a lot more. It can automatically correct the
  ///orientation of the image if the source image contains orientation details
  ///within its EXIF data (Exchangeable Image File Format).
  ///
  ///[orient] parameter should be enum type of  [Orientation]
  ///
  /// For more details, Read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#reorient-images
  ///
  ///  Example:
  ///   final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  ///  final imageTransformation = stack.imageTransform(imageUrl);
  ///  final response = await imageTransformation.orientation(Orientation.vertically).fetch();
  void orientation(Orientation orient) {
    // toDefault = '1';
    //  horizontally = '2';
    //  horizontallyAndVertically = '3';
    //  vertically = '4';
    //  horizontallyAndRotate90DegreeLeft = '5';
    //  degrees90TowardsRight = '6';
    //  horizontallyAndRotate90DegreesRight = '7';
    //  rotate90DegreesLeft = '8';
    if (orient != null) {
      query.append("orient", _orientToString(orient));
    }
  }

  /// The overlay parameter allows you to put one image on top of another.
  /// You need to specify the relative URL of the image as value for this parameter.
  /// By default, the cropping alignment will be middle, center. See overlay-align for more details.
  /// It accepts [overlayUrl]  as a parameter to put one [overlayUrl] on top of [_imageUrl]
  /// There are optional params also like [overlayAlign], [overlayRepeat], [overlayWidth], [overlayHeight]
  /// Fr more details read the documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#overlay
  ///
  /// For more details, Read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#overlay-pad
  ///
  /// Example
  ///  final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  ///  final imageTransformation = stack.imageTransform(imageUrl);
  ///  final response = await imageTransformation.overlay('overlayUrl', overlayWidth: '').fetch();
  ///
  void overlay(String overlayUrl,
      {String overlayAlign,
      String overlayRepeat,
      int overlayWidth,
      int overlayHeight}) {
    query.append('overlay', overlayUrl);

    if (overlayAlign != null) {
      query.append('overlay-align', overlayAlign);
    }
    if (overlayRepeat != null) {
      query.append("overlay-repeat", overlayRepeat);
    }
    if (overlayWidth != null) {
      query.append("overlay-width", overlayWidth);
    }
    if (overlayHeight != null) {
      query.append("overlay-height", overlayHeight);
    }
  }

  /// This function lets you add extra pixels to the edges of an image.
  /// This is useful if you want to add whitespace or border to an image.
  /// The value for this parameter can be given in pixels or percentage.
  ///
  /// You can specify values for top, right, bottom, and left padding for an image.
  /// For example, to add padding to the top edge by 25px, right edge by 50px, bottom edge by 75px and left edge by 100,
  ///
  /// For more details, Read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#pad
  ///
  ///Example:
  ///final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  ///final imageTransformation = stack.imageTransform(imageUrl);
  ///final response = await imageTransformation.padding("25,50,75,100").fetch();
  ///
  void padding(String padding) {
    query.append("pad", padding);
  }

  ///You can either specify all the four padding values (top, right, bottom, and left)
  ///or combine two or more values
  //top, right, bottom, left
  ///Example:
  ///final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  ///final imageTransformation = stack.imageTransform(imageUrl);
  ///final response = await imageTransformation.addPadding("25,50,75,100").fetch();
  void overlayPadding(String overlayPadding) {
    query.append("overlay-pad", overlayPadding);
  }

  ///The bg-color function lets you set a backgroud color for the given image.
  ///This is useful when applying padding or for replacing the transparent pixels of an image.
  ///There are three possible types of values for this [bgColor] is string .
  ///It can accept hexadecimal, combination of (Red, Blue, Green) and (Red, Blue, Green, Alpha).
  ///
  /// For more details, Read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#background-color
  ///  Example:
  ///  final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  ///  final imageTransformation = stack.imageTransform(imageUrl);
  ///  final response = await imageTransformation.bgColor('cccccc').fetch();
  void bgColor(String bgColor) {
    query.append("bg-color", bgColor);
  }

  ///To implement the device pixel ratio functionality of the Image Delivery API, you require two parameters "dpr" and "height or width".
  ///For more details read the documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#set-device-pixel-ratio
  ///
  /// For more details, Read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#dpr
  ///
  /// Example
  ///  final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  ///  final imageTransformation = stack.imageTransform(imageUrl);
  ///  final response = await imageTransformation.dpr(30, 60, 12).fetch();
  ///
  void dpr(int dpr) {
    query.append("dpr", dpr.toString());
  }

  ///
  /// The blur parameter allows you to decrease the focus and clarity of a given image.
  /// To specify the extent to which you need to increase the blurriness of an image,
  /// use any decimal number (float) between 1 and 1000.
  ///
  /// For more details, Read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#blur
  ///
  /// Example:
  ///  final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  ///  final imageTransformation = stack.imageTransform(imageUrl);
  ///  final response = await imageTransformation.blur(3).fetch();

  void blur(int blur) {
    query.append("blur", blur.toString());
  }

  ///The frame parameter fetches the first frame from an animated GIF
  ///(Graphics Interchange Format) file that comprises a sequence of moving images.
  /// For more details, Read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#frame
  ///
  /// Example:
  ///  final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  ///  final imageTransformation = stack.imageTransform(imageUrl);
  ///  final response = await imageTransformation.frame(30).fetch();
  ///
  void frame(int frame) {
    query.append("frame", frame.toString());
  }

  ///The frame parameter fetches the first frame from an animated GIF
  ///(Graphics Interchange Format) file that comprises a sequence of moving images.
  ///Increase the sharpness of a given image by amount, radius and threshold
  /// For more details, Read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#sharpen
  ///
  ///  Example:
  ///  final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  ///  final imageTransformation = stack.imageTransform(imageUrl);
  ///  final response = await imageTransformation.sharpen(5, 1000, 2').fetch();
  ///
  void sharpen(int amount, int radius, int threshold) {
    query.append("sharpen", "a$amount,r$radius,t$threshold");
  }

  ///The saturation parameter allows you to increase or decrease the intensity
  /// of the colors in a given image. To specify the saturation
  /// for an image, use a whole number (integer) between -100 and 100.
  /// You can also define saturation using any decimal number between -100.00 and 100.00
  /// For more details, Read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#saturation
  ///    Example:
  ///    final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  ///    final imageTransformation = stack.imageTransform(imageUrl);
  ///    final response = await imageTransformation.saturation(20);

  void saturation(int saturation) {
    query.append("saturation", saturation.toString());
  }

  /// The contrast parameter allows you to increase or decrease
  /// the difference between the darkest and lightest tones in a given image.
  /// To specify contrast for an image, use a whole number (integer)
  /// between -100 and 100. You can also define contrast using any decimal number between -100.00 and 100.00.
  ///
  /// To increase the value of the contrast parameter of an image, pass a positive value or negative value
  /// For more details, Read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#contrast
  ///
  /// Example
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final imageTransformation = stack.imageTransform(imageUrl);
  /// final response = await imageTransformation.contrast(20);

  void contrast(int contrast) {
    query.append("contrast", contrast.toString());
  }

  /// The brightness parameter allows you to increase or decrease the intensity
  /// with which an image reflects or radiates perceived light.
  /// To specify brightness for an image, use a whole number (integer) between -100 and 100.
  /// You can also define brightness using any decimal number between -100.00 and 100.00
  ///
  /// To increase the value of the brightness parameter of an image, pass a positive value or negative value
  /// For more details, Read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#brightness
  ///
  /// Example:
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final imageTransformation = stack.imageTransform(imageUrl);
  /// final response =  imageTransformation.brightness(20);
  void brightness(int brightness) {
    query.append("brightness", brightness.toString());
  }

  /// 
  /// The resize-filter parameter allows you to use the resizing
  /// filter to increase or decrease the number of pixels in a given image.
  /// This parameter resizes the given image without adding or removing any data from it.
  ///
  /// The following values are acceptable for the resize-filter parameter
  /// For more details, Read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#resize-filter
  
  /// Example:
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final imageTransformation = stack.imageTransform(imageUrl);
  /// final response =  imageTransformation.resizeFilter(width: 20, height: 40, filter: Filter.bilinear);
  ///
  void resizeFilter({int width, int height, Filter filter}) {
    if (width != null) {
      query.append("width", width.toString());
    }
    if (height != null) {
      query.append('height', height.toString());
    }
    if (filter != null) {
      query.append('resize-filter', _resizeFilterToString(filter));
    }
  }

  /// 
  /// The canvas parameter allows you to increase the size of the canvas that surrounds an image.
  /// You can specify the height and width of the canvas area in pixels or percentage or define the
  /// height and width of the aspect ratio of the canvas. You can also define the starting point for
  /// the canvas area or offset the canvas on its X and Y axis.
  ///
  /// [canvasValue] could be in the type of  string, It could be in the format of
  /// dimension: [700,800],
  /// ratio: 2:3 , sub-region: [700,800,x0.50,y0.60],  or offset :[ 700,800,offset-x0.65,offset-y0.80]
  /// For more details, Read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#canvas
  ///
  /// Example:  Canvas by width & Height:
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final imageTransformation = stack.imageTransform(imageUrl);
  /// final response =  imageTransformation.canvas('700,800');
  ///
  /// Example:  Canvas by ratio:
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final imageTransformation = stack.imageTransform(imageUrl);
  /// final response =  imageTransformation.canvas('2:3');
  ///
  /// Example:  Canvas  Sub-region:
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final imageTransformation = stack.imageTransform(imageUrl);
  /// final response =  imageTransformation.canvas('700,800,x0.50,y0.60');
  ///
  /// Example:  Canvas and offset:
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final imageTransformation = stack.imageTransform(imageUrl);
  /// final response =  imageTransformation.canvas('700,800,offset-x0.65,offset-y0.80');
  /// 
  void canvas(String canvasValue) {
    query.append("canvas", canvasValue);
  }

  ///Makes API Request of respective function.
  Future fetch() async {
    final bool _validURL = Uri.parse(_imageUrl).isAbsolute;
    if (!_validURL) {
      throw Exception('Invalid url requested');
    }
//    final response = await client.sendRequest(getUrl());
//    if (response.statusCode != 200) {
//      throw Exception('getEntry failed');
//    }
    return null;
  }

  String getUrl() {
    return query.toUrl(_imageUrl);
  }
  int _orientToString(Orientation orient) {
    switch (orient) {
      case Orientation.toDefault:
        return 1;
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
  String _formatToString(Format format) {
    //supports gif, png, jpg, pjpg, webp, webply, webpll
    switch (format) {
      case Format.gif:
        return 'gif';
      case Format.png:
        return 'png';
      case Format.jpg:
        return 'jpg';
      case Format.pjpg:
        return 'pjpg';
      case Format.webp:
        return 'webp';
      case Format.webplossy:
        return 'webply';
      case Format.webplossless:
        return 'webpll';      
    }

    return null;
  }
  String _fitToString(Fit fit) {
    //supports bounds, crop
    switch (fit) {
      case Fit.bounds:
        return 'bounds';
      case Fit.crop:
        return 'crop';
    }

    return null;
  }
  String _resizeFilterToString(Filter filter) {
    //supports bounds, crop
    switch (filter) {
      case Filter.nearest:
        return 'nearest';
      case Filter.bilinear:
        return 'bilinear';
      case Filter.bicubic:
        return 'bicubic';
      case Filter.lanczos:
        return 'lanczos3';
    }

    return null;
  }
}

enum Filter { nearest, bilinear, bicubic, lanczos }
enum Orientation {
  toDefault,
  horizontally,
  horizontallyAndVertically,
  vertically,
  horizontallyAndRotate90DegreeLeft,
  degrees90TowardsRight,
  horizontallyAndRotate90DegreesRight,
  rotate90DegreesLeft
}
enum Format { gif, png, jpg, pjpg, webp, webplossy, webplossless }
enum Fit { bounds, crop }
