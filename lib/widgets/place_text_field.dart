import 'package:flutter/material.dart';

class PlaceTextField extends StatelessWidget {
  final TextEditingController titleController;
  final String title;
  final String hintErrorText;
  final int? maxLength;

  const PlaceTextField({
    super.key,
    required this.titleController,
    required this.title,
    required this.hintErrorText,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      decoration: InputDecoration(labelText: title),
      style: textTheme.bodyLarge!.copyWith(
        color: colorScheme.onBackground,
      ),
      keyboardType: TextInputType.text,
      maxLength: maxLength,
      textInputAction: TextInputAction.next,
      controller: titleController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return hintErrorText;
        }
        return null;
      },
    );
  }
}
