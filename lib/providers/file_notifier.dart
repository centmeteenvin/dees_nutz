import 'package:diw/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'file_notifier.g.dart';

@riverpod
FutureOr<String> pictureUrl(PictureUrlRef ref, String storagePath) async {
  final storage = FirebaseStorage.instance;
  final ref = storage.ref(storagePath);
  logger.d(await ref.getDownloadURL());
  return ref.getDownloadURL();
}