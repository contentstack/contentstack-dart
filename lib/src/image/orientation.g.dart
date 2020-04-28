// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orientation.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class Orientation extends Equatable {
  const Orientation(this._type);

  factory Orientation.toDefault() = ToDefault;

  factory Orientation.horizontally() = Horizontally;

  factory Orientation.horizontallyAndVertically() = HorizontallyAndVertically;

  factory Orientation.vertically() = Vertically;

  factory Orientation.horizontallyAndRotate90DegreeLeft() =
      HorizontallyAndRotate90DegreeLeft;

  factory Orientation.degrees90TowardsRight() = Degrees90TowardsRight;

  factory Orientation.horizontallyAndRotate90DegreesRight() =
      HorizontallyAndRotate90DegreesRight;

  factory Orientation.rotate90DegreesLeft() = Rotate90DegreesLeft;

  final _Orientation _type;

//ignore: missing_return
  R when<R>(
      {@required
          R Function(ToDefault) toDefault,
      @required
          R Function(Horizontally) horizontally,
      @required
          R Function(HorizontallyAndVertically) horizontallyAndVertically,
      @required
          R Function(Vertically) vertically,
      @required
          R Function(HorizontallyAndRotate90DegreeLeft)
              horizontallyAndRotate90DegreeLeft,
      @required
          R Function(Degrees90TowardsRight) degrees90TowardsRight,
      @required
          R Function(HorizontallyAndRotate90DegreesRight)
              horizontallyAndRotate90DegreesRight,
      @required
          R Function(Rotate90DegreesLeft) rotate90DegreesLeft}) {
    assert(() {
      if (toDefault == null ||
          horizontally == null ||
          horizontallyAndVertically == null ||
          vertically == null ||
          horizontallyAndRotate90DegreeLeft == null ||
          degrees90TowardsRight == null ||
          horizontallyAndRotate90DegreesRight == null ||
          rotate90DegreesLeft == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Orientation.ToDefault:
        return toDefault(this as ToDefault);
      case _Orientation.Horizontally:
        return horizontally(this as Horizontally);
      case _Orientation.HorizontallyAndVertically:
        return horizontallyAndVertically(this as HorizontallyAndVertically);
      case _Orientation.Vertically:
        return vertically(this as Vertically);
      case _Orientation.HorizontallyAndRotate90DegreeLeft:
        return horizontallyAndRotate90DegreeLeft(
            this as HorizontallyAndRotate90DegreeLeft);
      case _Orientation.Degrees90TowardsRight:
        return degrees90TowardsRight(this as Degrees90TowardsRight);
      case _Orientation.HorizontallyAndRotate90DegreesRight:
        return horizontallyAndRotate90DegreesRight(
            this as HorizontallyAndRotate90DegreesRight);
      case _Orientation.Rotate90DegreesLeft:
        return rotate90DegreesLeft(this as Rotate90DegreesLeft);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required
          FutureOr<R> Function(ToDefault) toDefault,
      @required
          FutureOr<R> Function(Horizontally) horizontally,
      @required
          FutureOr<R> Function(HorizontallyAndVertically)
              horizontallyAndVertically,
      @required
          FutureOr<R> Function(Vertically) vertically,
      @required
          FutureOr<R> Function(HorizontallyAndRotate90DegreeLeft)
              horizontallyAndRotate90DegreeLeft,
      @required
          FutureOr<R> Function(Degrees90TowardsRight) degrees90TowardsRight,
      @required
          FutureOr<R> Function(HorizontallyAndRotate90DegreesRight)
              horizontallyAndRotate90DegreesRight,
      @required
          FutureOr<R> Function(Rotate90DegreesLeft) rotate90DegreesLeft}) {
    assert(() {
      if (toDefault == null ||
          horizontally == null ||
          horizontallyAndVertically == null ||
          vertically == null ||
          horizontallyAndRotate90DegreeLeft == null ||
          degrees90TowardsRight == null ||
          horizontallyAndRotate90DegreesRight == null ||
          rotate90DegreesLeft == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Orientation.ToDefault:
        return toDefault(this as ToDefault);
      case _Orientation.Horizontally:
        return horizontally(this as Horizontally);
      case _Orientation.HorizontallyAndVertically:
        return horizontallyAndVertically(this as HorizontallyAndVertically);
      case _Orientation.Vertically:
        return vertically(this as Vertically);
      case _Orientation.HorizontallyAndRotate90DegreeLeft:
        return horizontallyAndRotate90DegreeLeft(
            this as HorizontallyAndRotate90DegreeLeft);
      case _Orientation.Degrees90TowardsRight:
        return degrees90TowardsRight(this as Degrees90TowardsRight);
      case _Orientation.HorizontallyAndRotate90DegreesRight:
        return horizontallyAndRotate90DegreesRight(
            this as HorizontallyAndRotate90DegreesRight);
      case _Orientation.Rotate90DegreesLeft:
        return rotate90DegreesLeft(this as Rotate90DegreesLeft);
    }
  }

  R whenOrElse<R>(
      {R Function(ToDefault) toDefault,
      R Function(Horizontally) horizontally,
      R Function(HorizontallyAndVertically) horizontallyAndVertically,
      R Function(Vertically) vertically,
      R Function(HorizontallyAndRotate90DegreeLeft)
          horizontallyAndRotate90DegreeLeft,
      R Function(Degrees90TowardsRight) degrees90TowardsRight,
      R Function(HorizontallyAndRotate90DegreesRight)
          horizontallyAndRotate90DegreesRight,
      R Function(Rotate90DegreesLeft) rotate90DegreesLeft,
      @required R Function(Orientation) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Orientation.ToDefault:
        if (toDefault == null) break;
        return toDefault(this as ToDefault);
      case _Orientation.Horizontally:
        if (horizontally == null) break;
        return horizontally(this as Horizontally);
      case _Orientation.HorizontallyAndVertically:
        if (horizontallyAndVertically == null) break;
        return horizontallyAndVertically(this as HorizontallyAndVertically);
      case _Orientation.Vertically:
        if (vertically == null) break;
        return vertically(this as Vertically);
      case _Orientation.HorizontallyAndRotate90DegreeLeft:
        if (horizontallyAndRotate90DegreeLeft == null) break;
        return horizontallyAndRotate90DegreeLeft(
            this as HorizontallyAndRotate90DegreeLeft);
      case _Orientation.Degrees90TowardsRight:
        if (degrees90TowardsRight == null) break;
        return degrees90TowardsRight(this as Degrees90TowardsRight);
      case _Orientation.HorizontallyAndRotate90DegreesRight:
        if (horizontallyAndRotate90DegreesRight == null) break;
        return horizontallyAndRotate90DegreesRight(
            this as HorizontallyAndRotate90DegreesRight);
      case _Orientation.Rotate90DegreesLeft:
        if (rotate90DegreesLeft == null) break;
        return rotate90DegreesLeft(this as Rotate90DegreesLeft);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(ToDefault) toDefault,
      FutureOr<R> Function(Horizontally) horizontally,
      FutureOr<R> Function(HorizontallyAndVertically) horizontallyAndVertically,
      FutureOr<R> Function(Vertically) vertically,
      FutureOr<R> Function(HorizontallyAndRotate90DegreeLeft)
          horizontallyAndRotate90DegreeLeft,
      FutureOr<R> Function(Degrees90TowardsRight) degrees90TowardsRight,
      FutureOr<R> Function(HorizontallyAndRotate90DegreesRight)
          horizontallyAndRotate90DegreesRight,
      FutureOr<R> Function(Rotate90DegreesLeft) rotate90DegreesLeft,
      @required FutureOr<R> Function(Orientation) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Orientation.ToDefault:
        if (toDefault == null) break;
        return toDefault(this as ToDefault);
      case _Orientation.Horizontally:
        if (horizontally == null) break;
        return horizontally(this as Horizontally);
      case _Orientation.HorizontallyAndVertically:
        if (horizontallyAndVertically == null) break;
        return horizontallyAndVertically(this as HorizontallyAndVertically);
      case _Orientation.Vertically:
        if (vertically == null) break;
        return vertically(this as Vertically);
      case _Orientation.HorizontallyAndRotate90DegreeLeft:
        if (horizontallyAndRotate90DegreeLeft == null) break;
        return horizontallyAndRotate90DegreeLeft(
            this as HorizontallyAndRotate90DegreeLeft);
      case _Orientation.Degrees90TowardsRight:
        if (degrees90TowardsRight == null) break;
        return degrees90TowardsRight(this as Degrees90TowardsRight);
      case _Orientation.HorizontallyAndRotate90DegreesRight:
        if (horizontallyAndRotate90DegreesRight == null) break;
        return horizontallyAndRotate90DegreesRight(
            this as HorizontallyAndRotate90DegreesRight);
      case _Orientation.Rotate90DegreesLeft:
        if (rotate90DegreesLeft == null) break;
        return rotate90DegreesLeft(this as Rotate90DegreesLeft);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(ToDefault) toDefault,
      FutureOr<void> Function(Horizontally) horizontally,
      FutureOr<void> Function(HorizontallyAndVertically)
          horizontallyAndVertically,
      FutureOr<void> Function(Vertically) vertically,
      FutureOr<void> Function(HorizontallyAndRotate90DegreeLeft)
          horizontallyAndRotate90DegreeLeft,
      FutureOr<void> Function(Degrees90TowardsRight) degrees90TowardsRight,
      FutureOr<void> Function(HorizontallyAndRotate90DegreesRight)
          horizontallyAndRotate90DegreesRight,
      FutureOr<void> Function(Rotate90DegreesLeft) rotate90DegreesLeft}) {
    assert(() {
      if (toDefault == null &&
          horizontally == null &&
          horizontallyAndVertically == null &&
          vertically == null &&
          horizontallyAndRotate90DegreeLeft == null &&
          degrees90TowardsRight == null &&
          horizontallyAndRotate90DegreesRight == null &&
          rotate90DegreesLeft == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _Orientation.ToDefault:
        if (toDefault == null) break;
        return toDefault(this as ToDefault);
      case _Orientation.Horizontally:
        if (horizontally == null) break;
        return horizontally(this as Horizontally);
      case _Orientation.HorizontallyAndVertically:
        if (horizontallyAndVertically == null) break;
        return horizontallyAndVertically(this as HorizontallyAndVertically);
      case _Orientation.Vertically:
        if (vertically == null) break;
        return vertically(this as Vertically);
      case _Orientation.HorizontallyAndRotate90DegreeLeft:
        if (horizontallyAndRotate90DegreeLeft == null) break;
        return horizontallyAndRotate90DegreeLeft(
            this as HorizontallyAndRotate90DegreeLeft);
      case _Orientation.Degrees90TowardsRight:
        if (degrees90TowardsRight == null) break;
        return degrees90TowardsRight(this as Degrees90TowardsRight);
      case _Orientation.HorizontallyAndRotate90DegreesRight:
        if (horizontallyAndRotate90DegreesRight == null) break;
        return horizontallyAndRotate90DegreesRight(
            this as HorizontallyAndRotate90DegreesRight);
      case _Orientation.Rotate90DegreesLeft:
        if (rotate90DegreesLeft == null) break;
        return rotate90DegreesLeft(this as Rotate90DegreesLeft);
    }
  }

  @override
  List get props => const [];
}

@immutable
class ToDefault extends Orientation {
  const ToDefault._() : super(_Orientation.ToDefault);

  factory ToDefault() {
    _instance ??= const ToDefault._();
    return _instance;
  }

  static ToDefault _instance;
}

@immutable
class Horizontally extends Orientation {
  const Horizontally._() : super(_Orientation.Horizontally);

  factory Horizontally() {
    _instance ??= const Horizontally._();
    return _instance;
  }

  static Horizontally _instance;
}

@immutable
class HorizontallyAndVertically extends Orientation {
  const HorizontallyAndVertically._()
      : super(_Orientation.HorizontallyAndVertically);

  factory HorizontallyAndVertically() {
    _instance ??= const HorizontallyAndVertically._();
    return _instance;
  }

  static HorizontallyAndVertically _instance;
}

@immutable
class Vertically extends Orientation {
  const Vertically._() : super(_Orientation.Vertically);

  factory Vertically() {
    _instance ??= const Vertically._();
    return _instance;
  }

  static Vertically _instance;
}

@immutable
class HorizontallyAndRotate90DegreeLeft extends Orientation {
  const HorizontallyAndRotate90DegreeLeft._()
      : super(_Orientation.HorizontallyAndRotate90DegreeLeft);

  factory HorizontallyAndRotate90DegreeLeft() {
    _instance ??= const HorizontallyAndRotate90DegreeLeft._();
    return _instance;
  }

  static HorizontallyAndRotate90DegreeLeft _instance;
}

@immutable
class Degrees90TowardsRight extends Orientation {
  const Degrees90TowardsRight._() : super(_Orientation.Degrees90TowardsRight);

  factory Degrees90TowardsRight() {
    _instance ??= const Degrees90TowardsRight._();
    return _instance;
  }

  static Degrees90TowardsRight _instance;
}

@immutable
class HorizontallyAndRotate90DegreesRight extends Orientation {
  const HorizontallyAndRotate90DegreesRight._()
      : super(_Orientation.HorizontallyAndRotate90DegreesRight);

  factory HorizontallyAndRotate90DegreesRight() {
    _instance ??= const HorizontallyAndRotate90DegreesRight._();
    return _instance;
  }

  static HorizontallyAndRotate90DegreesRight _instance;
}

@immutable
class Rotate90DegreesLeft extends Orientation {
  const Rotate90DegreesLeft._() : super(_Orientation.Rotate90DegreesLeft);

  factory Rotate90DegreesLeft() {
    _instance ??= const Rotate90DegreesLeft._();
    return _instance;
  }

  static Rotate90DegreesLeft _instance;
}
