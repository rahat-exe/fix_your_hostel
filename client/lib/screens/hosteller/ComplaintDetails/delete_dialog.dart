import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    super.key,
    required this.title,
    required this.message,

  });
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false); // close dialog
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {

            Navigator.pop(context, true); // close dialog first
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          child: Text(
            "Delete",
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ],
    );
  }
}
