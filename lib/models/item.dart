import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diw/main.dart';
import 'package:diw/models/person.dart';
import 'package:diw/models/shopping_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed
class Item with _$Item {
  const factory Item({
    required String id,
    required String name,
    required double price,
    required String shoppingListId,
    required List<ItemParticipantEntry> participantEntries,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@freezed
class ItemParticipantEntry with _$ItemParticipantEntry {
  const factory ItemParticipantEntry({
    required String participantId,
    required int weight,
  }) = _ItemParticipantEntry;

  factory ItemParticipantEntry.fromJson(Map<String, dynamic> json) => _$ItemParticipantEntryFromJson(json);
}


class ItemService {
  final ref = FirebaseFirestore.instance.collection("items");

  Stream<Item> getItem(String id) {
    final snapshots = ref.doc(id).snapshots();
    return snapshots.map((snapshot) => Item.fromJson(snapshot.data()!));
  }

  Future<void> removePerson(Item item, Person person) async {
    final participantList = List.of(item.participantEntries);
    participantList.removeWhere((entry) => entry.participantId == person.id);
    return await ref.doc(item.id).set(item.copyWith(participantEntries: participantList).toJson());
  }

  Future<void> addPerson(Item item, Person person) async {
    final participantList = List.of(item.participantEntries);
    if (!participantList.any((entry) => entry.participantId == person.id)) {
      participantList.add(ItemParticipantEntry(participantId: person.id, weight: 0));
    }
    return await ref.doc(item.id).set(item.copyWith(participantEntries: participantList).toJson());
  }

  Future<void> addShoppingList(Item item, ShoppingList shoppingList) async {
    // if (item.shoppingListId == shoppingList.id) return;
    return await ref.doc(item.id).set(item.copyWith(shoppingListId: shoppingList.id).toJson());
  }

  Future<void> increaseWeight(Item item, Person person) async {
    final entryList = List.of(item.participantEntries);
    final entryIndex = entryList.indexWhere((entry) => entry.participantId == person.id);
    final originalEntry = entryList[entryIndex];
    entryList[entryIndex] = originalEntry.copyWith(weight: originalEntry.weight + 1);
    await ref.doc(item.id).set(item.copyWith(participantEntries: entryList).toJson());
  }

    Future<void> decreaseWeight(Item item, Person person) async {
    final entryList = List.of(item.participantEntries);
    final entryIndex = entryList.indexWhere((entry) => entry.participantId == person.id);
    final originalEntry = entryList[entryIndex];
    entryList[entryIndex] = originalEntry.copyWith(weight: originalEntry.weight - 1);
    await ref.doc(item.id).set(item.copyWith(participantEntries: entryList).toJson());
    final shoppingList = getIt<ShoppingListService>().getShoppingList(item.shoppingListId);
    return await getIt<ShoppingListService>().recalculate(shoppingList, person);
  }
}