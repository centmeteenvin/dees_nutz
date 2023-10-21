import 'package:diw/models/item.dart';
import 'package:diw/pages/home/home_page.dart';
import 'package:diw/providers/item_notifier.dart';
import 'package:diw/providers/person_notifier.dart';
import 'package:diw/providers/shopping_list_notifier.dart';
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
                children: itemIds.map((itemId) => Flexible(child: ShoppingListPageItemListViewItem(itemId))).toList(),
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
      data: (item) => ConstrainedBox(
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
              children: item.participantEntries.map((entry) => ShoppingListPageListViewItemEntry(item: item, participantId: entry.participantId)).toList(),
            )),
          ],
        ),
      ),
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
          if (entry.weight != 0)
            InkWell(
              onTap: () {
                ref.read(itemNotifierProvider.notifier).decreaseWeight(item, person);
              },
              child: CircleAvatar(
                child: Text(entry.weight.toString()),
              ),
            ),
          PersonAvatar(
            person: person,
            onTap: () {
                ref.read(itemNotifierProvider.notifier).increaseWeight(item, person);
            },
          ),
        ],
      ),
    );
  }
}
