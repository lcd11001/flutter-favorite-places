import 'package:flutter/material.dart';

enum PlaceTextSize {
  small,
  medium,
  large,
}

class PlaceText extends StatelessWidget {
  const PlaceText({
    super.key,
    required this.content,
    this.alignment = TextAlign.center,
    this.size = PlaceTextSize.medium,
  });

  final String content;
  final TextAlign alignment;
  final PlaceTextSize size;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: Text(
        content,
        style: switch (size) {
          PlaceTextSize.small => textTheme.titleSmall!.copyWith(
              color: colorScheme.onBackground,
            ),
          PlaceTextSize.medium => textTheme.titleMedium!.copyWith(
              color: colorScheme.onBackground,
            ),
          PlaceTextSize.large => textTheme.titleLarge!.copyWith(
              color: colorScheme.onBackground,
            ),
        },
        textAlign: alignment,
      ),
    );
  }
}
