// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pictureUrlHash() => r'275b50e80b592a5e78634a3b71f8561604625344';

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

/// See also [pictureUrl].
@ProviderFor(pictureUrl)
const pictureUrlProvider = PictureUrlFamily();

/// See also [pictureUrl].
class PictureUrlFamily extends Family<AsyncValue<String>> {
  /// See also [pictureUrl].
  const PictureUrlFamily();

  /// See also [pictureUrl].
  PictureUrlProvider call(
    String storagePath,
  ) {
    return PictureUrlProvider(
      storagePath,
    );
  }

  @override
  PictureUrlProvider getProviderOverride(
    covariant PictureUrlProvider provider,
  ) {
    return call(
      provider.storagePath,
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
  String? get name => r'pictureUrlProvider';
}

/// See also [pictureUrl].
class PictureUrlProvider extends FutureProvider<String> {
  /// See also [pictureUrl].
  PictureUrlProvider(
    String storagePath,
  ) : this._internal(
          (ref) => pictureUrl(
            ref as PictureUrlRef,
            storagePath,
          ),
          from: pictureUrlProvider,
          name: r'pictureUrlProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$pictureUrlHash,
          dependencies: PictureUrlFamily._dependencies,
          allTransitiveDependencies:
              PictureUrlFamily._allTransitiveDependencies,
          storagePath: storagePath,
        );

  PictureUrlProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.storagePath,
  }) : super.internal();

  final String storagePath;

  @override
  Override overrideWith(
    FutureOr<String> Function(PictureUrlRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PictureUrlProvider._internal(
        (ref) => create(ref as PictureUrlRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        storagePath: storagePath,
      ),
    );
  }

  @override
  FutureProviderElement<String> createElement() {
    return _PictureUrlProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PictureUrlProvider && other.storagePath == storagePath;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, storagePath.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PictureUrlRef on FutureProviderRef<String> {
  /// The parameter `storagePath` of this provider.
  String get storagePath;
}

class _PictureUrlProviderElement extends FutureProviderElement<String>
    with PictureUrlRef {
  _PictureUrlProviderElement(super.provider);

  @override
  String get storagePath => (origin as PictureUrlProvider).storagePath;
}

String _$fileNotifierHash() => r'1f9155644333aafbe5c50e24652bee4d6140300d';

/// See also [FileNotifier].
@ProviderFor(FileNotifier)
final fileNotifierProvider =
    AutoDisposeNotifierProvider<FileNotifier, void>.internal(
  FileNotifier.new,
  name: r'fileNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fileNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FileNotifier = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
