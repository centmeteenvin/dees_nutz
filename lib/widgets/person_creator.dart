import 'dart:typed_data';

import 'package:diw/main.dart';
import 'package:diw/models/person.dart';
import 'package:diw/providers/file_notifier.dart';
import 'package:diw/providers/person_notifier.dart';
import 'package:diw/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef CommitFunction = Future<void> Function(String newName, String profilePicturePath);

class PersonCreateWidget extends ConsumerWidget {
  final Widget child;
  const PersonCreateWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        onPressed: () async {
          PersonCreateDialog.show(
            context,
            ref,
            commitButtonText: "Create",
            commitFunction: (newName, profilePicturePath) async {
              await ref.read(personNotifierProvider.notifier).createPerson(name: newName, path: profilePicturePath);
            },
            dialogTitle: "Create Person",
            returnScaffoldMessage: "Successfully Created Person",
            shouldDelete: true
          );
        },
        icon: child);
  }
}

class PersonEditWidget extends HookConsumerWidget {
  final String personId;
  final Widget child;
  const PersonEditWidget(this.personId, {super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCalled = useState(false);

    final person = ref.watch(personProvider(personId).select((value) => value.value));
    return IconButton(
        onPressed: () async {
          if (person == null) {
            isCalled.value = false;
            return;
          }
          if (isCalled.value) return;
          isCalled.value = true;
          await PersonCreateDialog.show(
            context,
            ref,
            dialogTitle: "Edit Person",
            commitButtonText: "Edit",
            commitFunction: (newName, profilePicturePath) async {
              final PersonNotifier personNotifier = ref.read(personNotifierProvider.notifier);
              await personNotifier.updatePerson(person.copyWith(name: newName));
            },
            initialData: person,
            returnScaffoldMessage: "Successfully edited person.",
            shouldDelete: false
          );
          isCalled.value = false;
        },
        icon: child);
  }
}

final personCreatorProfilePictureBytesProvider = StateProvider<Uint8List?>((ref) {
  return null;
});
final personCreatorProfilePictureNameRefProvider = StateProvider<Reference?>((ref) => null);

class PersonCreateDialog extends HookConsumerWidget {
  final Person? initialValue;
  final String dialogTitle;
  final String commitButtonText;
  final CommitFunction commitFunction;
  final String? scaffoldReturnMessage;
  final bool shouldDelete;
  const PersonCreateDialog({
    super.key,
    required this.dialogTitle,
    required this.commitButtonText,
    required this.commitFunction,
    this.initialValue,
    this.scaffoldReturnMessage,
    required this.shouldDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController(text: initialValue?.name);
    final formKey = useMemoized(
      () => GlobalKey<FormState>(),
    );

    final Uint8List? profilePicture = ref.watch(personCreatorProfilePictureBytesProvider);
    final Reference? reference = ref.watch(personCreatorProfilePictureNameRefProvider);
    logger.d("build: ${ref.read(personCreatorProfilePictureNameRefProvider)}");

    return Form(
      key: formKey,
      child: AlertDialog(
        title: Text(dialogTitle),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text("Name"),
              ),
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) return "required field";
                return null;
              },
            ),
            const Divider(),
            if (profilePicture == null)
              IconButton(
                onPressed: () => selectAndUploadPicture(context, ref, formKey, nameController),
                icon: const Icon(Icons.add_a_photo),
              ),
            if (profilePicture != null)
              Stack(
                children: [
                  Image.memory(
                    profilePicture,
                  ),
                  IconButton(
                    onPressed: () => selectAndUploadPicture(context, ref, formKey, nameController),
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            autofocus: true,
            onPressed: () async {
              if (reference != null && shouldDelete) {
                await showProcessIndicatorWhileWaitingOnFuture(
                  context,
                  ref.read(fileNotifierProvider.notifier).deleteFileReference(reference),
                );
              }
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              if (reference == null) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select an image")));
              if (!(formKey.currentState?.validate() ?? false)) return;

              await showProcessIndicatorWhileWaitingOnFuture(context, commitFunction(nameController.text, reference!.fullPath));
              if (!context.mounted) return;
              if (scaffoldReturnMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(scaffoldReturnMessage!)));
              }
              Navigator.pop(context);
            },
            child: Text(commitButtonText),
          ),
        ],
      ),
    );
  }

  Future<void> selectAndUploadPicture(BuildContext context, WidgetRef ref, GlobalKey<FormState> formKey, TextEditingController nameController) async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    final notifier = ref.read(fileNotifierProvider.notifier);
    final picked = await notifier.pickFile();
    if (picked != null) {
      // ignore: use_build_context_synchronously
      final reference = await showProcessIndicatorWhileWaitingOnFuture(
          context,
          notifier.uploadFile(
            picked,
            FileCollection.profilePicture,
            "${nameController.text}.${picked.extension}",
          ));
      ref.read(personCreatorProfilePictureNameRefProvider.notifier).state = reference;
      ref.read(personCreatorProfilePictureBytesProvider.notifier).state = await picked.readAsBytes();
      ref.invalidate(pictureUrlProvider);
    }
  }

  static Future<Person?> show(
    BuildContext context,
    WidgetRef ref, {
    Person? initialData,
    required String dialogTitle,
    required String commitButtonText,
    required CommitFunction commitFunction,
    required bool shouldDelete,
    String? returnScaffoldMessage,
  }) async {
    ref.invalidate(personCreatorProfilePictureBytesProvider);
    ref.invalidate(personCreatorProfilePictureNameRefProvider);
    final notifier = ref.read(fileNotifierProvider.notifier);
    if (initialData != null) {
      final reference = notifier.getFileReference(initialData.profilePicture);
      ref.read(personCreatorProfilePictureNameRefProvider.notifier).state = reference;
      ref.read(personCreatorProfilePictureBytesProvider.notifier).state = await reference.getData();
    }
    logger.d("Static: ${ref.read(personCreatorProfilePictureNameRefProvider)}");
    if (!context.mounted) return null;
    return await showDialog<Person>(
      context: context,
      builder: (context) => PersonCreateDialog(
        dialogTitle: dialogTitle,
        commitButtonText: commitButtonText,
        commitFunction: commitFunction,
        initialValue: initialData,
        scaffoldReturnMessage: returnScaffoldMessage,
        shouldDelete: shouldDelete,
      ),
      barrierDismissible: false,
    );
  }
}
