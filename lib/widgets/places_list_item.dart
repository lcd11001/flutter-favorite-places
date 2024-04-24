import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_places/utils/circle_reveal_cliper.dart';
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
    return ListTile(
      visualDensity: const VisualDensity(
        vertical: VisualDensity.maximumDensity,
      ),
      title: Text(place.title),
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
