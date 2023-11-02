import 'package:diw/models/item.dart';
import 'package:diw/pages/home/home_page.dart';
import 'package:diw/providers/item_notifier.dart';
import 'package:diw/providers/person_notifier.dart';
import 'package:diw/providers/shopping_list_notifier.dart';
import 'package:diw/widgets/item_creator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoppingListPageItemListView extends ConsumerWidget {
  final String shoppingListId;
  const ShoppingListPageItemListView(this.shoppingListId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemIds = ref.watch(ShoppingListProvider(shoppingListId).select((value) => value.value?.itemIds ?? []));
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Items", style: Theme.of(context).textTheme.titleLarge),
        const Divider(height: 2),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: itemIds.expand((itemId) => [Flexible(child: ShoppingListPageItemListViewItem(itemId)), const Divider()]).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ShoppingListPageItemListViewItem extends ConsumerWidget {
  final String itemId;
  const ShoppingListPageItemListViewItem(this.itemId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItem = ref.watch(itemProvider(itemId));
    return asyncItem.maybeWhen(
      orElse: () => Container(),
      data: (item) {
        final List<Widget> widgets = [
          const Flexible(
              child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.add),
              ),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.remove),
              )
            ],
          ))
        ];
        widgets.addAll(item.participantEntries.map((entry) => ShoppingListPageListViewItemEntry(item: item, participantId: entry.participantId)));
        // widgets.insert(
        //     0,
        //     );
        return ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: Text(
                item.name,
                style: Theme.of(context).textTheme.titleMedium,
              )),
              Expanded(child: Text("${item.price} €", textAlign: TextAlign.center)),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: widgets,
              )),
              IconButton(
                onPressed: () async {
                  var createdItem = await ItemCreatorDialog.show(
                    context,
                    ref,
                    shoppingListId: item.shoppingListId,
                    participantIds: item.participantEntries.map((entry) => entry.participantId).toList(),
                    template: item,
                  );
                  if (createdItem == null) return;
                  createdItem = createdItem.copyWith(id: item.id);
                  return await ref.read(itemNotifierProvider.notifier).update(createdItem);
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () async {
                  final shoppingList = await ref.read(shoppingListProvider(item.shoppingListId).future);
                  return await ref.read(shoppingListNotifierProvider.notifier).removeItemFromShoppingList(shoppingList, item);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ShoppingListPageListViewItemEntry extends ConsumerWidget {
  final Item item;
  final String participantId;
  const ShoppingListPageListViewItemEntry({super.key, required this.item, required this.participantId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final person = ref.watch(personProvider(participantId).select((value) => value.value));
    if (person == null) return Container();
    final entry = item.participantEntries.firstWhere(
      (entry) => entry.participantId == participantId,
    );
    return Flexible(
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          PersonAvatar(
            person: person,
            onTap: () {
              ref.read(itemNotifierProvider.notifier).increaseWeight(item, person);
            },
          ),
          // if (entry.weight != 0)
          InkWell(
            onTap: () {
              if (entry.weight > 0) {
                ref.read(itemNotifierProvider.notifier).decreaseWeight(item, person);
              }
            },
            child: CircleAvatar(
              child: Text(entry.weight.toString()),
            ),
          ),
        ],
      ),
    );
  }
}
