import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diw/main.dart';
import 'package:diw/models/item.dart';
import 'package:diw/models/person.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'shopping_list.freezed.dart';
part 'shopping_list.g.dart';

List<String> personIdMapper(List<Person> persons) => persons.map((person) => person.id).toList();

@freezed
class ShoppingList with _$ShoppingList {
  const factory ShoppingList({
    required String id,
    required String title,
    required DateTime date,
    @Default([]) List<String> itemIds,
    required List<ShoppingListParticipantEntry> participantEntries,
    required String picture,
    required double total,
  }) = _ShoppingList;

  factory ShoppingList.fromJson(Map<String, dynamic> json) => _$ShoppingListFromJson(json);
}

@freezed
class ShoppingListParticipantEntry with _$ShoppingListParticipantEntry {
  factory ShoppingListParticipantEntry({
    required String participantId,
    required double currentCost,
  }) = _ShoppingListParticipantEntry;
	
  factory ShoppingListParticipantEntry.fromJson(Map<String, dynamic> json) =>
			_$ShoppingListParticipantEntryFromJson(json);
}


class ShoppingListService {
  final FirebaseFirestore ref = FirebaseFirestore.instance;

  Future<ShoppingList> create({required String title, required DateTime date, required String picture, required List<Person> participants}) async {
    final shoppingList = ShoppingList(
      id: const Uuid().v4(),
      title: title,
      date: date,
      picture: picture,
      participantEntries: participants.map((person) => ShoppingListParticipantEntry(participantId: person.id, currentCost: 0)).toList(),
      total: 0,
    );
    await ref.collection("shoppingLists").doc(shoppingList.id).set(shoppingList.toJson());
    // PersonService personService = getIt<PersonService>(); TODO
    for (Person person in participants) {
      await personService.addShoppingList(person, shoppingList.id);
    }
    return shoppingList;
  }

  Stream<ShoppingList> getShoppingList(String id) {
    final doc = ref.collection("shoppingLists").doc(id);
    final snapshots = doc.snapshots();
    return snapshots.map((snapshot) {
      logger.d(snapshot.data());
      return ShoppingList.fromJson(snapshot.data()!);
    });
  }

  Future<void> addPersonToShoppingList(ShoppingList shoppingList, Person person) async {
    final participantList = List.of(shoppingList.participantEntries);
    if (!participantList.any((entry) => entry.participantId == person.id,)) {
      participantList.add(ShoppingListParticipantEntry(participantId: person.id, currentCost: 0));
    }
    // final List<Item> items = await Future.wait(shoppingList.itemIds.map((itemId) async => await getIt<ItemService>().getItem(itemId).first)); TODO
    await Future.wait(items.map(
      (item) {
        // return getIt<ItemService>().addPerson(item, person); TODO
      },
    ));

    // getIt<PersonService>().addShoppingList(person, shoppingList.id); TODO
    return await ref.collection("shoppingLists").doc(shoppingList.id).set(shoppingList.copyWith(participantEntries: participantList).toJson());
  }

  void removePersonFromList(ShoppingList shoppingList, Person person) async {
    final participantList = List.of(shoppingList.participantEntries);
    participantList.removeWhere((entry) => entry.participantId == person.id);
    // getIt<PersonService>().removeShoppingList(person, shoppingList.id); TODO
    // final List<Item> items = await Future.wait(shoppingList.itemIds.map((itemId) async => await getIt<ItemService>().getItem(itemId).first)); TODO
    await Future.wait(items.map(
      (item) {
        // return getIt<ItemService>().removePerson(item, person); TODO
      },
    ));
    return await ref.collection("shoppingLists").doc(shoppingList.id).set(shoppingList.copyWith(participantEntries: participantList).toJson());
  }

  Future<void> addItemToShoppingList(ShoppingList shoppingList, Item item) async {
    final itemList = List.of(shoppingList.itemIds);
    if (!itemList.contains(item.id)) {
      itemList.add(item.id);
    }

    // await getIt<ItemService>().addShoppingList(item, shoppingList); TODO
    await ref.collection("shoppingLists").doc(shoppingList.id).set(shoppingList.copyWith(itemIds: itemList, total: shoppingList.total + item.price).toJson());
  }

  Future<void> recalculate(Stream<ShoppingList> shoppingList, Person person)  async {
    
  }
}
