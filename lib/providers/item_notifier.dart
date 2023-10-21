import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diw/models/item.dart';
import 'package:diw/models/person.dart';
import 'package:diw/models/shopping_list.dart';
import 'package:diw/providers/shopping_list_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_notifier.g.dart';

@Riverpod(keepAlive: true)
Stream<Item> item(ItemRef ref, String itemId) {
  final itemNotifier = ref.read(itemNotifierProvider.notifier);
  return itemNotifier.getItem(itemId);
}

@Riverpod(keepAlive: true)
class ItemNotifier extends _$ItemNotifier {
  final collectionRef = FirebaseFirestore.instance.collection("items");

  @override
  void build() {
    return;
  }

  Stream<Item> getItem(String id) {
    final snapshots = collectionRef.doc(id).snapshots();
    return snapshots.map((snapshot) => Item.fromJson(snapshot.data()!));
  }

  Future<void> removePerson(Item item, Person person) async {
    final participantList = List.of(item.participantEntries);
    participantList.removeWhere((entry) => entry.participantId == person.id);
    return await collectionRef.doc(item.id).set(item.copyWith(participantEntries: participantList).toJson());
  }

  Future<void> addPerson(Item item, Person person) async {
    final participantList = List.of(item.participantEntries);
    if (!participantList.any((entry) => entry.participantId == person.id)) {
      participantList.add(ItemParticipantEntry(participantId: person.id, weight: 0));
    }
    return await collectionRef.doc(item.id).set(item.copyWith(participantEntries: participantList).toJson());
  }

  Future<void> addShoppingList(Item item, ShoppingList shoppingList) async {
    // if (item.shoppingListId == shoppingList.id) return;
    return await collectionRef.doc(item.id).set(item.copyWith(shoppingListId: shoppingList.id).toJson());
  }

  Future<void> increaseWeight(Item item, Person person) async {
    final entryList = List.of(item.participantEntries);
    final entryIndex = entryList.indexWhere((entry) => entry.participantId == person.id);
    final originalEntry = entryList[entryIndex];
    entryList[entryIndex] = originalEntry.copyWith(weight: originalEntry.weight + 1);
    await collectionRef.doc(item.id).set(item.copyWith(participantEntries: entryList).toJson());
  }

  Future<void> decreaseWeight(Item item, Person person) async {
    final entryList = List.of(item.participantEntries);
    final entryIndex = entryList.indexWhere((entry) => entry.participantId == person.id);
    final originalEntry = entryList[entryIndex];
    entryList[entryIndex] = originalEntry.copyWith(weight: originalEntry.weight - 1);
    await collectionRef.doc(item.id).set(item.copyWith(participantEntries: entryList).toJson());
    final shoppingList = ref.read(shoppingListProvider(item.shoppingListId));
    // return await getIt<ShoppingListService>().recalculate(shoppingList, person); TODO
  }
}
