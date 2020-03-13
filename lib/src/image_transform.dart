///The Image Delivery API is used to retrieve, manipulate and/or convert image
///files of your Contentstack account and deliver it to your web or mobile properties.

class ImageTransformation{
  final String imageUrl;
  Map<String, String> queryParameter = <String,String>{};
  ImageTransformation( this.imageUrl);

  /// The auto function lets you enable the functionality that automates certain image optimization features.
  /// As of now, there is only one possible value for this field, i.e., webp. When the auto parameter is set to webp,
  /// it enables WebP image support. WebP images have higher compression rate with minimum loss of quality.

  /// For more details read the documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#automate-optimization
  ImageTransformation auto(String auto, String format){
    queryParameter["auto"] = auto;
    queryParameter["formate"] = format;
    return this;
  }

  ///The quality function lets you control the compression level of images that have Lossy file format.
  ///The value for this parameters can be entered in any whole number (taken as a percentage)
  /// between 1 and 100. The lower the number, the smaller will be file size and lower quality, and vice versa.
  /// If the source image file is not of Lossy file format, this parameter will be ignored.
  ///
  /// For more details read the documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#quality
  ImageTransformation quality(int quality){
    queryParameter["quality"] = quality.toString();
    return this;
  }

  /// The format function lets you converts a given image from one format to another.
  /// The formats that the source image can be converted to are gif, png, jpg (for JPEG),
  /// pjpg (for Progressive JPEG), webp, webpll (Lossless), and webply (Lossy).
  ///
  /// for more details read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#convert-formats
  ImageTransformation convert(Format format){
    queryParameter['format'] = format.toString();
    return this;
  }

  ///It lets you dynamically resize the width of the output image by specifying pixels or percentage values
  /// for more details read documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#resize-images
  ImageTransformation resize({int width, int height}){
    if(width != null){
      queryParameter['width'] = width.toString();
    }
    if(height !=null){
      queryParameter['height'] = height.toString();
    }
    return this;
  }

  ///The disable function disables the functionality that is enabled by default.
  ///For instance, upscale is always enabled, in which the image is upscaled
  ///if the output image (by specifying the width or height) is bigger than the source image.
  ///To disable this feature, you can use the query ?disable=upscale.
  ///This ensures that even if the specified height or width is much bigger than the actual image,
  ///it will not be rendered disproportionately.
  ///
  /// /// for more details read documentation:
  ///https://www.contentstack.com/docs/developers/apis/image-delivery-api/#disable
  ImageTransformation disableResize(){
    queryParameter["disable"] = "upscale";
    return this;
  }


  /// The crop parameter allows you to remove pixels from an image.
  /// You can crop an image by specifying the height and width in
  /// pixels or percentage value, or defining height and width in aspect ratio.
  /// You can also define a sub region (i.e., define the starting point for crop)
  /// before cropping the image, or you can offset the image on its
  /// X and Y axis (i.e., define the centre point of the crop) before cropping the image.
  ImageTransformation crop(String croppingValue){
    if(croppingValue != null){
      queryParameter['crop'] = croppingValue;
    }
    return this;
  }

///This parameter enables you to fit the given image properly within the specified height and width.
  ///You need to provide values for the height, width and fit parameters.
  ///The two available values for the fit parameter are bounds and crop.
  ///fit accepts optional parameters [width], [height]  of type [int] and fir of type [FIt]
  ImageTransformation  fit({int width, int height, Fit fit}){
    if(width != null){
      queryParameter["width"] = width.toString();
    }
    if(height != null){
      queryParameter["height"] = height.toString();
    }
    if(fit != null){
      queryParameter["fit"] = fit.toString();
    }
    return this;
  }

///The trim parameter lets you trim an image from the edges.
///This is especially useful for removing border or white spaces
///that the downloaded images usually come with.
///The value for this parameter can be given in pixels or percentage.
///You can specify values for top, right, bottom, and left edges of an image.
///For example, to trim the top edge by 25px, right edge by 50px, bottom edge by 75px and left edge by 100
/// provide [trim] as comma separated value like, 25,50,75,100
  ImageTransformation trim(String trim){
    queryParameter["trim"] = trim;
    return this;
  }

///The orient parameter lets you control the cardinal orientation of the given image.
///Using this parameter, you can orient the image right or left, flip horizontally
///or vertically or both, and do a lot more. It can automatically correct the
///orientation of the image if the source image contains orientation details
///within its EXIF data (Exchangeable Image File Format).
  ///
  ///[orient] parameter should be enum type of  [Orientation]
  ImageTransformation orientation({Orientation orient }){
    if(orient !=null ){
      queryParameter["orient"] = orient.toString();
    }
    return this;
  }


