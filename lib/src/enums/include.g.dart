// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'include_type.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class Include extends Equatable {
  const Include(this._type);

  factory Include.none({@required List<String> fieldUidList}) = None;

  factory Include.only({@required List<String> fieldUidList}) = Only;

  factory Include.except({@required List<String> fieldUidList}) = Except;

  final _Include _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(None) none,
      @required R Function(Only) only,
      @required R Function(Except) except}) {
    assert(() {
      if (none == null || only == null || except == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Include.None:
        return none(this as None);
      case _Include.Only:
        return only(this as Only);
      case _Include.Except:
        return except(this as Except);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(None) none,
      @required FutureOr<R> Function(Only) only,
      @required FutureOr<R> Function(Except) except}) {
    assert(() {
      if (none == null || only == null || except == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _Include.None:
        return none(this as None);
      case _Include.Only:
        return only(this as Only);
      case _Include.Except:
        return except(this as Except);
    }
  }

  R whenOrElse<R>(
      {R Function(None) none,
      R Function(Only) only,
      R Function(Except) except,
      @required R Function(Include) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Include.None:
        if (none == null) break;
        return none(this as None);
      case _Include.Only:
        if (only == null) break;
        return only(this as Only);
      case _Include.Except:
        if (except == null) break;
        return except(this as Except);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(None) none,
      FutureOr<R> Function(Only) only,
      FutureOr<R> Function(Except) except,
      @required FutureOr<R> Function(Include) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _Include.None:
        if (none == null) break;
        return none(this as None);
      case _Include.Only:
        if (only == null) break;
        return only(this as Only);
      case _Include.Except:
        if (except == null) break;
        return except(this as Except);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(None) none,
      FutureOr<void> Function(Only) only,
      FutureOr<void> Function(Except) except}) {
    assert(() {
      if (none == null && only == null && except == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _Include.None:
        if (none == null) break;
        return none(this as None);
      case _Include.Only:
        if (only == null) break;
        return only(this as Only);
      case _Include.Except:
        if (except == null) break;
        return except(this as Except);
    }
  }

  @override
  List get props => const [];
}

@immutable
class None extends Include {
  const None({@required this.fieldUidList}) : super(_Include.None);

  final List<String> fieldUidList;

  @override
  String toString() => 'None(fieldUidList:${this.fieldUidList})';
  @override
  List get props => [fieldUidList];
}

@immutable
class Only extends Include {
  const Only({@required this.fieldUidList}) : super(_Include.Only);

  final List<String> fieldUidList;

  @override
  String toString() => 'Only(fieldUidList:${this.fieldUidList})';
  @override
  List get props => [fieldUidList];
}

@immutable
class Except extends Include {
  const Except({@required this.fieldUidList}) : super(_Include.Except);

  final List<String> fieldUidList;

  @override
  String toString() => 'Except(fieldUidList:${this.fieldUidList})';
  @override
  List get props => [fieldUidList];
}
