// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:diw/models/item.dart';
import 'package:test/test.dart';

void main() {
  group("Item testing", () {
    test("Test ItemParticipantEntry", () {
      const entry = ItemParticipantEntry(participantId: "participant_1", weight: 0);
      final Map<String, dynamic> expectedMap = {
        "participantId": "participant_1",
        "weight": 0,
      };
      expect(entry.toJson(), expectedMap);
    });
    test("Test Item serialisation", () {
      const Item item = Item(
        id: "item_1",
        name: "Test",
        price: 10,
        shoppingListId: "shopping_list_1",
        participantEntries: [ItemParticipantEntry(participantId: "participant_1", weight: 0)],
      );
      final Map<String, dynamic> expectedJson = {
        "id": "item_1",
        "name": "Test",
        "price": 10,
        "shoppingListId": "shopping_list_1",
        "participantEntries": [
          {
            "participantId": "participant_1",
            "weight": 0,
          }
        ]
      };
      final Map<String, dynamic> actualJson = item.toJson();
      expect(actualJson, expectedJson);
      final Item constructedItem = Item.fromJson(actualJson);
      expect(constructedItem, item);
    });
  });
}
