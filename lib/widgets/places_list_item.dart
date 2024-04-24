import 'package:favorite_places/widgets/place_portrait.dart';
import 'package:flutter/material.dart';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/place_detail_screen.dart';

class PlacesListItem extends StatelessWidget {
  final Place place;
  final double avatarRadius;
  const PlacesListItem({
    super.key,
    required this.place,
    this.avatarRadius = 32,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      visualDensity: const VisualDensity(
        vertical: VisualDensity.maximumDensity,
      ),
      title: Text(
        place.title,
        style: textTheme.titleMedium!.copyWith(
          color: colorScheme.onBackground,
        ),
      ),
      subtitle: Text(place.address),
      leading: CircleAvatar(
        radius: avatarRadius,
        child: ClipOval(
          // clipper: CircleRevealCliper(0.5),
          child: PlacePortrait(
            place: place,
            height: avatarRadius * 2,
          ),
        ),
      ),
      onTap: () {
        _openPlaceDetailScreen(context);
      },
    );
  }

  void _openPlaceDetailScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => PlaceDetailScreen(
          place: place,
        ),
      ),
    );
  }
}
