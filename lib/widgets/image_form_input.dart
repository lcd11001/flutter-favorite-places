import 'dart:io';

import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';

class ImageFormInput extends FormField<File> {
  final void Function(File pickedImage) onPickedImage;

  ImageFormInput({
    super.key,
    super.validator,
    super.onSaved,
    super.restorationId,
    required this.onPickedImage,
  }) : super(
          initialValue: null,
          enabled: true,
          autovalidateMode: AutovalidateMode.disabled,
          builder: (FormFieldState<File> state) {
            final textTheme = Theme.of(state.context).textTheme;
            final colorScheme = Theme.of(state.context).colorScheme;
            debugPrint('ImageFormInput state: ${state.hasError}');

            return Column(
              children: [
                ImageInput(
                  onPickedImage: (image) {
                    state.didChange(image);
                    onPickedImage(image);
                  },
                ),
                if (state.hasError)
                  Text(
                    state.errorText!,
                    style: textTheme.bodyMedium!.copyWith(
                      color: colorScheme.error,
                    ),
                  ),
              ],
            );
          },
        );
}
