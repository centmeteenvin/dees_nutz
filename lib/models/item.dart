import 'package:diw/models/person.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed
class Item with _$Item {
  const Item._();
  const factory Item({
    required String id,
    required String name,
    required double price,
    required String shoppingListId,
    required List<ItemParticipantEntry> participantEntries,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  double calculateParticipantCost(Person person) {
    final specificEntry = participantEntries.firstWhere((entry) => entry.participantId == person.id);
    var totalWeight = 0;
    for (final entry in participantEntries) {
      totalWeight += entry.weight;
    }
    if (totalWeight == 0) return 0;
    return price * specificEntry.weight / totalWeight;
  }
}

@freezed
class ItemParticipantEntry with _$ItemParticipantEntry {
  const factory ItemParticipantEntry({
    required String participantId,
    required int weight,
  }) = _ItemParticipantEntry;

  factory ItemParticipantEntry.fromJson(Map<String, dynamic> json) => _$ItemParticipantEntryFromJson(json);
}
