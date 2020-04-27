// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class Filter extends Equatable {
  const Filter(this._type);

  factory Filter.nearest() = Nearest;

  factory Filter.bilinear() = Bilinear;

  factory Filter.bicubic() = Bicubic;

  factory Filter.lanczos() = Lanczos;

  final _Filter _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(Nearest) nearest,
      @required R Function(Bilinear) bilinear,
      @required R Function(Bicubic) bicubic,
      @required R Function(Lanczos) lanczos}) {
    assert(() {
      if (nearest == null ||
          bilinear == null ||
          bicubic == null ||
          lanczos == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Filter.Nearest:
        return nearest(this as Nearest);
      case _Filter.Bilinear:
        return bilinear(this as Bilinear);
      case _Filter.Bicubic:
        return bicubic(this as Bicubic);
      case _Filter.Lanczos:
        return lanczos(this as Lanczos);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(Nearest) nearest,
      @required FutureOr<R> Function(Bilinear) bilinear,
      @required FutureOr<R> Function(Bicubic) bicubic,
      @required FutureOr<R> Function(Lanczos) lanczos}) {
    assert(() {
      if (nearest == null ||
          bilinear == null ||
          bicubic == null ||
          lanczos == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Filter.Nearest:
        return nearest(this as Nearest);
      case _Filter.Bilinear:
        return bilinear(this as Bilinear);
      case _Filter.Bicubic:
        return bicubic(this as Bicubic);
      case _Filter.Lanczos:
        return lanczos(this as Lanczos);
    }
  }

  R whenOrElse<R>(
      {R Function(Nearest) nearest,
      R Function(Bilinear) bilinear,
      R Function(Bicubic) bicubic,
      R Function(Lanczos) lanczos,
      @required R Function(Filter) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Filter.Nearest:
        if (nearest == null) break;
        return nearest(this as Nearest);
      case _Filter.Bilinear:
        if (bilinear == null) break;
        return bilinear(this as Bilinear);
      case _Filter.Bicubic:
        if (bicubic == null) break;
        return bicubic(this as Bicubic);
      case _Filter.Lanczos:
        if (lanczos == null) break;
        return lanczos(this as Lanczos);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(Nearest) nearest,
      FutureOr<R> Function(Bilinear) bilinear,
      FutureOr<R> Function(Bicubic) bicubic,
      FutureOr<R> Function(Lanczos) lanczos,
      @required FutureOr<R> Function(Filter) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Filter.Nearest:
        if (nearest == null) break;
        return nearest(this as Nearest);
      case _Filter.Bilinear:
        if (bilinear == null) break;
        return bilinear(this as Bilinear);
      case _Filter.Bicubic:
        if (bicubic == null) break;
        return bicubic(this as Bicubic);
      case _Filter.Lanczos:
        if (lanczos == null) break;
        return lanczos(this as Lanczos);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(Nearest) nearest,
      FutureOr<void> Function(Bilinear) bilinear,
      FutureOr<void> Function(Bicubic) bicubic,
      FutureOr<void> Function(Lanczos) lanczos}) {
    assert(() {
      if (nearest == null &&
          bilinear == null &&
          bicubic == null &&
          lanczos == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _Filter.Nearest:
        if (nearest == null) break;
        return nearest(this as Nearest);
      case _Filter.Bilinear:
        if (bilinear == null) break;
        return bilinear(this as Bilinear);
      case _Filter.Bicubic:
        if (bicubic == null) break;
        return bicubic(this as Bicubic);
      case _Filter.Lanczos:
        if (lanczos == null) break;
        return lanczos(this as Lanczos);
    }
  }

  @override
  List get props => const [];
}

@immutable
class Nearest extends Filter {
  const Nearest._() : super(_Filter.Nearest);

  factory Nearest() {
    _instance ??= const Nearest._();
    return _instance;
  }

  static Nearest _instance;
}

@immutable
class Bilinear extends Filter {
  const Bilinear._() : super(_Filter.Bilinear);

  factory Bilinear() {
    _instance ??= const Bilinear._();
    return _instance;
  }

  static Bilinear _instance;
}

@immutable
class Bicubic extends Filter {
  const Bicubic._() : super(_Filter.Bicubic);

  factory Bicubic() {
    _instance ??= const Bicubic._();
    return _instance;
  }

  static Bicubic _instance;
}

@immutable
class Lanczos extends Filter {
  const Lanczos._() : super(_Filter.Lanczos);

  factory Lanczos() {
    _instance ??= const Lanczos._();
    return _instance;
  }

  static Lanczos _instance;
}
