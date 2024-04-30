import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_places/api/google_maps_api.dart';
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
      body: Stack(
        children: [
          PlacePortrait(
            place: place,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: CachedNetworkImageProvider(
                    GoogleMapsApi.getStaticMapImageUrl(
                      place.latitude,
                      place.longitude,
                      zoom: 16,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black87,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                  child: PlaceText(
                    content: place.address,
                    size: PlaceTextSize.small,
                    alignment: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
