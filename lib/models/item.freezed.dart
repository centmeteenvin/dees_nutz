// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Item _$ItemFromJson(Map<String, dynamic> json) {
  return _Item.fromJson(json);
}

/// @nodoc
mixin _$Item {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get shoppingListId => throw _privateConstructorUsedError;
  List<ItemParticipantEntry> get participantEntries =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemCopyWith<Item> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCopyWith<$Res> {
  factory $ItemCopyWith(Item value, $Res Function(Item) then) =
      _$ItemCopyWithImpl<$Res, Item>;
  @useResult
  $Res call(
      {String id,
      String name,
      double price,
      String shoppingListId,
      List<ItemParticipantEntry> participantEntries});
}

/// @nodoc
class _$ItemCopyWithImpl<$Res, $Val extends Item>
    implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? shoppingListId = null,
    Object? participantEntries = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      shoppingListId: null == shoppingListId
          ? _value.shoppingListId
          : shoppingListId // ignore: cast_nullable_to_non_nullable
              as String,
      participantEntries: null == participantEntries
          ? _value.participantEntries
          : participantEntries // ignore: cast_nullable_to_non_nullable
              as List<ItemParticipantEntry>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemImplCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$$ItemImplCopyWith(
          _$ItemImpl value, $Res Function(_$ItemImpl) then) =
      __$$ItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double price,
      String shoppingListId,
      List<ItemParticipantEntry> participantEntries});
}

/// @nodoc
class __$$ItemImplCopyWithImpl<$Res>
    extends _$ItemCopyWithImpl<$Res, _$ItemImpl>
    implements _$$ItemImplCopyWith<$Res> {
  __$$ItemImplCopyWithImpl(_$ItemImpl _value, $Res Function(_$ItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? shoppingListId = null,
    Object? participantEntries = null,
  }) {
    return _then(_$ItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      shoppingListId: null == shoppingListId
          ? _value.shoppingListId
          : shoppingListId // ignore: cast_nullable_to_non_nullable
              as String,
      participantEntries: null == participantEntries
          ? _value._participantEntries
          : participantEntries // ignore: cast_nullable_to_non_nullable
              as List<ItemParticipantEntry>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemImpl extends _Item {
  const _$ItemImpl(
      {required this.id,
      required this.name,
      required this.price,
      required this.shoppingListId,
      required final List<ItemParticipantEntry> participantEntries})
      : _participantEntries = participantEntries,
        super._();

  factory _$ItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double price;
  @override
  final String shoppingListId;
  final List<ItemParticipantEntry> _participantEntries;
  @override
  List<ItemParticipantEntry> get participantEntries {
    if (_participantEntries is EqualUnmodifiableListView)
      return _participantEntries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantEntries);
  }

  @override
  String toString() {
    return 'Item(id: $id, name: $name, price: $price, shoppingListId: $shoppingListId, participantEntries: $participantEntries)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.shoppingListId, shoppingListId) ||
                other.shoppingListId == shoppingListId) &&
            const DeepCollectionEquality()
                .equals(other._participantEntries, _participantEntries));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, price, shoppingListId,
      const DeepCollectionEquality().hash(_participantEntries));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      __$$ItemImplCopyWithImpl<_$ItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemImplToJson(
      this,
    );
  }
}

abstract class _Item extends Item {
  const factory _Item(
          {required final String id,
          required final String name,
          required final double price,
          required final String shoppingListId,
          required final List<ItemParticipantEntry> participantEntries}) =
      _$ItemImpl;
  const _Item._() : super._();

  factory _Item.fromJson(Map<String, dynamic> json) = _$ItemImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get price;
  @override
  String get shoppingListId;
  @override
  List<ItemParticipantEntry> get participantEntries;
  @override
  @JsonKey(ignore: true)
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ItemParticipantEntry _$ItemParticipantEntryFromJson(Map<String, dynamic> json) {
  return _ItemParticipantEntry.fromJson(json);
}

/// @nodoc
mixin _$ItemParticipantEntry {
  String get participantId => throw _privateConstructorUsedError;
  int get weight => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemParticipantEntryCopyWith<ItemParticipantEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemParticipantEntryCopyWith<$Res> {
  factory $ItemParticipantEntryCopyWith(ItemParticipantEntry value,
          $Res Function(ItemParticipantEntry) then) =
      _$ItemParticipantEntryCopyWithImpl<$Res, ItemParticipantEntry>;
  @useResult
  $Res call({String participantId, int weight});
}

/// @nodoc
class _$ItemParticipantEntryCopyWithImpl<$Res,
        $Val extends ItemParticipantEntry>
    implements $ItemParticipantEntryCopyWith<$Res> {
  _$ItemParticipantEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? participantId = null,
    Object? weight = null,
  }) {
    return _then(_value.copyWith(
      participantId: null == participantId
          ? _value.participantId
          : participantId // ignore: cast_nullable_to_non_nullable
              as String,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemParticipantEntryImplCopyWith<$Res>
    implements $ItemParticipantEntryCopyWith<$Res> {
  factory _$$ItemParticipantEntryImplCopyWith(_$ItemParticipantEntryImpl value,
          $Res Function(_$ItemParticipantEntryImpl) then) =
      __$$ItemParticipantEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String participantId, int weight});
}

/// @nodoc
class __$$ItemParticipantEntryImplCopyWithImpl<$Res>
    extends _$ItemParticipantEntryCopyWithImpl<$Res, _$ItemParticipantEntryImpl>
    implements _$$ItemParticipantEntryImplCopyWith<$Res> {
  __$$ItemParticipantEntryImplCopyWithImpl(_$ItemParticipantEntryImpl _value,
      $Res Function(_$ItemParticipantEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? participantId = null,
    Object? weight = null,
  }) {
    return _then(_$ItemParticipantEntryImpl(
      participantId: null == participantId
          ? _value.participantId
          : participantId // ignore: cast_nullable_to_non_nullable
              as String,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemParticipantEntryImpl implements _ItemParticipantEntry {
  const _$ItemParticipantEntryImpl(
      {required this.participantId, required this.weight});

  factory _$ItemParticipantEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemParticipantEntryImplFromJson(json);

  @override
  final String participantId;
  @override
  final int weight;

  @override
  String toString() {
    return 'ItemParticipantEntry(participantId: $participantId, weight: $weight)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemParticipantEntryImpl &&
            (identical(other.participantId, participantId) ||
                other.participantId == participantId) &&
            (identical(other.weight, weight) || other.weight == weight));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, participantId, weight);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemParticipantEntryImplCopyWith<_$ItemParticipantEntryImpl>
      get copyWith =>
          __$$ItemParticipantEntryImplCopyWithImpl<_$ItemParticipantEntryImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemParticipantEntryImplToJson(
      this,
    );
  }
}

abstract class _ItemParticipantEntry implements ItemParticipantEntry {
  const factory _ItemParticipantEntry(
      {required final String participantId,
      required final int weight}) = _$ItemParticipantEntryImpl;

  factory _ItemParticipantEntry.fromJson(Map<String, dynamic> json) =
      _$ItemParticipantEntryImpl.fromJson;

  @override
  String get participantId;
  @override
  int get weight;
  @override
  @JsonKey(ignore: true)
  _$$ItemParticipantEntryImplCopyWith<_$ItemParticipantEntryImpl>
      get copyWith => throw _privateConstructorUsedError;
}
