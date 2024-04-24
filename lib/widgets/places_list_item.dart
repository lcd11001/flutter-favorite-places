import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';

class PlacesListItem extends StatelessWidget {
  final Place place;
  const PlacesListItem({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(place.title),
      subtitle: Text(place.address),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(place.imageUrl),
      ),
      onTap: () {
        _openPlaceDetailScreen(context);
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
