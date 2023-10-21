import 'package:diw/main.dart';
import 'package:diw/models/person.dart';
import 'package:diw/providers/person_notifier.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentSelectedPersonProviderId = StateProvider<String?>((ref) {
  return null;
});

final currentSelectedPersonProvider = FutureProvider<Person?>((ref) async {
  final currentSelectedPersonId = ref.watch(currentSelectedPersonProviderId);
  if (currentSelectedPersonId == null) return null;
  return await ref.watch(personProvider(currentSelectedPersonId).future);
});

final pictureProvider = FutureProvider.family<String, String>((ref, path) async {
  final storage = FirebaseStorage.instance;
  final ref = storage.ref(path);
  logger.d(await ref.getDownloadURL());
  return ref.getDownloadURL();
},);
