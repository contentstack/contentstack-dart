// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class QueryReference extends Equatable {
  const QueryReference(this._type);

  factory QueryReference.include({@required Query query}) = Include;

  factory QueryReference.notInclude({@required Query query}) = NotInclude;

  final _QueryReference _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(Include) include,
      @required R Function(NotInclude) notInclude}) {
    assert(() {
      if (include == null || notInclude == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _QueryReference.Include:
        return include(this as Include);
      case _QueryReference.NotInclude:
        return notInclude(this as NotInclude);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(Include) include,
      @required FutureOr<R> Function(NotInclude) notInclude}) {
    assert(() {
      if (include == null || notInclude == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _QueryReference.Include:
        return include(this as Include);
      case _QueryReference.NotInclude:
        return notInclude(this as NotInclude);
    }
  }

  R whenOrElse<R>(
      {R Function(Include) include,
      R Function(NotInclude) notInclude,
      @required R Function(QueryReference) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _QueryReference.Include:
        if (include == null) break;
        return include(this as Include);
      case _QueryReference.NotInclude:
        if (notInclude == null) break;
        return notInclude(this as NotInclude);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(Include) include,
      FutureOr<R> Function(NotInclude) notInclude,
      @required FutureOr<R> Function(QueryReference) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _QueryReference.Include:
        if (include == null) break;
        return include(this as Include);
      case _QueryReference.NotInclude:
        if (notInclude == null) break;
        return notInclude(this as NotInclude);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(Include) include,
      FutureOr<void> Function(NotInclude) notInclude}) {
    assert(() {
      if (include == null && notInclude == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _QueryReference.Include:
        if (include == null) break;
        return include(this as Include);
      case _QueryReference.NotInclude:
        if (notInclude == null) break;
        return notInclude(this as NotInclude);
    }
  }

  @override
  List get props => const [];
}

@immutable
class Include extends QueryReference {
  const Include({@required this.query}) : super(_QueryReference.Include);

  final Query query;

  @override
  String toString() => 'Include(query:${this.query})';
  @override
  List get props => [query];
}

@immutable
class NotInclude extends QueryReference {
  const NotInclude({@required this.query}) : super(_QueryReference.NotInclude);

  final Query query;

  @override
  String toString() => 'NotInclude(query:${this.query})';
  @override
  List get props => [query];
}
