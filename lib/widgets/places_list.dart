import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/widgets/places_list_item.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  final List<Place> places;
  const PlacesList({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    if (places.isEmpty) {
      return Center(
        child: Text(
          'No places added yet, start adding some!',
          style: textTheme.bodyMedium!.copyWith(
            color: colorScheme.onBackground,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) {
        return PlacesListItem(place: places[index]);
      },
    );
  }
}