  /// The overlay parameter allows you to put one image on top of another.
  /// You need to specify the relative URL of the image as value for this parameter.
  /// By default, the cropping alignment will be middle, center. See overlay-align for more details.
  /// It accepts [overlayUrl]  as a parameter to put one [overlayUrl] on top of [imageUrl]
  /// There are optional params also like [overlayAlign], [overlayRepeat], [overlayWidth], [overlayHeight]
  /// Fr more details read the documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#overlay
  ImageTransformation overlay(String overlayUrl, { String overlayAlign,  String overlayRepeat,
    String overlayWidth, String overlayHeight }){
    if(overlayUrl  != null){
      queryParameter['overlay'] = overlayUrl;
    } else if(overlayAlign != null){
      queryParameter['overlay-align'] = overlayAlign;
    }   else if(overlayRepeat != null){
      queryParameter['overlay-align'] = overlayRepeat;
    }   else if(overlayWidth != null){
      queryParameter['overlay-align'] = overlayWidth;
    }   else if(overlayHeight != null){
      queryParameter['overlay-align'] = overlayHeight;
    }
    return this;
  }


  /// This function lets you add extra pixels to the edges of an image.
  /// This is useful if you want to add whitespace or border to an image.
  /// The value for this parameter can be given in pixels or percentage.
  ///
  /// You can specify values for top, right, bottom, and left padding for an image.
  /// For example, to add padding to the top edge by 25px, right edge by 50px, bottom edge by 75px and left edge by 100,
  ImageTransformation addPadding(String padding){
    queryParameter["pad"] = padding;
    return this;
  }

  ///The bg-color function lets you set a backgroud color for the given image.
  ///This is useful when applying padding or for replacing the transparent pixels of an image.
  ///There are three possible types of values for this [bgColor] is string .
  ///It can accept hexadecimal, combination of (Red, Blue, Green) and (Red, Blue, Green, Alpha).
ImageTransformation bgColor(String bgColor){
    if(bgColor != null){
      queryParameter["bg-color"] = bgColor;
    }
    return this;
}

///To implement the device pixel ratio functionality of the Image Delivery API, you require two parameters "dpr" and "height or width".
  ///For more details read the documentation:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#set-device-pixel-ratio
  ImageTransformation dpr(int width, int height, int dpr){
    queryParameter["width"] = width.toString();
    queryParameter["height"] = height.toString();
    queryParameter["dpr"] = dpr.toString();
    return this;
  }


}



class Orientation {
  static const toDefault = '1';
  static const horizontally = '2';
  static const horizontallyAndVertically = '3';
  static const vertically = '4';
  static const horizontallyAndRotate90DegreeLeft = '5';
  static const degrees90TowardsRight = '6';
  static const horizontallyAndRotate90DegreesRight = '7';
  static const rotate90DegreesLeft = '8';
}

class Format{
  static const gif = 'gif';
  static const png = 'png';
  static const jpg = 'jpg';
  static const pJpg = 'pjpg';
  static const webp = 'webp';
  static const webpLossy= 'webply';
  static const webpLossless = 'webpll';
}

class Fit{
  static const bounds = 'bounds';
  static const crop = 'crop';
}