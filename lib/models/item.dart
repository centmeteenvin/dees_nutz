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
