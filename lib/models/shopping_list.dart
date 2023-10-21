import 'package:diw/models/person.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shopping_list.freezed.dart';
part 'shopping_list.g.dart';

List<String> personIdMapper(List<Person> persons) => persons.map((person) => person.id).toList(); //TODO remove

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
