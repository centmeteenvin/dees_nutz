import 'package:diw/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ItemCreatorDialog extends ConsumerWidget {
  final formKey = GlobalKey<FormState>();

  final String shoppingListId;
  final List<String> participantIds;
  final List<ItemParticipantEntry>? participantEntries;
  late final TextEditingController nameController;
  late final TextEditingController priceController;
  ItemCreatorDialog({
    super.key,
    required this.shoppingListId,
    required this.participantIds,
    String? name,
    double? price,
    this.participantEntries

  }) {
    nameController = TextEditingController(text: name);
    priceController = TextEditingController(text: NumberFormat("####.00").format(price ?? 0));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formKey,
      child: AlertDialog(
        title: const Text("Create Item"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(label: Text("name")),
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) return "Required Field";
                return null;
              },
            ),
            const SizedBox(width: 20),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(label: Text("price")),
              canRequestFocus: true,
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) return "Required Field";
                double? price = double.tryParse(value);
                if (price == null) return "Not a valid price";
                if (price < 0) return "Price must be positive";
                return null;
              },
            )
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), focusNode: FocusNode(canRequestFocus: false), child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                if (!(formKey.currentState?.validate() ?? false)) return;
                final String name = nameController.value.text;
                final double price = double.parse(priceController.value.text);
                final item = Item(
                  id: const Uuid().v4(),
                  name: name,
                  price: price,
                  shoppingListId: shoppingListId,
                  participantEntries: participantEntries  ?? participantIds.map((id) => ItemParticipantEntry(participantId: id, weight: 0)).toList() ,
                );
                Navigator.pop(context, item);
              },
              focusNode: FocusNode(canRequestFocus: true),
              child: const Text("Create")),
        ],
      ),
    );
  }

  static Future<Item?> show(BuildContext context, WidgetRef ref, {required String shoppingListId, required List<String> participantIds, Item? template}) async {
    final Item? item;
    if (template == null) {
      item = await showDialog<Item>(
          context: context,
          builder: (context) => ItemCreatorDialog(
                shoppingListId: shoppingListId,
                participantIds: participantIds,
              ));
    } else {
      item = await showDialog<Item>(
        context: context,
        builder: (context) => ItemCreatorDialog(
          shoppingListId: shoppingListId,
          participantIds: participantIds,
          participantEntries: template.participantEntries,
          name: template.name,
          price: template.price,
        ),
      );
    }
    if (item == null) return null;
    return item;
  }
}
