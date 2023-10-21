// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shopping_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ShoppingList _$ShoppingListFromJson(Map<String, dynamic> json) {
  return _ShoppingList.fromJson(json);
}

/// @nodoc
mixin _$ShoppingList {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  List<String> get itemIds => throw _privateConstructorUsedError;
  List<ShoppingListParticipantEntry> get participantEntries =>
      throw _privateConstructorUsedError;
  String get picture => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShoppingListCopyWith<ShoppingList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShoppingListCopyWith<$Res> {
  factory $ShoppingListCopyWith(
          ShoppingList value, $Res Function(ShoppingList) then) =
      _$ShoppingListCopyWithImpl<$Res, ShoppingList>;
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime date,
      List<String> itemIds,
      List<ShoppingListParticipantEntry> participantEntries,
      String picture,
      double total});
}

/// @nodoc
class _$ShoppingListCopyWithImpl<$Res, $Val extends ShoppingList>
    implements $ShoppingListCopyWith<$Res> {
  _$ShoppingListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? date = null,
    Object? itemIds = null,
    Object? participantEntries = null,
    Object? picture = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      itemIds: null == itemIds
          ? _value.itemIds
          : itemIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      participantEntries: null == participantEntries
          ? _value.participantEntries
          : participantEntries // ignore: cast_nullable_to_non_nullable
              as List<ShoppingListParticipantEntry>,
      picture: null == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShoppingListImplCopyWith<$Res>
    implements $ShoppingListCopyWith<$Res> {
  factory _$$ShoppingListImplCopyWith(
          _$ShoppingListImpl value, $Res Function(_$ShoppingListImpl) then) =
      __$$ShoppingListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime date,
      List<String> itemIds,
      List<ShoppingListParticipantEntry> participantEntries,
      String picture,
      double total});
}

/// @nodoc
class __$$ShoppingListImplCopyWithImpl<$Res>
    extends _$ShoppingListCopyWithImpl<$Res, _$ShoppingListImpl>
    implements _$$ShoppingListImplCopyWith<$Res> {
  __$$ShoppingListImplCopyWithImpl(
      _$ShoppingListImpl _value, $Res Function(_$ShoppingListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? date = null,
    Object? itemIds = null,
    Object? participantEntries = null,
    Object? picture = null,
    Object? total = null,
  }) {
    return _then(_$ShoppingListImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      itemIds: null == itemIds
          ? _value._itemIds
          : itemIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      participantEntries: null == participantEntries
          ? _value._participantEntries
          : participantEntries // ignore: cast_nullable_to_non_nullable
              as List<ShoppingListParticipantEntry>,
      picture: null == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShoppingListImpl implements _ShoppingList {
  const _$ShoppingListImpl(
      {required this.id,
      required this.title,
      required this.date,
      final List<String> itemIds = const [],
      required final List<ShoppingListParticipantEntry> participantEntries,
      required this.picture,
      required this.total})
      : _itemIds = itemIds,
        _participantEntries = participantEntries;

  factory _$ShoppingListImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShoppingListImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final DateTime date;
  final List<String> _itemIds;
  @override
  @JsonKey()
  List<String> get itemIds {
    if (_itemIds is EqualUnmodifiableListView) return _itemIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemIds);
  }

  final List<ShoppingListParticipantEntry> _participantEntries;
  @override
  List<ShoppingListParticipantEntry> get participantEntries {
    if (_participantEntries is EqualUnmodifiableListView)
      return _participantEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantEntries);
  }

  @override
  final String picture;
  @override
  final double total;

  @override
  String toString() {
    return 'ShoppingList(id: $id, title: $title, date: $date, itemIds: $itemIds, participantEntries: $participantEntries, picture: $picture, total: $total)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShoppingListImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._itemIds, _itemIds) &&
            const DeepCollectionEquality()
                .equals(other._participantEntries, _participantEntries) &&
            (identical(other.picture, picture) || other.picture == picture) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      date,
      const DeepCollectionEquality().hash(_itemIds),
      const DeepCollectionEquality().hash(_participantEntries),
      picture,
      total);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShoppingListImplCopyWith<_$ShoppingListImpl> get copyWith =>
      __$$ShoppingListImplCopyWithImpl<_$ShoppingListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShoppingListImplToJson(
      this,
    );
  }
}

abstract class _ShoppingList implements ShoppingList {
  const factory _ShoppingList(
      {required final String id,
      required final String title,
      required final DateTime date,
      final List<String> itemIds,
      required final List<ShoppingListParticipantEntry> participantEntries,
      required final String picture,
      required final double total}) = _$ShoppingListImpl;

