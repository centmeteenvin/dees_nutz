import 'package:diw/models/person.dart';
import 'package:diw/pages/home/home_page.dart';
import 'package:diw/providers/person_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Creates A Column with all the persons
class PersonListSelector extends ConsumerWidget {
  final void Function(Person person) onTap;
  const PersonListSelector({super.key, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futurePersonList = ref.watch(personsProvider);
    return futurePersonList.maybeWhen(
      orElse: () => const Center(
        child: CircularProgressIndicator(),
      ),
      data: (list) {
        return Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: list
                  .expand((person) => [
                        ListTile(
                          leading: PersonAvatar(person: person),
                          title: Text(person.name),
                          onTap: () => onTap(person),
                        ),
                        const Divider()
                      ])
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}

final personSelectorDialogselectedPersonProvider = StateProvider<Person?>((ref) {
  return null;
});

//Will return a person or null, use via the static
class PersonSelectorDialog extends ConsumerWidget {
  final String title;
  final bool notNull;
  const PersonSelectorDialog({super.key, required this.title, required this.notNull});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPerson = ref.watch(personSelectorDialogselectedPersonProvider);
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Current Selected Person
          Column(
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
              const Divider(thickness: 2),
            ],
          ),
          SingleChildScrollView(
              child: PersonListSelector(
            onTap: (person) => ref.read(personSelectorDialogselectedPersonProvider.notifier).state = person,
          )),
        ],
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        TextButton(onPressed: () {
          final person = ref.read(personSelectorDialogselectedPersonProvider);
          if (notNull && person == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select a person.")));
            return;
          }
          Navigator.of(context).pop(person);
        }, child: const Text("Confirm"))
      ],
    );
  }

  static Future<Person?> show(BuildContext context, WidgetRef ref, {required String title, bool notNull = true, Person? initial}) async {
    ref.read(personSelectorDialogselectedPersonProvider.notifier).state = initial;
    return showDialog<Person>(
        context: context,
        builder: (context) => PersonSelectorDialog(
              title: title,
              notNull: notNull,
            ));
  }
}
