import 'package:favorite_places/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';

class PlacesListItem extends StatelessWidget {
  const PlacesListItem({
    super.key,
    required this.title,
    required this.address,
    required this.imageUrl,
  });

  final String title;
  final String address;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(address),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
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
