// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$itemHash() => r'ad0daca1c09885d4493b65fc78d1dbf9e5eea1f7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [item].
@ProviderFor(item)
const itemProvider = ItemFamily();

/// See also [item].
class ItemFamily extends Family<AsyncValue<Item>> {
  /// See also [item].
  const ItemFamily();

  /// See also [item].
  ItemProvider call(
    String itemId,
  ) {
    return ItemProvider(
      itemId,
    );
  }

  @override
  ItemProvider getProviderOverride(
    covariant ItemProvider provider,
  ) {
    return call(
      provider.itemId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'itemProvider';
}

/// See also [item].
class ItemProvider extends StreamProvider<Item> {
  /// See also [item].
  ItemProvider(
    String itemId,
  ) : this._internal(
          (ref) => item(
            ref as ItemRef,
            itemId,
          ),
          from: itemProvider,
          name: r'itemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$itemHash,
          dependencies: ItemFamily._dependencies,
          allTransitiveDependencies: ItemFamily._allTransitiveDependencies,
          itemId: itemId,
        );

  ItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.itemId,
  }) : super.internal();

  final String itemId;

  @override
  Override overrideWith(
    Stream<Item> Function(ItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ItemProvider._internal(
        (ref) => create(ref as ItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        itemId: itemId,
      ),
    );
  }

  @override
  StreamProviderElement<Item> createElement() {
    return _ItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemProvider && other.itemId == itemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, itemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ItemRef on StreamProviderRef<Item> {
  /// The parameter `itemId` of this provider.
  String get itemId;
}

class _ItemProviderElement extends StreamProviderElement<Item> with ItemRef {
  _ItemProviderElement(super.provider);

  @override
  String get itemId => (origin as ItemProvider).itemId;
}

String _$itemNotifierHash() => r'3af0b033c0daa264d5fd3a97f61ffb4c1888b307';

/// See also [ItemNotifier].
@ProviderFor(ItemNotifier)
final itemNotifierProvider = NotifierProvider<ItemNotifier, void>.internal(
  ItemNotifier.new,
  name: r'itemNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$itemNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ItemNotifier = Notifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
