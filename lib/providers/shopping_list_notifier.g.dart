// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shoppingListHash() => r'aa3024b48d3cfb509bc18537d0d560ec28beb449';

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

/// See also [shoppingList].
@ProviderFor(shoppingList)
const shoppingListProvider = ShoppingListFamily();

/// See also [shoppingList].
class ShoppingListFamily extends Family<AsyncValue<ShoppingList>> {
  /// See also [shoppingList].
  const ShoppingListFamily();

  /// See also [shoppingList].
  ShoppingListProvider call(
    String id,
  ) {
    return ShoppingListProvider(
      id,
    );
  }

  @override
  ShoppingListProvider getProviderOverride(
    covariant ShoppingListProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'shoppingListProvider';
}

/// See also [shoppingList].
class ShoppingListProvider extends StreamProvider<ShoppingList> {
  /// See also [shoppingList].
  ShoppingListProvider(
    String id,
  ) : this._internal(
          (ref) => shoppingList(
            ref as ShoppingListRef,
            id,
          ),
          from: shoppingListProvider,
          name: r'shoppingListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$shoppingListHash,
          dependencies: ShoppingListFamily._dependencies,
          allTransitiveDependencies:
              ShoppingListFamily._allTransitiveDependencies,
          id: id,
        );

  ShoppingListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Stream<ShoppingList> Function(ShoppingListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ShoppingListProvider._internal(
        (ref) => create(ref as ShoppingListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  StreamProviderElement<ShoppingList> createElement() {
    return _ShoppingListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ShoppingListProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ShoppingListRef on StreamProviderRef<ShoppingList> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ShoppingListProviderElement extends StreamProviderElement<ShoppingList>
    with ShoppingListRef {
  _ShoppingListProviderElement(super.provider);

  @override
  String get id => (origin as ShoppingListProvider).id;
}

String _$shoppingListNotifierHash() =>
    r'9c35e6f9d3a085fed650a506f74401276a73accd';

/// See also [ShoppingListNotifier].
@ProviderFor(ShoppingListNotifier)
final shoppingListNotifierProvider =
    NotifierProvider<ShoppingListNotifier, void>.internal(
  ShoppingListNotifier.new,
  name: r'shoppingListNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$shoppingListNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ShoppingListNotifier = Notifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
