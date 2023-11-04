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
  late final FirebaseStorage storage;
  @override
  void build() {
    storage = FirebaseStorage.instance;
    return;
  }

  ///Prompts the user to pick a file, will return null if unsuccessful.
  Future<XFile?> pickFile() async {
    return await ImagePicker().pickImage(source: ImageSource.camera);
  }

  ///Take an XFile Object and uploads it to firebase storage. Returns the associated reference.
  ///fileName includes extension.
  Future<Reference> uploadFile(XFile file ,FileCollection fileCollection ,String fileName) async {
    final reference = storage.ref("${fileCollection.collectionName}/$fileName");
    await reference.putData(await file.readAsBytes());
    return reference;
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