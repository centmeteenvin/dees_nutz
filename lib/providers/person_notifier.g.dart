// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$personHash() => r'442b525712600452f5289649b23ac60a7c3051aa';

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

/// See also [person].
@ProviderFor(person)
const personProvider = PersonFamily();

/// See also [person].
class PersonFamily extends Family<AsyncValue<Person>> {
  /// See also [person].
  const PersonFamily();

  /// See also [person].
  PersonProvider call(
    String id,
  ) {
    return PersonProvider(
      id,
    );
  }

  @override
  PersonProvider getProviderOverride(
    covariant PersonProvider provider,
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
  String? get name => r'personProvider';
}

/// See also [person].
class PersonProvider extends StreamProvider<Person> {
  /// See also [person].
  PersonProvider(
    String id,
  ) : this._internal(
          (ref) => person(
            ref as PersonRef,
            id,
          ),
          from: personProvider,
          name: r'personProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$personHash,
          dependencies: PersonFamily._dependencies,
          allTransitiveDependencies: PersonFamily._allTransitiveDependencies,
          id: id,
        );

  PersonProvider._internal(
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
    Stream<Person> Function(PersonRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PersonProvider._internal(
        (ref) => create(ref as PersonRef),
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
  StreamProviderElement<Person> createElement() {
    return _PersonProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PersonProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PersonRef on StreamProviderRef<Person> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PersonProviderElement extends StreamProviderElement<Person>
    with PersonRef {
  _PersonProviderElement(super.provider);

  @override
  String get id => (origin as PersonProvider).id;
}

String _$personsHash() => r'e9e36a6aa9d411e64aeb98da0e4cf3e26d50b3d9';

/// See also [persons].
@ProviderFor(persons)
final personsProvider = AutoDisposeStreamProvider<List<Person>>.internal(
  persons,
  name: r'personsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$personsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PersonsRef = AutoDisposeStreamProviderRef<List<Person>>;
String _$personNotifierHash() => r'0d7ad7b772f74815cfb3897b037c0a20e52f1c45';

/// See also [PersonNotifier].
@ProviderFor(PersonNotifier)
final personNotifierProvider = NotifierProvider<PersonNotifier, void>.internal(
  PersonNotifier.new,
  name: r'personNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$personNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PersonNotifier = Notifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
