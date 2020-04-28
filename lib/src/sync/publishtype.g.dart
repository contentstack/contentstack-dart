// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publishtype.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class PublishType extends Equatable {
  const PublishType(this._type);

  factory PublishType.assetPublished() = AssetPublished;

  factory PublishType.entryPublished() = EntryPublished;

  factory PublishType.assetUnpublished() = AssetUnpublished;

  factory PublishType.assetDeleted() = AssetDeleted;

  factory PublishType.entryUnpublished() = EntryUnpublished;

  factory PublishType.entryDeleted() = EntryDeleted;

  factory PublishType.contentTypeDeleted() = ContentTypeDeleted;

  final _PublishType _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(AssetPublished) assetPublished,
      @required R Function(EntryPublished) entryPublished,
      @required R Function(AssetUnpublished) assetUnpublished,
      @required R Function(AssetDeleted) assetDeleted,
      @required R Function(EntryUnpublished) entryUnpublished,
      @required R Function(EntryDeleted) entryDeleted,
      @required R Function(ContentTypeDeleted) contentTypeDeleted}) {
    assert(() {
      if (assetPublished == null ||
          entryPublished == null ||
          assetUnpublished == null ||
          assetDeleted == null ||
          entryUnpublished == null ||
          entryDeleted == null ||
          contentTypeDeleted == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _PublishType.AssetPublished:
        return assetPublished(this as AssetPublished);
      case _PublishType.EntryPublished:
        return entryPublished(this as EntryPublished);
      case _PublishType.AssetUnpublished:
        return assetUnpublished(this as AssetUnpublished);
      case _PublishType.AssetDeleted:
        return assetDeleted(this as AssetDeleted);
      case _PublishType.EntryUnpublished:
        return entryUnpublished(this as EntryUnpublished);
      case _PublishType.EntryDeleted:
        return entryDeleted(this as EntryDeleted);
      case _PublishType.ContentTypeDeleted:
        return contentTypeDeleted(this as ContentTypeDeleted);
    }
  }

//ignore: missing_return
  Future<R> asyncWhen<R>(
      {@required FutureOr<R> Function(AssetPublished) assetPublished,
      @required FutureOr<R> Function(EntryPublished) entryPublished,
      @required FutureOr<R> Function(AssetUnpublished) assetUnpublished,
      @required FutureOr<R> Function(AssetDeleted) assetDeleted,
      @required FutureOr<R> Function(EntryUnpublished) entryUnpublished,
      @required FutureOr<R> Function(EntryDeleted) entryDeleted,
      @required FutureOr<R> Function(ContentTypeDeleted) contentTypeDeleted}) {
    assert(() {
      if (assetPublished == null ||
          entryPublished == null ||
          assetUnpublished == null ||
          assetDeleted == null ||
          entryUnpublished == null ||
          entryDeleted == null ||
          contentTypeDeleted == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _PublishType.AssetPublished:
        return assetPublished(this as AssetPublished);
      case _PublishType.EntryPublished:
        return entryPublished(this as EntryPublished);
      case _PublishType.AssetUnpublished:
        return assetUnpublished(this as AssetUnpublished);
      case _PublishType.AssetDeleted:
        return assetDeleted(this as AssetDeleted);
      case _PublishType.EntryUnpublished:
        return entryUnpublished(this as EntryUnpublished);
      case _PublishType.EntryDeleted:
        return entryDeleted(this as EntryDeleted);
      case _PublishType.ContentTypeDeleted:
        return contentTypeDeleted(this as ContentTypeDeleted);
    }
  }

  R whenOrElse<R>(
      {R Function(AssetPublished) assetPublished,
      R Function(EntryPublished) entryPublished,
      R Function(AssetUnpublished) assetUnpublished,
      R Function(AssetDeleted) assetDeleted,
      R Function(EntryUnpublished) entryUnpublished,
      R Function(EntryDeleted) entryDeleted,
      R Function(ContentTypeDeleted) contentTypeDeleted,
      @required R Function(PublishType) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _PublishType.AssetPublished:
        if (assetPublished == null) break;
        return assetPublished(this as AssetPublished);
      case _PublishType.EntryPublished:
        if (entryPublished == null) break;
        return entryPublished(this as EntryPublished);
      case _PublishType.AssetUnpublished:
        if (assetUnpublished == null) break;
        return assetUnpublished(this as AssetUnpublished);
      case _PublishType.AssetDeleted:
        if (assetDeleted == null) break;
        return assetDeleted(this as AssetDeleted);
      case _PublishType.EntryUnpublished:
        if (entryUnpublished == null) break;
        return entryUnpublished(this as EntryUnpublished);
      case _PublishType.EntryDeleted:
        if (entryDeleted == null) break;
        return entryDeleted(this as EntryDeleted);
      case _PublishType.ContentTypeDeleted:
        if (contentTypeDeleted == null) break;
        return contentTypeDeleted(this as ContentTypeDeleted);
    }
    return orElse(this);
  }

  Future<R> asyncWhenOrElse<R>(
      {FutureOr<R> Function(AssetPublished) assetPublished,
      FutureOr<R> Function(EntryPublished) entryPublished,
      FutureOr<R> Function(AssetUnpublished) assetUnpublished,
      FutureOr<R> Function(AssetDeleted) assetDeleted,
      FutureOr<R> Function(EntryUnpublished) entryUnpublished,
      FutureOr<R> Function(EntryDeleted) entryDeleted,
      FutureOr<R> Function(ContentTypeDeleted) contentTypeDeleted,
      @required FutureOr<R> Function(PublishType) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _PublishType.AssetPublished:
        if (assetPublished == null) break;
        return assetPublished(this as AssetPublished);
      case _PublishType.EntryPublished:
        if (entryPublished == null) break;
        return entryPublished(this as EntryPublished);
      case _PublishType.AssetUnpublished:
        if (assetUnpublished == null) break;
        return assetUnpublished(this as AssetUnpublished);
      case _PublishType.AssetDeleted:
        if (assetDeleted == null) break;
        return assetDeleted(this as AssetDeleted);
      case _PublishType.EntryUnpublished:
        if (entryUnpublished == null) break;
        return entryUnpublished(this as EntryUnpublished);
      case _PublishType.EntryDeleted:
        if (entryDeleted == null) break;
        return entryDeleted(this as EntryDeleted);
      case _PublishType.ContentTypeDeleted:
        if (contentTypeDeleted == null) break;
        return contentTypeDeleted(this as ContentTypeDeleted);
    }
    return orElse(this);
  }

//ignore: missing_return
  Future<void> whenPartial(
      {FutureOr<void> Function(AssetPublished) assetPublished,
      FutureOr<void> Function(EntryPublished) entryPublished,
      FutureOr<void> Function(AssetUnpublished) assetUnpublished,
      FutureOr<void> Function(AssetDeleted) assetDeleted,
      FutureOr<void> Function(EntryUnpublished) entryUnpublished,
      FutureOr<void> Function(EntryDeleted) entryDeleted,
      FutureOr<void> Function(ContentTypeDeleted) contentTypeDeleted}) {
    assert(() {
      if (assetPublished == null &&
          entryPublished == null &&
          assetUnpublished == null &&
          assetDeleted == null &&
          entryUnpublished == null &&
          entryDeleted == null &&
          contentTypeDeleted == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _PublishType.AssetPublished:
        if (assetPublished == null) break;
        return assetPublished(this as AssetPublished);
      case _PublishType.EntryPublished:
        if (entryPublished == null) break;
        return entryPublished(this as EntryPublished);
      case _PublishType.AssetUnpublished:
        if (assetUnpublished == null) break;
        return assetUnpublished(this as AssetUnpublished);
      case _PublishType.AssetDeleted:
        if (assetDeleted == null) break;
        return assetDeleted(this as AssetDeleted);
      case _PublishType.EntryUnpublished:
        if (entryUnpublished == null) break;
        return entryUnpublished(this as EntryUnpublished);
      case _PublishType.EntryDeleted:
        if (entryDeleted == null) break;
        return entryDeleted(this as EntryDeleted);
      case _PublishType.ContentTypeDeleted:
        if (contentTypeDeleted == null) break;
        return contentTypeDeleted(this as ContentTypeDeleted);
    }
  }

  @override
  List get props => const [];
}

@immutable
class AssetPublished extends PublishType {
  const AssetPublished._() : super(_PublishType.AssetPublished);

  factory AssetPublished() {
    _instance ??= const AssetPublished._();
    return _instance;
  }

  static AssetPublished _instance;
}

@immutable
class EntryPublished extends PublishType {
  const EntryPublished._() : super(_PublishType.EntryPublished);

  factory EntryPublished() {
    _instance ??= const EntryPublished._();
    return _instance;
  }

  static EntryPublished _instance;
}

@immutable
class AssetUnpublished extends PublishType {
  const AssetUnpublished._() : super(_PublishType.AssetUnpublished);

  factory AssetUnpublished() {
    _instance ??= const AssetUnpublished._();
    return _instance;
  }

  static AssetUnpublished _instance;
}

@immutable
class AssetDeleted extends PublishType {
  const AssetDeleted._() : super(_PublishType.AssetDeleted);

  factory AssetDeleted() {
    _instance ??= const AssetDeleted._();
    return _instance;
  }

  static AssetDeleted _instance;
}

@immutable
class EntryUnpublished extends PublishType {
  const EntryUnpublished._() : super(_PublishType.EntryUnpublished);

  factory EntryUnpublished() {
    _instance ??= const EntryUnpublished._();
    return _instance;
  }

  static EntryUnpublished _instance;
}

@immutable
class EntryDeleted extends PublishType {
  const EntryDeleted._() : super(_PublishType.EntryDeleted);

  factory EntryDeleted() {
    _instance ??= const EntryDeleted._();
    return _instance;
  }

  static EntryDeleted _instance;
}

@immutable
class ContentTypeDeleted extends PublishType {
  const ContentTypeDeleted._() : super(_PublishType.ContentTypeDeleted);

  factory ContentTypeDeleted() {
    _instance ??= const ContentTypeDeleted._();
    return _instance;
  }

  static ContentTypeDeleted _instance;
}
