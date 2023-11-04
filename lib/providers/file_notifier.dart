import 'package:diw/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'file_notifier.g.dart';

@riverpod
FutureOr<String> pictureUrl(PictureUrlRef ref, String storagePath) async {
  final storage = FirebaseStorage.instance;
  final ref = storage.ref(storagePath);
  logger.d(await ref.getDownloadURL());
  return ref.getDownloadURL();
}

@riverpod
class FileNotifier extends _$FileNotifier {
  @override
  void build() {
    return;
  }

  ///Prompts the user to pick a file, will return null if unsuccessful.
  Future<XFile?> pickFile() async {
    throw UnimplementedError(); //TODO
  }

  ///Take an XFile Object and uploads it to firebase storage. Returns the associated reference.
  Future<Reference> uploadFile(XFile file ,FileCollection fileCollection ,String fileName) async {
    throw UnimplementedError(); // TODO
  }
}

extension XFileUtils on XFile {
  String get extension {
    return name.split(".").last;
  }
}

enum FileCollection {
  shoppingList("shoppingListPictures"), profilePicture("profilePictures");

  final String collectionName;

  const FileCollection(this.collectionName);
}