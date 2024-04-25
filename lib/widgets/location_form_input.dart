import 'package:favorite_places/models/place_location.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';

class LocationFormInput extends FormField<PlaceLocation> {
  final void Function(PlaceLocation location) onPickedLocation;

  LocationFormInput({
    super.key,
    super.validator,
    super.onSaved,
    super.restorationId,
    required this.onPickedLocation,
  }) : super(
          initialValue: null,
          enabled: true,
          autovalidateMode: AutovalidateMode.disabled,
          builder: (FormFieldState<PlaceLocation> state) {
            final textTheme = Theme.of(state.context).textTheme;
            final colorScheme = Theme.of(state.context).colorScheme;
            debugPrint('LocationFormInput state: ${state.hasError}');

            return Column(
              children: [
                LocationInput(
                  onPickedLocation: (location) {
                    state.didChange(location);
                    state.validate();
                    onPickedLocation(location);
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
