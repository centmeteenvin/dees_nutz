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

class PersonCreateWidget extends ConsumerWidget {
  final Widget child;
  const PersonCreateWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        onPressed: () async {
          PersonCreateDialog.show(context, ref);
        },
        icon: child);
  }
}

final personCreatorProfilePictureBytesProvider = StateProvider<Uint8List?>((ref) {
  return null;
});
final personCreatorProfilePictureNameRefProvider = StateProvider<Reference?>((ref) => null);

class PersonCreateDialog extends HookConsumerWidget {
  const PersonCreateDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final formKey = useMemoized(
      () => GlobalKey<FormState>(),
    );

    final Uint8List? profilePicture = ref.watch(personCreatorProfilePictureBytesProvider);
    final Reference? reference = ref.watch(personCreatorProfilePictureNameRefProvider);
    logger.d("build: ${ref.read(personCreatorProfilePictureNameRefProvider)}");

    return Form(
      key: formKey,
      child: AlertDialog(
        title: const Text("Create Person"),
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
              if (reference != null) {
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

              final result = ref.read(personNotifierProvider.notifier).createPerson(name: nameController.value.text, path: reference!.fullPath);
              await showProcessIndicatorWhileWaitingOnFuture(context, result);
              if (!context.mounted) return;
              // ref.invalidate(personsProvider);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("SuccessFully Created Person")));
              Navigator.pop(context);
            },
            child: const Text("Create"),
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
    }
  }

  static Future<Person?> show(BuildContext context, WidgetRef ref) async {
    ref.invalidate(personCreatorProfilePictureBytesProvider);
    ref.invalidate(personCreatorProfilePictureNameRefProvider);

    logger.d("Static: ${ref.read(personCreatorProfilePictureNameRefProvider)}");
    return await showDialog<Person>(context: context, builder: (context) => const PersonCreateDialog(), barrierDismissible: false);
  }
}
