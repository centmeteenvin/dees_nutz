import 'package:diw/main.dart';
import 'package:diw/models/person.dart';
import 'package:diw/pages/shopping_list/shopping_list_page.dart';
import 'package:diw/providers.dart';
import 'package:diw/providers/person_notifier.dart';
import 'package:diw/providers/shopping_list_notifier.dart';
import 'package:diw/widgets/person_creator.dart';
import 'package:diw/widgets/person_selector.dart';
import 'package:diw/widgets/shopping_list_creator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final homePageScaffoldKeyProvider = Provider<GlobalKey<ScaffoldState>>((ref) {
  return GlobalKey<ScaffoldState>();
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: ref.read(homePageScaffoldKeyProvider),
      appBar: const HomePageAppBar(),
      body: const HomePageBody(),
      drawer: const HomePageSideBarPersonSelector(),
    );
  }
}

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("DIW"),
      centerTitle: true,
      leading: const Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: PersonSelector(),
      ),
      actions: const [
        HomePageCreatePersonButton(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: HomePageShoppingListGrid()),
          Divider(),
          HomePageCreateShoppingListButton(),
          // Spacer(),
        ],
      ),
    );
  }
}

class HomePageCreateShoppingListButton extends StatelessWidget {
  const HomePageCreateShoppingListButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) => ShoppingListCreatorDialog(),
          barrierDismissible: false,
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

class HomePageCreatePersonButton extends StatelessWidget {
  const HomePageCreatePersonButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const PersonCreateWidget(child: Icon(Icons.person_add));
  }
}

class PersonAvatar extends ConsumerWidget {
  final Person? person;
  final double size;
  final void Function()? onTap;
  const PersonAvatar({super.key, required this.person, this.size = 20, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (person == null) {
      return InkWell(
        onTap: onTap,
        child: CircleAvatar(
          radius: size,
          child: Icon(
            Icons.person,
            size: size,
          ),
        ),
      );
    }
    final futureImageData = ref.watch(pictureProvider(person!.profilePicture));
    return futureImageData.maybeWhen(
      orElse: () => const CircularProgressIndicator(),
      error: (error, stackTrace) {
        logger.i("Error occurred while fetching image", error: error, stackTrace: stackTrace);
        return ErrorWidget(error);
      },
      data: (url) => InkWell(
        onTap: onTap,
        child: CircleAvatar(
          foregroundImage: NetworkImage(url),
          radius: size,
        ),
      ),
    );
  }
}

class PersonSelector extends ConsumerWidget {
  const PersonSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPerson = ref.watch(currentSelectedPersonProvider.select((value) => value.value));
    return PersonAvatar(
        person: currentPerson,
        onTap: () {
          final scaffoldKey = ref.read(homePageScaffoldKeyProvider);
          scaffoldKey.currentState?.openDrawer();
        });
  }
}

class HomePageSideBarPersonSelector extends ConsumerWidget {
  const HomePageSideBarPersonSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Drawer(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: HomePageSideBarPersonSelectorContent(),
        ),
      ),
    );
  }
}

class HomePageSideBarPersonSelectorContent extends ConsumerWidget {
  const HomePageSideBarPersonSelectorContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentPerson = ref.watch(currentSelectedPersonProvider.select((value) => value.value));
    return SingleChildScrollView(
      child: Column(
        children: [
          PersonAvatar(
            person: currentPerson,
            size: 60,
          ),
          const SizedBox(height: 15),
          Text(
            currentPerson?.name ?? "",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Divider(thickness: 3.0),
          PersonListSelector(
            onTap: (person) => ref.read(currentSelectedPersonProviderId.notifier).state = person.id,
          )
        ],
      ),
    );
  }
}

class HomePageShoppingListGrid extends ConsumerWidget {
  const HomePageShoppingListGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPersonId = ref.watch(currentSelectedPersonProviderId);
    if (currentPersonId == null) return const Text("Select a person");
    final shoppingListIds = ref.watch(personProvider(currentPersonId).select((value) => value.value?.shoppingListIds));
    if (shoppingListIds == null) return Container();
    // logger.i(currentPerson);
    return SingleChildScrollView(
      clipBehavior: Clip.antiAlias,
      scrollDirection: Axis.vertical,
      child: GridView.count(
        crossAxisCount: 6,
        childAspectRatio: 0.75,
        shrinkWrap: true,
        semanticChildCount: shoppingListIds.length,
        children: shoppingListIds.map((id) => HomePageShoppingListGridItem(id)).toList(),
      ),
    );
  }
}

class HomePageShoppingListGridItem extends ConsumerWidget {
  final String id;
  const HomePageShoppingListGridItem(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureShoppingList = ref.watch(shoppingListProvider(id));
    return futureShoppingList.maybeWhen(
      orElse: () => const Card(child: GridTile(child: CircularProgressIndicator())),
      data: (shoppingList) => Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            GridTile(
              header: GridTileBar(
                title: Text(shoppingList.title),
                subtitle: Text(DateFormat("dd/MM/yyyy").format(shoppingList.date)),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              footer: GridTileBar(
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                title: Wrap(
                  direction: Axis.vertical,
                  clipBehavior: Clip.antiAlias,
                  children: shoppingList.participantEntries
                      .take(4)
                      .map(
                        (entry) => ref.watch(personProvider(entry.participantId)).maybeWhen(
                              orElse: () => Container(),
                              data: (person) => PersonAvatar(person: person),
                            ),
                      )
                      .toList(),
                ),
              ),
              child: Builder(
                builder: (context) {
                  final futureImage = ref.watch(pictureProvider(shoppingList.picture));
                  return futureImage.maybeWhen(
                    orElse: () => const Center(child: CircularProgressIndicator()),
                    data: (url) => Image.network(url),
                  );
                },
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                hoverColor: Colors.black.withAlpha(50),
                splashColor: Colors.redAccent.withAlpha(50),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ShoppingListPage(id),
                  ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
