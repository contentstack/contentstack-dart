// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'format.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class Format extends Equatable {
  const Format(this._type);

  factory Format.gif() = Gif;

  factory Format.png() = Png;

  factory Format.jpg() = Jpg;

  factory Format.pjpg() = Pjpg;

  factory Format.webp() = Webp;

  factory Format.webplossy() = Webplossy;

  factory Format.webplossless() = Webplossless;

  final _Format _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(Gif) gif,
      @required R Function(Png) png,
      @required R Function(Jpg) jpg,
      @required R Function(Pjpg) pjpg,
      @required R Function(Webp) webp,
      @required R Function(Webplossy) webplossy,
      @required R Function(Webplossless) webplossless}) {
    assert(() {
      if (gif == null ||
          png == null ||
          jpg == null ||
          pjpg == null ||
          webp == null ||
          webplossy == null ||
          webplossless == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Format.Gif:
        return gif(this as Gif);
      case _Format.Png:
        return png(this as Png);
      case _Format.Jpg:
        return jpg(this as Jpg);
      case _Format.Pjpg:
        return pjpg(this as Pjpg);
      case _Format.Webp:
        return webp(this as Webp);
      case _Format.Webplossy:
        return webplossy(this as Webplossy);
      case _Format.Webplossless:
        return webplossless(this as Webplossless);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(Gif) gif,
      @required FutureOr<R> Function(Png) png,
      @required FutureOr<R> Function(Jpg) jpg,
      @required FutureOr<R> Function(Pjpg) pjpg,
      @required FutureOr<R> Function(Webp) webp,
      @required FutureOr<R> Function(Webplossy) webplossy,
      @required FutureOr<R> Function(Webplossless) webplossless}) {
    assert(() {
      if (gif == null ||
          png == null ||
          jpg == null ||
          pjpg == null ||
          webp == null ||
          webplossy == null ||
          webplossless == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Format.Gif:
        return gif(this as Gif);
      case _Format.Png:
        return png(this as Png);
      case _Format.Jpg:
        return jpg(this as Jpg);
      case _Format.Pjpg:
        return pjpg(this as Pjpg);
      case _Format.Webp:
        return webp(this as Webp);
      case _Format.Webplossy:
        return webplossy(this as Webplossy);
      case _Format.Webplossless:
        return webplossless(this as Webplossless);
    }
  }

  R whenOrElse<R>(
      {R Function(Gif) gif,
      R Function(Png) png,
      R Function(Jpg) jpg,
      R Function(Pjpg) pjpg,
      R Function(Webp) webp,
      R Function(Webplossy) webplossy,
      R Function(Webplossless) webplossless,
      @required R Function(Format) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Format.Gif:
        if (gif == null) break;
        return gif(this as Gif);
      case _Format.Png:
        if (png == null) break;
        return png(this as Png);
      case _Format.Jpg:
        if (jpg == null) break;
        return jpg(this as Jpg);
      case _Format.Pjpg:
        if (pjpg == null) break;
        return pjpg(this as Pjpg);
      case _Format.Webp:
        if (webp == null) break;
        return webp(this as Webp);
      case _Format.Webplossy:
        if (webplossy == null) break;
        return webplossy(this as Webplossy);
      case _Format.Webplossless:
        if (webplossless == null) break;
        return webplossless(this as Webplossless);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(Gif) gif,
      FutureOr<R> Function(Png) png,
      FutureOr<R> Function(Jpg) jpg,
      FutureOr<R> Function(Pjpg) pjpg,
      FutureOr<R> Function(Webp) webp,
      FutureOr<R> Function(Webplossy) webplossy,
      FutureOr<R> Function(Webplossless) webplossless,
      @required FutureOr<R> Function(Format) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Format.Gif:
        if (gif == null) break;
        return gif(this as Gif);
      case _Format.Png:
        if (png == null) break;
        return png(this as Png);
      case _Format.Jpg:
        if (jpg == null) break;
        return jpg(this as Jpg);
      case _Format.Pjpg:
        if (pjpg == null) break;
        return pjpg(this as Pjpg);
      case _Format.Webp:
        if (webp == null) break;
        return webp(this as Webp);
      case _Format.Webplossy:
        if (webplossy == null) break;
        return webplossy(this as Webplossy);
      case _Format.Webplossless:
        if (webplossless == null) break;
        return webplossless(this as Webplossless);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(Gif) gif,
      FutureOr<void> Function(Png) png,
      FutureOr<void> Function(Jpg) jpg,
      FutureOr<void> Function(Pjpg) pjpg,
      FutureOr<void> Function(Webp) webp,
      FutureOr<void> Function(Webplossy) webplossy,
      FutureOr<void> Function(Webplossless) webplossless}) {
    assert(() {
      if (gif == null &&
          png == null &&
          jpg == null &&
          pjpg == null &&
          webp == null &&
          webplossy == null &&
          webplossless == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _Format.Gif:
        if (gif == null) break;
        return gif(this as Gif);
      case _Format.Png:
        if (png == null) break;
        return png(this as Png);
      case _Format.Jpg:
        if (jpg == null) break;
        return jpg(this as Jpg);
      case _Format.Pjpg:
        if (pjpg == null) break;
        return pjpg(this as Pjpg);
      case _Format.Webp:
        if (webp == null) break;
        return webp(this as Webp);
      case _Format.Webplossy:
        if (webplossy == null) break;
        return webplossy(this as Webplossy);
      case _Format.Webplossless:
        if (webplossless == null) break;
        return webplossless(this as Webplossless);
    }
  }

  @override
  List get props => const [];
}

@immutable
class Gif extends Format {
  const Gif._() : super(_Format.Gif);

  factory Gif() {
    _instance ??= const Gif._();
    return _instance;
  }

  static Gif _instance;
}

@immutable
class Png extends Format {
  const Png._() : super(_Format.Png);

  factory Png() {
    _instance ??= const Png._();
    return _instance;
  }

  static Png _instance;
}

@immutable
class Jpg extends Format {
  const Jpg._() : super(_Format.Jpg);

  factory Jpg() {
    _instance ??= const Jpg._();
    return _instance;
  }

  static Jpg _instance;
}

@immutable
class Pjpg extends Format {
  const Pjpg._() : super(_Format.Pjpg);

  factory Pjpg() {
    _instance ??= const Pjpg._();
    return _instance;
  }

  static Pjpg _instance;
}

@immutable
class Webp extends Format {
  const Webp._() : super(_Format.Webp);

  factory Webp() {
    _instance ??= const Webp._();
    return _instance;
  }

  static Webp _instance;
}

@immutable
class Webplossy extends Format {
  const Webplossy._() : super(_Format.Webplossy);

  factory Webplossy() {
    _instance ??= const Webplossy._();
    return _instance;
  }

  static Webplossy _instance;
}

@immutable
class Webplossless extends Format {
  const Webplossless._() : super(_Format.Webplossless);

  factory Webplossless() {
    _instance ??= const Webplossless._();
    return _instance;
  }

  static Webplossless _instance;
}
