import 'package:diw/models/item.dart';
import 'package:diw/pages/home/home_page.dart';
import 'package:diw/pages/shopping_list/shopping_list_page.dart';
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
                children: itemIds.expand((itemId) => [Flexible(child: ShoppingListPageItemListViewItemDesktop(itemId)), const Divider()]).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ShoppingListPageItemListViewItemDesktop extends ConsumerWidget {
  final String itemId;
  const ShoppingListPageItemListViewItemDesktop(this.itemId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItem = ref.watch(itemProvider(itemId));
    final isMobile = ref.watch(isMobileProvider);
    return asyncItem.maybeWhen(
      orElse: () => Container(),
      data: (item) {
        final List<Widget> widgets = [
          const Expanded(
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

        if (!isMobile) {
          return ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ShoppingListViewItemNameAndPriceWidget(item),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: widgets,
                  ),
                ),
                ShoppingListViewActionButtons(item),
              ],
            ),
          );
        }
        return ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 120),
          child: Column(
            children: [
              ShoppingListViewItemNameAndPriceWidget(item),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: widgets,
                    ),
                  ),
                  ShoppingListViewActionButtons(item),
                ],
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

class ShoppingListViewActionButtons extends ConsumerWidget {
  final Item item;
  const ShoppingListViewActionButtons(this.item, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = ref.watch(isMobileProvider);
    if (!isMobile) {
      return Row(
        children: [
          ShoppingListViewItemEditButton(item),
          ShoppingListViewItemRemoveButton(item: item),
        ],
      );
    }
    return Column(
      children: [
        ShoppingListViewItemEditButton(item),
        ShoppingListViewItemRemoveButton(item: item),
      ],
    );
  }
}

class ShoppingListViewItemRemoveButton extends ConsumerWidget {
  final Item item;
  const ShoppingListViewItemRemoveButton({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () async {
        final shoppingList = await ref.read(shoppingListProvider(item.shoppingListId).future);
        return await ref.read(shoppingListNotifierProvider.notifier).removeItemFromShoppingList(shoppingList, item);
      },
      icon: const Icon(Icons.delete),
    );
  }
}

class ShoppingListViewItemEditButton extends ConsumerWidget {
  final Item item;
  const ShoppingListViewItemEditButton(this.item, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
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
    );
  }
}

class ShoppingListViewItemNameAndPriceWidget extends ConsumerWidget {
  final Item item;
  const ShoppingListViewItemNameAndPriceWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text("${item.price} €", textAlign: TextAlign.end),
        ],
      ),
    );
  }
}
