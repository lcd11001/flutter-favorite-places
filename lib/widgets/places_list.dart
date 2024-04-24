import 'package:favorite_places/widgets/places_list_item.dart';
import 'package:flutter/material.dart';

import '../screens/place_detail_screen.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (ctx, index) {
        return PlacesListItem(
          title: 'Place title',
          address: 'Place address',
          imageUrl: 'https://picsum.photos/200',
        );
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