  factory _ShoppingList.fromJson(Map<String, dynamic> json) =
      _$ShoppingListImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  DateTime get date;
  @override
  List<String> get itemIds;
  @override
  List<ShoppingListParticipantEntry> get participantEntries;
  @override
  String get picture;
  @override
  double get total;
  @override
  @JsonKey(ignore: true)
  _$$ShoppingListImplCopyWith<_$ShoppingListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShoppingListParticipantEntry _$ShoppingListParticipantEntryFromJson(
    Map<String, dynamic> json) {
  return _ShoppingListParticipantEntry.fromJson(json);
}

/// @nodoc
mixin _$ShoppingListParticipantEntry {
  String get participantId => throw _privateConstructorUsedError;
  double get currentCost => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShoppingListParticipantEntryCopyWith<ShoppingListParticipantEntry>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShoppingListParticipantEntryCopyWith<$Res> {
  factory $ShoppingListParticipantEntryCopyWith(
          ShoppingListParticipantEntry value,
          $Res Function(ShoppingListParticipantEntry) then) =
      _$ShoppingListParticipantEntryCopyWithImpl<$Res,
          ShoppingListParticipantEntry>;
  @useResult
  $Res call({String participantId, double currentCost});
}

/// @nodoc
class _$ShoppingListParticipantEntryCopyWithImpl<$Res,
        $Val extends ShoppingListParticipantEntry>
    implements $ShoppingListParticipantEntryCopyWith<$Res> {
  _$ShoppingListParticipantEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? participantId = null,
    Object? currentCost = null,
  }) {
    return _then(_value.copyWith(
      participantId: null == participantId
          ? _value.participantId
          : participantId // ignore: cast_nullable_to_non_nullable
              as String,
      currentCost: null == currentCost
          ? _value.currentCost
          : currentCost // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShoppingListParticipantEntryImplCopyWith<$Res>
    implements $ShoppingListParticipantEntryCopyWith<$Res> {
  factory _$$ShoppingListParticipantEntryImplCopyWith(
          _$ShoppingListParticipantEntryImpl value,
          $Res Function(_$ShoppingListParticipantEntryImpl) then) =
      __$$ShoppingListParticipantEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String participantId, double currentCost});
}

/// @nodoc
class __$$ShoppingListParticipantEntryImplCopyWithImpl<$Res>
    extends _$ShoppingListParticipantEntryCopyWithImpl<$Res,
        _$ShoppingListParticipantEntryImpl>
    implements _$$ShoppingListParticipantEntryImplCopyWith<$Res> {
  __$$ShoppingListParticipantEntryImplCopyWithImpl(
      _$ShoppingListParticipantEntryImpl _value,
      $Res Function(_$ShoppingListParticipantEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? participantId = null,
    Object? currentCost = null,
  }) {
    return _then(_$ShoppingListParticipantEntryImpl(
      participantId: null == participantId
          ? _value.participantId
          : participantId // ignore: cast_nullable_to_non_nullable
              as String,
      currentCost: null == currentCost
          ? _value.currentCost
          : currentCost // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShoppingListParticipantEntryImpl
    implements _ShoppingListParticipantEntry {
  _$ShoppingListParticipantEntryImpl(
      {required this.participantId, required this.currentCost});

  factory _$ShoppingListParticipantEntryImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ShoppingListParticipantEntryImplFromJson(json);

  @override
  final String participantId;
  @override
  final double currentCost;

  @override
  String toString() {
    return 'ShoppingListParticipantEntry(participantId: $participantId, currentCost: $currentCost)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShoppingListParticipantEntryImpl &&
            (identical(other.participantId, participantId) ||
                other.participantId == participantId) &&
            (identical(other.currentCost, currentCost) ||
                other.currentCost == currentCost));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, participantId, currentCost);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShoppingListParticipantEntryImplCopyWith<
          _$ShoppingListParticipantEntryImpl>
      get copyWith => __$$ShoppingListParticipantEntryImplCopyWithImpl<
          _$ShoppingListParticipantEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShoppingListParticipantEntryImplToJson(
      this,
    );
  }
}

abstract class _ShoppingListParticipantEntry
    implements ShoppingListParticipantEntry {
  factory _ShoppingListParticipantEntry(
      {required final String participantId,
      required final double currentCost}) = _$ShoppingListParticipantEntryImpl;

  factory _ShoppingListParticipantEntry.fromJson(Map<String, dynamic> json) =
      _$ShoppingListParticipantEntryImpl.fromJson;

  @override
  String get participantId;
  @override
  double get currentCost;
  @override
  @JsonKey(ignore: true)
  _$$ShoppingListParticipantEntryImplCopyWith<
          _$ShoppingListParticipantEntryImpl>
      get copyWith => throw _privateConstructorUsedError;
}
