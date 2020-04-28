// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fit.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class Fit extends Equatable {
  const Fit(this._type);

  factory Fit.bounds() = Bounds;

  factory Fit.crop() = Crop;

  final _Fit _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(Bounds) bounds, @required R Function(Crop) crop}) {
    assert(() {
      if (bounds == null || crop == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Fit.Bounds:
        return bounds(this as Bounds);
      case _Fit.Crop:
        return crop(this as Crop);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(Bounds) bounds,
      @required FutureOr<R> Function(Crop) crop}) {
    assert(() {
      if (bounds == null || crop == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Fit.Bounds:
        return bounds(this as Bounds);
      case _Fit.Crop:
        return crop(this as Crop);
    }
  }

  R whenOrElse<R>(
      {R Function(Bounds) bounds,
      R Function(Crop) crop,
      @required R Function(Fit) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Fit.Bounds:
        if (bounds == null) break;
        return bounds(this as Bounds);
      case _Fit.Crop:
        if (crop == null) break;
        return crop(this as Crop);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(Bounds) bounds,
      FutureOr<R> Function(Crop) crop,
      @required FutureOr<R> Function(Fit) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Fit.Bounds:
        if (bounds == null) break;
        return bounds(this as Bounds);
      case _Fit.Crop:
        if (crop == null) break;
        return crop(this as Crop);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(Bounds) bounds,
      FutureOr<void> Function(Crop) crop}) {
    assert(() {
      if (bounds == null && crop == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _Fit.Bounds:
        if (bounds == null) break;
        return bounds(this as Bounds);
      case _Fit.Crop:
        if (crop == null) break;
        return crop(this as Crop);
    }
  }

  @override
  List get props => const [];
}

@immutable
class Bounds extends Fit {
  const Bounds._() : super(_Fit.Bounds);

  factory Bounds() {
    _instance ??= const Bounds._();
    return _instance;
  }

  static Bounds _instance;
}

@immutable
class Crop extends Fit {
  const Crop._() : super(_Fit.Crop);

  factory Crop() {
    _instance ??= const Crop._();
    return _instance;
  }

  static Crop _instance;
}
