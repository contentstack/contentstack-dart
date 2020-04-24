// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operations.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class QueryOperation extends Equatable {
  const QueryOperation(this._type);

  factory QueryOperation.equals({@required dynamic value}) = Equals;

  factory QueryOperation.notEquals({@required dynamic value}) = NotEquals;

  factory QueryOperation.includes({@required List<dynamic> value}) = Includes;

  factory QueryOperation.excludes({@required List<dynamic> value}) = Excludes;

  factory QueryOperation.isLessThan({@required dynamic value}) = IsLessThan;

  factory QueryOperation.isLessThanOrEqual({@required dynamic value}) =
      IsLessThanOrEqual;

  factory QueryOperation.isGreaterThan({@required dynamic value}) =
      IsGreaterThan;

  factory QueryOperation.isGreaterThanOrEqual({@required dynamic value}) =
      IsGreaterThanOrEqual;

  factory QueryOperation.exists({@required bool value}) = Exists;

  factory QueryOperation.matches({@required String regex}) = Matches;

  final _QueryOperation _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(Equals) equals,
      @required R Function(NotEquals) notEquals,
      @required R Function(Includes) includes,
      @required R Function(Excludes) excludes,
      @required R Function(IsLessThan) isLessThan,
      @required R Function(IsLessThanOrEqual) isLessThanOrEqual,
      @required R Function(IsGreaterThan) isGreaterThan,
      @required R Function(IsGreaterThanOrEqual) isGreaterThanOrEqual,
      @required R Function(Exists) exists,
      @required R Function(Matches) matches}) {
    assert(() {
      if (equals == null ||
          notEquals == null ||
          includes == null ||
          excludes == null ||
          isLessThan == null ||
          isLessThanOrEqual == null ||
          isGreaterThan == null ||
          isGreaterThanOrEqual == null ||
          exists == null ||
          matches == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _QueryOperation.Equals:
        return equals(this as Equals);
      case _QueryOperation.NotEquals:
        return notEquals(this as NotEquals);
      case _QueryOperation.Includes:
        return includes(this as Includes);
      case _QueryOperation.Excludes:
        return excludes(this as Excludes);
      case _QueryOperation.IsLessThan:
        return isLessThan(this as IsLessThan);
      case _QueryOperation.IsLessThanOrEqual:
        return isLessThanOrEqual(this as IsLessThanOrEqual);
      case _QueryOperation.IsGreaterThan:
        return isGreaterThan(this as IsGreaterThan);
      case _QueryOperation.IsGreaterThanOrEqual:
        return isGreaterThanOrEqual(this as IsGreaterThanOrEqual);
      case _QueryOperation.Exists:
        return exists(this as Exists);
      case _QueryOperation.Matches:
        return matches(this as Matches);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(Equals) equals,
      @required FutureOr<R> Function(NotEquals) notEquals,
      @required FutureOr<R> Function(Includes) includes,
      @required FutureOr<R> Function(Excludes) excludes,
      @required FutureOr<R> Function(IsLessThan) isLessThan,
      @required FutureOr<R> Function(IsLessThanOrEqual) isLessThanOrEqual,
      @required FutureOr<R> Function(IsGreaterThan) isGreaterThan,
      @required FutureOr<R> Function(IsGreaterThanOrEqual) isGreaterThanOrEqual,
      @required FutureOr<R> Function(Exists) exists,
      @required FutureOr<R> Function(Matches) matches}) {
    assert(() {
      if (equals == null ||
          notEquals == null ||
          includes == null ||
          excludes == null ||
          isLessThan == null ||
          isLessThanOrEqual == null ||
          isGreaterThan == null ||
          isGreaterThanOrEqual == null ||
          exists == null ||
          matches == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _QueryOperation.Equals:
        return equals(this as Equals);
      case _QueryOperation.NotEquals:
        return notEquals(this as NotEquals);
      case _QueryOperation.Includes:
        return includes(this as Includes);
      case _QueryOperation.Excludes:
        return excludes(this as Excludes);
      case _QueryOperation.IsLessThan:
        return isLessThan(this as IsLessThan);
      case _QueryOperation.IsLessThanOrEqual:
        return isLessThanOrEqual(this as IsLessThanOrEqual);
      case _QueryOperation.IsGreaterThan:
        return isGreaterThan(this as IsGreaterThan);
      case _QueryOperation.IsGreaterThanOrEqual:
        return isGreaterThanOrEqual(this as IsGreaterThanOrEqual);
      case _QueryOperation.Exists:
        return exists(this as Exists);
      case _QueryOperation.Matches:
        return matches(this as Matches);
    }
  }

  R whenOrElse<R>(
      {R Function(Equals) equals,
      R Function(NotEquals) notEquals,
      R Function(Includes) includes,
      R Function(Excludes) excludes,
      R Function(IsLessThan) isLessThan,
      R Function(IsLessThanOrEqual) isLessThanOrEqual,
      R Function(IsGreaterThan) isGreaterThan,
      R Function(IsGreaterThanOrEqual) isGreaterThanOrEqual,
      R Function(Exists) exists,
      R Function(Matches) matches,
      @required R Function(QueryOperation) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _QueryOperation.Equals:
        if (equals == null) break;
        return equals(this as Equals);
      case _QueryOperation.NotEquals:
        if (notEquals == null) break;
        return notEquals(this as NotEquals);
      case _QueryOperation.Includes:
        if (includes == null) break;
        return includes(this as Includes);
      case _QueryOperation.Excludes:
        if (excludes == null) break;
        return excludes(this as Excludes);
      case _QueryOperation.IsLessThan:
        if (isLessThan == null) break;
        return isLessThan(this as IsLessThan);
      case _QueryOperation.IsLessThanOrEqual:
        if (isLessThanOrEqual == null) break;
        return isLessThanOrEqual(this as IsLessThanOrEqual);
      case _QueryOperation.IsGreaterThan:
        if (isGreaterThan == null) break;
        return isGreaterThan(this as IsGreaterThan);
      case _QueryOperation.IsGreaterThanOrEqual:
        if (isGreaterThanOrEqual == null) break;
        return isGreaterThanOrEqual(this as IsGreaterThanOrEqual);
      case _QueryOperation.Exists:
        if (exists == null) break;
        return exists(this as Exists);
      case _QueryOperation.Matches:
        if (matches == null) break;
        return matches(this as Matches);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(Equals) equals,
      FutureOr<R> Function(NotEquals) notEquals,
      FutureOr<R> Function(Includes) includes,
      FutureOr<R> Function(Excludes) excludes,
      FutureOr<R> Function(IsLessThan) isLessThan,
      FutureOr<R> Function(IsLessThanOrEqual) isLessThanOrEqual,
      FutureOr<R> Function(IsGreaterThan) isGreaterThan,
      FutureOr<R> Function(IsGreaterThanOrEqual) isGreaterThanOrEqual,
      FutureOr<R> Function(Exists) exists,
      FutureOr<R> Function(Matches) matches,
      @required FutureOr<R> Function(QueryOperation) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _QueryOperation.Equals:
        if (equals == null) break;
        return equals(this as Equals);
      case _QueryOperation.NotEquals:
        if (notEquals == null) break;
        return notEquals(this as NotEquals);
      case _QueryOperation.Includes:
        if (includes == null) break;
        return includes(this as Includes);
      case _QueryOperation.Excludes:
        if (excludes == null) break;
        return excludes(this as Excludes);
      case _QueryOperation.IsLessThan:
        if (isLessThan == null) break;
        return isLessThan(this as IsLessThan);
      case _QueryOperation.IsLessThanOrEqual:
        if (isLessThanOrEqual == null) break;
        return isLessThanOrEqual(this as IsLessThanOrEqual);
      case _QueryOperation.IsGreaterThan:
        if (isGreaterThan == null) break;
        return isGreaterThan(this as IsGreaterThan);
      case _QueryOperation.IsGreaterThanOrEqual:
        if (isGreaterThanOrEqual == null) break;
        return isGreaterThanOrEqual(this as IsGreaterThanOrEqual);
      case _QueryOperation.Exists:
        if (exists == null) break;
        return exists(this as Exists);
      case _QueryOperation.Matches:
        if (matches == null) break;
        return matches(this as Matches);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(Equals) equals,
      FutureOr<void> Function(NotEquals) notEquals,
      FutureOr<void> Function(Includes) includes,
      FutureOr<void> Function(Excludes) excludes,
      FutureOr<void> Function(IsLessThan) isLessThan,
      FutureOr<void> Function(IsLessThanOrEqual) isLessThanOrEqual,
      FutureOr<void> Function(IsGreaterThan) isGreaterThan,
      FutureOr<void> Function(IsGreaterThanOrEqual) isGreaterThanOrEqual,
      FutureOr<void> Function(Exists) exists,
      FutureOr<void> Function(Matches) matches}) {
    assert(() {
      if (equals == null &&
          notEquals == null &&
          includes == null &&
          excludes == null &&
          isLessThan == null &&
          isLessThanOrEqual == null &&
          isGreaterThan == null &&
          isGreaterThanOrEqual == null &&
          exists == null &&
          matches == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _QueryOperation.Equals:
        if (equals == null) break;
        return equals(this as Equals);
      case _QueryOperation.NotEquals:
        if (notEquals == null) break;
        return notEquals(this as NotEquals);
      case _QueryOperation.Includes:
        if (includes == null) break;
        return includes(this as Includes);
      case _QueryOperation.Excludes:
        if (excludes == null) break;
        return excludes(this as Excludes);
      case _QueryOperation.IsLessThan:
        if (isLessThan == null) break;
        return isLessThan(this as IsLessThan);
      case _QueryOperation.IsLessThanOrEqual:
        if (isLessThanOrEqual == null) break;
        return isLessThanOrEqual(this as IsLessThanOrEqual);
      case _QueryOperation.IsGreaterThan:
        if (isGreaterThan == null) break;
        return isGreaterThan(this as IsGreaterThan);
      case _QueryOperation.IsGreaterThanOrEqual:
        if (isGreaterThanOrEqual == null) break;
        return isGreaterThanOrEqual(this as IsGreaterThanOrEqual);
      case _QueryOperation.Exists:
        if (exists == null) break;
        return exists(this as Exists);
      case _QueryOperation.Matches:
        if (matches == null) break;
        return matches(this as Matches);
    }
  }

  @override
  List get props => const [];
}

@immutable
class Equals extends QueryOperation {
  const Equals({@required this.value}) : super(_QueryOperation.Equals);

  final dynamic value;

  @override
  String toString() => 'Equals(value:${this.value})';
  @override
  List get props => [value];
}

@immutable
class NotEquals extends QueryOperation {
  const NotEquals({@required this.value}) : super(_QueryOperation.NotEquals);

  final dynamic value;

  @override
  String toString() => 'NotEquals(value:${this.value})';
  @override
  List get props => [value];
}

@immutable
class Includes extends QueryOperation {
  const Includes({@required this.value}) : super(_QueryOperation.Includes);

  final List<dynamic> value;

  @override
  String toString() => 'Includes(value:${this.value})';
  @override
  List get props => [value];
}

@immutable
class Excludes extends QueryOperation {
  const Excludes({@required this.value}) : super(_QueryOperation.Excludes);

  final List<dynamic> value;

  @override
  String toString() => 'Excludes(value:${this.value})';
  @override
  List get props => [value];
}

@immutable
class IsLessThan extends QueryOperation {
  const IsLessThan({@required this.value}) : super(_QueryOperation.IsLessThan);

  final dynamic value;

  @override
  String toString() => 'IsLessThan(value:${this.value})';
  @override
  List get props => [value];
}

@immutable
class IsLessThanOrEqual extends QueryOperation {
  const IsLessThanOrEqual({@required this.value})
      : super(_QueryOperation.IsLessThanOrEqual);

  final dynamic value;

  @override
  String toString() => 'IsLessThanOrEqual(value:${this.value})';
  @override
  List get props => [value];
}

@immutable
class IsGreaterThan extends QueryOperation {
  const IsGreaterThan({@required this.value})
      : super(_QueryOperation.IsGreaterThan);

  final dynamic value;

  @override
  String toString() => 'IsGreaterThan(value:${this.value})';
  @override
  List get props => [value];
}

@immutable
class IsGreaterThanOrEqual extends QueryOperation {
  const IsGreaterThanOrEqual({@required this.value})
      : super(_QueryOperation.IsGreaterThanOrEqual);

  final dynamic value;

  @override
  String toString() => 'IsGreaterThanOrEqual(value:${this.value})';
  @override
  List get props => [value];
}

@immutable
class Exists extends QueryOperation {
  const Exists({@required this.value}) : super(_QueryOperation.Exists);

  final bool value;

  @override
  String toString() => 'Exists(value:${this.value})';
  @override
  List get props => [value];
}

@immutable
class Matches extends QueryOperation {
  const Matches({@required this.regex}) : super(_QueryOperation.Matches);

  final String regex;

  @override
  String toString() => 'Matches(regex:${this.regex})';
  @override
  List get props => [regex];
}
