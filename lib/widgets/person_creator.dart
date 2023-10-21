import 'dart:typed_data';

import 'package:diw/models/person.dart';
import 'package:diw/providers/person_notifier.dart';
import 'package:diw/utils.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonCreateWidget extends StatelessWidget {
  final Widget child;
  const PersonCreateWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          await showDialog<Person>(
            context: context,
            builder: (context) => PersonCreateDialog(),
            barrierDismissible: false,
          );
        },
        icon: child);
  }
}

final personCreatorProfilePictureBytesProvider = StateProvider<Uint8List?>((ref) {
  return null;
});
final personCreatorProfilePictureNameRefProvider = StateProvider<Reference?>((ref) => null);

class PersonCreateDialog extends ConsumerWidget {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  PersonCreateDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Uint8List? profilePicture = ref.watch(personCreatorProfilePictureBytesProvider);
    final Reference? reference = ref.watch(personCreatorProfilePictureNameRefProvider);
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
                onPressed: () => selectAndUploadPicture(context, ref),
                icon: const Icon(Icons.add_a_photo),
              ),
            if (profilePicture != null)
              Stack(
                children: [
                  Image.memory(profilePicture),
                  IconButton(
                    onPressed: () => selectAndUploadPicture(context, ref),
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
                await showProcessIndicatorWhileWaitingOnFuture(context, reference.delete());
              }
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              if (reference == null) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select an image")));
              if (!(formKey.currentState?.validate() ?? false)) return;
              
              final result =  ref.read(personNotifierProvider.notifier).createPerson(name: nameController.value.text, path: reference!.fullPath);
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

  Future<void> selectAndUploadPicture(BuildContext context, WidgetRef ref) async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    final picked =
        await FilePickerWeb.platform.pickFiles(dialogTitle: "Pick a picture", allowMultiple: false, type: FileType.image, initialDirectory: "Pictures");
    if (picked != null) {
      final reference = FirebaseStorage.instance.ref("profilePictures/${nameController.value.text}.${picked.files.first.extension}");
      // ignore: use_build_context_synchronously
      await showProcessIndicatorWhileWaitingOnFuture(context, reference.putData(picked.files.first.bytes!));
      ref.read(personCreatorProfilePictureNameRefProvider.notifier).state = reference;
      ref.read(personCreatorProfilePictureBytesProvider.notifier).state = picked.files.first.bytes;
    }
  }
}
