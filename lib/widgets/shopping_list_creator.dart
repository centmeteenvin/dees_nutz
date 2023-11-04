import 'dart:typed_data';

import 'package:diw/main.dart';
import 'package:diw/models/person.dart';
import 'package:diw/providers.dart';
import 'package:diw/providers/file_notifier.dart';
import 'package:diw/providers/person_notifier.dart';
import 'package:diw/providers/shopping_list_notifier.dart';
import 'package:diw/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

final shoppingListCreatorImageReferenceProvider = StateProvider.autoDispose<Reference?>((ref) {
  return null;
});

final shoppingListCreatorImageBytesProvider = StateProvider.autoDispose<Uint8List?>((ref) {
  return null;
});

class ShoppingListCreatorDialog extends ConsumerWidget {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  ShoppingListCreatorDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageBytes = ref.watch(shoppingListCreatorImageBytesProvider);
    final imageRef = ref.watch(shoppingListCreatorImageReferenceProvider);
    return Form(
      key: formKey,
      child: AlertDialog(
        title: const Text("Create new shopping list."),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(label: Text("Title")),
              validator: (value) => value?.isEmpty ?? true ? "Required Field" : null,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: dateController,
              decoration: const InputDecoration(label: Text("Date of trip"), hintText: "dd/mm/yyyy"),
              keyboardType: TextInputType.datetime,
              validator: (value) {
                if (value == null || value.isEmpty) return "Required Field";
                final formatter = DateFormat("dd/MM/yyyy");
                try {
                  formatter.parse(value);
                  return null;
                } on FormatException {
                  return "Invalid Date";
                }
              },
            ),
            const SizedBox(height: 20),
            const ShoppingListCreatorPersonSelector(),
            const SizedBox(height: 20),
            if (imageBytes == null) IconButton(onPressed: () => _uploadShoppingListImage(context, ref), icon: const Icon(Icons.add_a_photo)),
            if (imageBytes != null)
              Expanded(
                child: SingleChildScrollView(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.memory(imageBytes),
                      IconButton(onPressed: () => _uploadShoppingListImage(context, ref), icon: const Icon(Icons.edit)),
                    ],
                  ),
                ),
              ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
              onPressed: () async {
                await showProcessIndicatorWhileWaitingOnFuture(context, imageRef?.delete());
                if (context.mounted) Navigator.of(context).pop();
              },
              child: const Text("Cancel")),
          TextButton(onPressed: () => _createShoppingList(context, ref), child: const Text("Create"))
        ],
      ),
    );
  }

  _uploadShoppingListImage(BuildContext context, WidgetRef ref) async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    final notifier = ref.read(fileNotifierProvider.notifier);
    final result = await notifier.pickFile();
    if (result == null) return;
    // ignore: use_build_context_synchronously
    final reference = await showProcessIndicatorWhileWaitingOnFuture(context, notifier.uploadFile(FileCollection.shoppingList, "/${titleController.value.text}.${result.extension}"));
    ref.read(shoppingListCreatorImageReferenceProvider.notifier).state = reference;
    ref.read(shoppingListCreatorImageBytesProvider.notifier).state = await result.readAsBytes();
  }

  _createShoppingList(BuildContext context, WidgetRef ref) async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    if (ref.read(shoppingListCreatorImageReferenceProvider) == null) return;
    logger.d(titleController.value.text);
    logger.d(ref.read(shoppingListCreatorPersonSelectorSelectedPersonProvider));
    await showProcessIndicatorWhileWaitingOnFuture(
        context,
        ref.read(shoppingListNotifierProvider.notifier).create(
          title: titleController.value.text,
          date: DateFormat("dd/MM/yyyy").parse(dateController.value.text),
          picture: ref.read(shoppingListCreatorImageReferenceProvider)!.fullPath,
          participants: ref.read(shoppingListCreatorPersonSelectorSelectedPersonProvider),
        ));
    if (context.mounted) Navigator.pop(context);
  }
}

final shoppingListCreatorPersonSelectorSelectedPersonProvider = StateProvider<List<Person>>((ref) {
  final currentPersonId = ref.read(currentSelectedPersonProviderId);
  if (currentPersonId == null) return [];
  return ref.watch(personProvider(currentPersonId)).hasValue ? [ref.read(personProvider(currentPersonId)).value!] : [];

});

class ShoppingListCreatorPersonSelector extends ConsumerWidget {
  const ShoppingListCreatorPersonSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Person> personList = ref.watch(personsProvider).maybeWhen(
          orElse: () => [],
          data: (data) => data,
        );
    List<Person> selectedPersonList = ref.watch(shoppingListCreatorPersonSelectorSelectedPersonProvider);
    return MultiSelectChipField<Person?>(
      title: const Text("Select Participants"),
      initialValue: selectedPersonList,
      items: personList.map((person) => MultiSelectItem(person, person.name)).toList(),
      onTap: (p0) {
        ref.read(shoppingListCreatorPersonSelectorSelectedPersonProvider.notifier).state = p0.nonNulls.toList();
        logger.d(ref.read(shoppingListCreatorPersonSelectorSelectedPersonProvider));
      },
      validator: (value) {
        if (value == null || value.isEmpty || value.nonNulls.isEmpty) return "Required Field";
        return null;
      },
    );
  }
}
