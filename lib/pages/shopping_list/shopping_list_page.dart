import 'package:collection/collection.dart';
import 'package:diw/main.dart';
import 'package:diw/models/item.dart';
import 'package:diw/pages/home/home_page.dart';
import 'package:diw/pages/shopping_list/shopping_list_item.dart';
import 'package:diw/providers/file_notifier.dart';
import 'package:diw/providers/person_notifier.dart';
import 'package:diw/providers/shopping_list_notifier.dart';
import 'package:diw/widgets/dialogs.dart';
import 'package:diw/widgets/item_creator.dart';
import 'package:diw/widgets/person_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final isMobileProvider = StateProvider<bool>((ref) => false,);

final shoppingListPageScaffoldKeyProvider = Provider.autoDispose<GlobalKey<ScaffoldState>>(
  (ref) => GlobalKey<ScaffoldState>(),
);

class ShoppingListPage extends ConsumerWidget {
  final String id;
  const ShoppingListPage(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureShoppingList = ref.watch(shoppingListProvider(id));
    final scaffoldKey = ref.watch(shoppingListPageScaffoldKeyProvider);
    futureShoppingList.whenOrNull(
      error: (error, stackTrace) {
        logger.e("Error occurred", error: error, stackTrace: stackTrace);
        Navigator.of(context).pop();
      },
    );
    return futureShoppingList.maybeWhen(
      orElse: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      data: (data) => LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth >= 1000) {
          Future(() => ref.read(isMobileProvider.notifier).state = false);
          return Scaffold(
            key: scaffoldKey,
            appBar: ShoppingListPageAppBarDesktop(id),
            body: ShoppingListPageBodyDesktop(id),
            floatingActionButton: ShoppingListPageFloatingActionButton(id),
          );
        } else {
          Future(() => ref.read(isMobileProvider.notifier).state = true);

          return Scaffold(
            key: scaffoldKey,
            appBar: ShoppingListPageAppBarMobile(id),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ShoppingListPageItemListView(id),
            ),
            floatingActionButton: ShoppingListPageFloatingActionButton(id),
            drawer: Drawer(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ShoppingListPageBodyPeople(id),
            )),
            endDrawer: Drawer(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ShoppingListPageBodyImage(id),
            )),
            endDrawerEnableOpenDragGesture: false,
          );
        }
      }),
    );
  }
}

