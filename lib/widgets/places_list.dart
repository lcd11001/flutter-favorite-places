import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/widgets/places_list_item.dart';
import 'package:flutter/material.dart';

import 'package:favorite_places/screens/place_detail_screen.dart';

class PlacesList extends StatelessWidget {
  final List<Place> places;
  const PlacesList({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) {
        return PlacesListItem(place: places[index]);
      },
    );
  }

  void _openPlaceDetailScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const PlaceDetailScreen(),
      ),
    );
  }
}
