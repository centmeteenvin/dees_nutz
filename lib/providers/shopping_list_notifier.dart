import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diw/main.dart';
import 'package:diw/models/item.dart';
import 'package:diw/models/person.dart';
import 'package:diw/models/shopping_list.dart';
import 'package:diw/providers/item_notifier.dart';
import 'package:diw/providers/person_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'shopping_list_notifier.g.dart';

@Riverpod(keepAlive: true)
Stream<ShoppingList> shoppingList(ShoppingListRef ref, String id) {
  final shoppingListNotifier = ref.read(shoppingListNotifierProvider.notifier);
  return shoppingListNotifier.getShoppingList(id);
}

@Riverpod(keepAlive: true)
class ShoppingListNotifier extends _$ShoppingListNotifier {
  @override
  void build() {
    return;
  }

  final collectionRef = FirebaseFirestore.instance.collection("shoppingLists");

  Future<ShoppingList> create({required String title, required DateTime date, required String picture, required List<Person> participants}) async {
    final shoppingList = ShoppingList(
      id: const Uuid().v4(),
      title: title,
      date: date,
      picture: picture,
      participantEntries: participants.map((person) => ShoppingListParticipantEntry(participantId: person.id, currentCost: 0)).toList(),
      total: 0,
    );
    await collectionRef.doc(shoppingList.id).set(shoppingList.toJson());
    final personNotifier = ref.read(personNotifierProvider.notifier);
    for (Person person in participants) {
      await personNotifier.addShoppingList(person, shoppingList.id);
    }
    return shoppingList;
  }

  Stream<ShoppingList> getShoppingList(String id) {
    final doc = collectionRef.doc(id);
    final snapshots = doc.snapshots();
    return snapshots.map((snapshot) {
      logger.d(snapshot.data());
      return ShoppingList.fromJson(snapshot.data()!);
    });
  }

  Future<void> addPersonToShoppingList(ShoppingList shoppingList, Person person) async {
    final participantList = List.of(shoppingList.participantEntries);
    if (!participantList.any(
      (entry) => entry.participantId == person.id,
    )) {
      participantList.add(ShoppingListParticipantEntry(participantId: person.id, currentCost: 0));
    }
    final List<Item> items = await Future.wait(shoppingList.itemIds.map((itemId) async {
      return await ref.read(ItemProvider(itemId).future);
    }));
    final itemNotifier = ref.read(itemNotifierProvider.notifier);
    await Future.wait(items.map(
      (item) {
        return itemNotifier.addPerson(item, person);
      },
    ));

    await ref.read(personNotifierProvider.notifier).addShoppingList(person, shoppingList.id);
    return await recalculate(shoppingList.copyWith(participantEntries: participantList));
  }

  void removePersonFromList(ShoppingList shoppingList, Person person) async {
    final participantList = List.of(shoppingList.participantEntries);
    participantList.removeWhere((entry) => entry.participantId == person.id);
    await ref.read(personNotifierProvider.notifier).removeShoppingList(person, shoppingList.id);
    final List<Item> items = await Future.wait(shoppingList.itemIds.map((itemId) async => await ref.read(itemProvider(itemId).future)));
    final itemNotifier = ref.read(itemNotifierProvider.notifier);
    await Future.wait(items.map(
      (item) {
        return itemNotifier.removePerson(item, person);
      },
    ));
    return await recalculate(shoppingList.copyWith(participantEntries: participantList));
  }

  Future<void> addItemToShoppingList(ShoppingList shoppingList, Item item) async {
    final itemList = List.of(shoppingList.itemIds);
    if (!itemList.contains(item.id)) {
      itemList.add(item.id);
    }

    await ref.read(itemNotifierProvider.notifier).addShoppingList(item, shoppingList);
    await collectionRef.doc(shoppingList.id).set(shoppingList.copyWith(itemIds: itemList, total: shoppingList.total + item.price).toJson());
  }

  Future<void> recalculate(ShoppingList shoppingList) async {
    ShoppingList copiedShoppinglist = shoppingList.copyWith();
    final participantIds = copiedShoppinglist.participantEntries.map((entry) => entry.participantId);
    for (var personId in participantIds) {
      final person = await ref.read(personProvider(personId).future);
      copiedShoppinglist = await _recalculatePerson(copiedShoppinglist, person);
    }
    return await collectionRef.doc(shoppingList.id).set(copiedShoppinglist.toJson());
  }

  Future<ShoppingList> _recalculatePerson(ShoppingList shoppingList, Person person) async {
    double personCost = 0;
    for (final itemId in shoppingList.itemIds) {
      final item = await ref.read(itemProvider(itemId).future);
      personCost += item.calculateParticipantCost(person);
    }
    final participantEntries = List.of(shoppingList.participantEntries);
    final personEntryIndex = participantEntries.indexWhere((entry) => entry.participantId == person.id);
    final personEntry = participantEntries[personEntryIndex];
    participantEntries[personEntryIndex] = personEntry.copyWith(currentCost: personCost);
    logger.d(personCost);
    return shoppingList.copyWith(participantEntries: participantEntries);
  }
}