class ShoppingListPageAppBarDesktop extends ConsumerWidget implements PreferredSizeWidget {
  final String id;
  const ShoppingListPageAppBarDesktop(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shoppingListTitle =
        ref.watch(shoppingListProvider(id).select((asyncShoppingList) => asyncShoppingList.hasValue ? asyncShoppingList.value!.title : "Loading"));
    return AppBar(
      title: Text(shoppingListTitle),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () async {
              final result = await ConfirmDialog.show(context, title: "Delete ShoppingList", description: "This action is permanent and cannot be reversed");
              if (!result) return;
              final shoppingList = await ref.read(shoppingListProvider(id).future);
              if (context.mounted) {
                await ref.read(shoppingListNotifierProvider.notifier).deleteShoppingList(shoppingList);
                // await showProcessIndicatorWhileWaitingOnFuture(context, ref.read(shoppingListNotifierProvider.notifier).deleteShoppingList(shoppingList));
              }
              if (context.mounted) {
                // Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Successfully deleted shoppingList")));
              }
            },
            icon: const Icon(Icons.delete_forever))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ShoppingListPageAppBarMobile extends ConsumerWidget implements PreferredSizeWidget {
  final String id;
  const ShoppingListPageAppBarMobile(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shoppingListTitle =
        ref.watch(shoppingListProvider(id).select((asyncShoppingList) => asyncShoppingList.hasValue ? asyncShoppingList.value!.title : "Loading"));
    return AppBar(
      title: Text(shoppingListTitle),
      centerTitle: true,
      leading: Row(
        children: [
          IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
          IconButton(
              onPressed: () {
                ref.read(shoppingListPageScaffoldKeyProvider).currentState?.openDrawer();
              },
              icon: const Icon(Icons.people)),
        ],
      ),
      leadingWidth: 112,
      actions: [
        IconButton(
            onPressed: () {
              ref.read(shoppingListPageScaffoldKeyProvider).currentState?.openEndDrawer();
            },
            icon: const Icon(Icons.image)),
        IconButton(
            onPressed: () async {
              final result = await ConfirmDialog.show(context, title: "Delete ShoppingList", description: "This action is permanent and cannot be reversed");
              if (!result) return;
              final shoppingList = await ref.read(shoppingListProvider(id).future);
              if (context.mounted) {
                await ref.read(shoppingListNotifierProvider.notifier).deleteShoppingList(shoppingList);
                // await showProcessIndicatorWhileWaitingOnFuture(context, ref.read(shoppingListNotifierProvider.notifier).deleteShoppingList(shoppingList));
              }
              if (context.mounted) {
                // Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Successfully deleted shoppingList")));
              }
            },
            icon: const Icon(Icons.delete_forever)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ShoppingListPageBodyDesktop extends ConsumerWidget {
  final String id;
  const ShoppingListPageBodyDesktop(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 4,
            child: Column(
              children: [
                Expanded(child: Center(child: ShoppingListPageBodyImage(id))),
                Flexible(child: ShoppingListPageBodyPeople(id)),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            flex: 5,
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
    final pictureDownloadUrl = ref.watch(pictureUrlProvider(shoppingListUrl));
    return pictureDownloadUrl.maybeWhen(
      orElse: () => const Center(child: CircularProgressIndicator()),
      data: (data) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InteractiveViewer(
          child: Image.network(data, fit: BoxFit.cover),
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
    if (shoppingList.participantEntries.any((entry) => entry.participantId == person.id)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("This person was already participating.")));
      }
      return;
    }
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
    final isMobile = ref.watch(isMobileProvider);
    return asyncPerson.maybeWhen(
      orElse: () => const Center(
        child: CircularProgressIndicator(),
      ),
      data: (person) => LayoutBuilder(builder: (context, constraints) {
        if (!isMobile) {
          return Row(
            children: [
              PersonAvatar(person: person),
              const SizedBox(width: 5),
              ShoppingListPageBodyPeopleItemCost(id, participantId: participantId),
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
          );
        }
        return Row(
          children: [
            PersonAvatar(person: person, size: 40),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
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
                    ],
                  ),
                  ShoppingListPageBodyPeopleItemCost(id, participantId: participantId),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  removePerson(BuildContext context, WidgetRef ref) async {
    final person = await ref.read(personProvider(participantId).future);
    final shoppingList = await ref.read(shoppingListProvider(id).future);
    if (shoppingList.participantEntries.length <= 1) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("At least one Person must be associated with the shoppingList")));
      }
      return;
    }
    ref.read(shoppingListNotifierProvider.notifier).removePersonFromList(shoppingList, person);
  }
}

class ShoppingListPageBodyPeopleItemCost extends ConsumerWidget {
  final String shoppingListId;
  final String participantId;
  const ShoppingListPageBodyPeopleItemCost(this.shoppingListId, {super.key, required this.participantId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalCost = ref.watch(shoppingListProvider(shoppingListId).select((value) => value.value?.total ?? 0));
    final personCost = ref.watch(shoppingListProvider(shoppingListId).select((value) {
      return value.value?.participantEntries.firstWhereOrNull((entry) => entry.participantId == participantId)?.currentCost ?? 0;
    }));
    return Text(
        "${NumberFormat("####.00").format(personCost)}/${NumberFormat("####.00").format(totalCost)} EUR -> ${NumberFormat("##.0%").format(personCost / totalCost)}");
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
        final Item? item = await ItemCreatorDialog.show(context, ref, shoppingListId: id, participantIds: participantIds);
        if (item == null) return;
        final shoppingList = await ref.read(shoppingListProvider(id).future);
        await ref.read(shoppingListNotifierProvider.notifier).addItemToShoppingList(shoppingList, item);
      },
      child: const Icon(Icons.add),
    );
  }
}
