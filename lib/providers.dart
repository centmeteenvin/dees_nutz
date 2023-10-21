import 'package:diw/main.dart';
import 'package:diw/models/item.dart';
import 'package:diw/models/person.dart';
import 'package:diw/models/shopping_list.dart';
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

final personsProvider = StreamProvider<List<Person>>((ref) {
  return getIt<PersonService>().getAll();
},);

final personProvider = StreamProvider.family<Person, String>((ref, id) => getIt<PersonService>().getPerson(id),);
final shoppingListProvider = StreamProvider.family<ShoppingList, String>((ref, id) => getIt<ShoppingListService>().getShoppingList(id),);
final itemProvider = StreamProvider.family<Item, String>((ref, id) => getIt<ItemService>().getItem(id));