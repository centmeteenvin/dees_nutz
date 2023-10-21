import 'package:diw/main.dart';
import 'package:diw/models/person.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentSelectedPersonProvider = StateProvider<Person?>((ref) {
  return null;
});

final pictureProvider = FutureProvider.family<String, String>((ref, path) async {
  final storage = FirebaseStorage.instance;
  final ref = storage.ref(path);
  logger.d(await ref.getDownloadURL());
  return ref.getDownloadURL();
},);
