import 'package:favorite_places/widgets/place_portrait.dart';
import 'package:flutter/material.dart';

import 'package:favorite_places/models/place.dart';

import '../widgets/place_text.dart';

class PlaceDetailScreen extends StatelessWidget {
  final Place place;
  const PlaceDetailScreen({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              PlacePortrait(place: place),
              const SizedBox(height: 16),
              PlaceText(
                content: place.title,
                size: PlaceTextSize.large,
              ),
              const SizedBox(height: 32),
              PlaceText(
                content: place.address,
                size: PlaceTextSize.small,
                alignment: TextAlign.justify,
              ),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }
}
