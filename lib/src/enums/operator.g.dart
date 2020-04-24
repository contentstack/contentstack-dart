// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operator.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class QueryOperator extends Equatable {
  const QueryOperator(this._type);

  factory QueryOperator.and({@required List<Query> queryObjects}) = And;

  factory QueryOperator.or({@required List<Query> queryObjects}) = Or;

  final _QueryOperator _type;

//ignore: missing_return
  R when<R>({@required R Function(And) and, @required R Function(Or) or}) {
    assert(() {
      if (and == null || or == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _QueryOperator.And:
        return and(this as And);
      case _QueryOperator.Or:
        return or(this as Or);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(And) and,
      @required FutureOr<R> Function(Or) or}) {
    assert(() {
      if (and == null || or == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _QueryOperator.And:
        return and(this as And);
      case _QueryOperator.Or:
        return or(this as Or);
    }
  }

  R whenOrElse<R>(
      {R Function(And) and,
      R Function(Or) or,
      @required R Function(QueryOperator) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _QueryOperator.And:
        if (and == null) break;
        return and(this as And);
      case _QueryOperator.Or:
        if (or == null) break;
        return or(this as Or);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(And) and,
      FutureOr<R> Function(Or) or,
      @required FutureOr<R> Function(QueryOperator) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _QueryOperator.And:
        if (and == null) break;
        return and(this as And);
      case _QueryOperator.Or:
        if (or == null) break;
        return or(this as Or);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(And) and, FutureOr<void> Function(Or) or}) {
    assert(() {
      if (and == null && or == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _QueryOperator.And:
        if (and == null) break;
        return and(this as And);
      case _QueryOperator.Or:
        if (or == null) break;
        return or(this as Or);
    }
  }

  @override
  List get props => const [];
}

@immutable
class And extends QueryOperator {
  const And({@required this.queryObjects}) : super(_QueryOperator.And);

  final List<Query> queryObjects;

  @override
  String toString() => 'And(queryObjects:${this.queryObjects})';
  @override
  List get props => [queryObjects];
}

@immutable
class Or extends QueryOperator {
  const Or({@required this.queryObjects}) : super(_QueryOperator.Or);

  final List<Query> queryObjects;

  @override
  String toString() => 'Or(queryObjects:${this.queryObjects})';
  @override
  List get props => [queryObjects];
}
