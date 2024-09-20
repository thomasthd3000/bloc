import 'package:flutter/material.dart';
import 'package:d_input/d_input.dart';

class SimpleInput extends StatelessWidget {
  const SimpleInput({
    super.key,
    required this.edtTitle,
    required this.edtDescription,
    required this.onTap,
    required this.actionTitle,
  });

  final TextEditingController edtTitle;
  final TextEditingController edtDescription;
  final VoidCallback onTap;
  final String actionTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DInput(
          controller: edtTitle,
          hint: 'Title',
        ),
        const SizedBox(height: 10),
        DInput(
          controller: edtDescription,
          hint: 'Description',
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: onTap,
          child: Text(actionTitle),
        ),
      ],
    );
  }
}
