import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String description;
  const ConfirmDialog({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), autofocus: true, child: const Text("Cancel")),
        TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Confirm")),
      ],
    );
  }

  static Future<bool> show(BuildContext context, {required String title, required String description}) async {
    final result = await showDialog(context: context, builder: (context) => ConfirmDialog(title: title, description: description));
    return result ?? false;
  }
}