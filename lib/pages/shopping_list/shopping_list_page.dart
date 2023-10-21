import 'package:diw/main.dart';
import 'package:diw/pages/home/home_page.dart';
import 'package:diw/pages/shopping_list/shopping_list_item.dart';
import 'package:diw/providers.dart';
import 'package:diw/providers/person_notifier.dart';
import 'package:diw/providers/shopping_list_notifier.dart';
import 'package:diw/widgets/item_creator.dart';
import 'package:diw/widgets/person_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoppingListPage extends ConsumerWidget {
  final String id;
  const ShoppingListPage(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureShoppingList = ref.watch(shoppingListProvider(id));
    futureShoppingList.whenOrNull(
      error: (error, stackTrace) {
        logger.e("Error occured", error: error, stackTrace: stackTrace);
        Navigator.of(context).pop();
      },
    );
    return futureShoppingList.maybeWhen(
      orElse: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      data: (data) => Scaffold(
        appBar: ShoppingListPageAppBar(id),
        body: ShoppingListPageBody(id),
        floatingActionButton: ShoppingListPageFloatingActionButton(id),
      ),
    );
  }
}

class ShoppingListPageAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String id;
  const ShoppingListPageAppBar(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shoppingListTitle =
        ref.watch(shoppingListProvider(id).select((asyncShoppingList) => asyncShoppingList.hasValue ? asyncShoppingList.value!.title : "Loading"));
    return AppBar(
      title: Text(shoppingListTitle),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ShoppingListPageBody extends ConsumerWidget {
  final String id;
  const ShoppingListPageBody(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 2,
            child: Column(
              children: [
                Expanded(child: ShoppingListPageBodyImage(id)),
                Flexible(child: ShoppingListPageBodyPeople(id)),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            flex: 3,
            child: ShoppingListPageItemListView(id),
          )
        ],
      ),
    );
  }
}

class ShoppingListPageBodyImage extends ConsumerWidget {
  final String id;
  const ShoppingListPageBodyImage(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shoppingListUrl = ref.watch(shoppingListProvider(id).select((value) => value.value?.picture));
    if (shoppingListUrl == null) return Container();
    final pictureDownloadUrl = ref.watch(pictureProvider(shoppingListUrl));
    return pictureDownloadUrl.maybeWhen(
      orElse: () => const Center(child: CircularProgressIndicator()),
      data: (data) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InteractiveViewer(
          child: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Image.network(data, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

class ShoppingListPageBodyPeople extends ConsumerWidget {
  final String id;
  const ShoppingListPageBodyPeople(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final participantIds = ref.watch(shoppingListProvider(id).select((value) => value.value?.participantEntries.map((entry) => entry.participantId)));
    if (participantIds == null) return Container();
    return Column(
      children: [
        Text(
          "Participants",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Divider(thickness: 2),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: participantIds.expand((participantId) => [ShoppingListPageBodyPeopleItem(id, participantId: participantId), const Divider()]).toList(),
            ),
          ),
        ),
        IconButton(onPressed: () => addPerson(context, ref), icon: const Icon(Icons.person_add))
      ],
    );
  }

  addPerson(BuildContext context, WidgetRef ref) async {
    final person = await PersonSelectorDialog.show(context, ref, title: "Select a Person");
    if (person == null) return;
    final shoppingList = await ref.read(shoppingListProvider(id).future);
    ref.read(shoppingListNotifierProvider.notifier).addPersonToShoppingList(shoppingList, person);
  }
}

class ShoppingListPageBodyPeopleItem extends ConsumerWidget {
  final String id;
  final String participantId;
  const ShoppingListPageBodyPeopleItem(this.id, {super.key, required this.participantId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPerson = ref.watch(personProvider(participantId));
    return asyncPerson.maybeWhen(
      orElse: () => const Center(
        child: CircularProgressIndicator(),
      ),
      data: (person) => Row(
        children: [
          PersonAvatar(person: person),
          const Spacer(),
          Expanded(
              child: Text(
            person.name,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          )),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () => removePerson(context, ref),
            icon: const Icon(Icons.person_remove),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  removePerson(BuildContext context, WidgetRef ref) async {
    final person = await ref.read(personProvider(participantId).future);
    final shoppingList = await ref.read(shoppingListProvider(id).future);
    ref.read(shoppingListNotifierProvider.notifier).removePersonFromList(shoppingList, person);
  }
}

class ShoppingListPageFloatingActionButton extends ConsumerWidget {
  final String id;
  const ShoppingListPageFloatingActionButton(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final participantIds =
        ref.watch(shoppingListProvider(id).select((value) => value.value?.participantEntries.map((entry) => entry.participantId).toList() ?? []));
    return FloatingActionButton(
      onPressed: () async {
        logger.i(await ItemCreatorDialog.show(context, ref, shoppingListId: id, participantIds: participantIds));
      },
      child: const Icon(Icons.add),
    );
  }
}
