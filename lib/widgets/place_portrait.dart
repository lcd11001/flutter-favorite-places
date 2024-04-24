import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:favorite_places/models/place.dart';

class PlacePortrait extends StatelessWidget {
  final Place place;
  final double height;

  const PlacePortrait({
    super.key,
    required this.place,
    this.height = 300,
  });

  dynamic _getImageProvider() {
    final isNetworkImage = place.imageUrl.startsWith('http');
    return isNetworkImage
        ? CachedNetworkImageProvider(place.imageUrl)
        : FileImage(File(place.imageUrl));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Hero(
      tag: place.id,
      child: FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        image: _getImageProvider(),
        imageErrorBuilder: (context, error, stackTrace) => Container(
          height: height,
          decoration: BoxDecoration(
            color: colorScheme.errorContainer,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error,
                  color: colorScheme.onErrorContainer,
                  size: 50,
                ),
                if (height > 100) const SizedBox(width: 10),
                if (height > 100)
                  Text(
                    'Error loading image ${place.title}',
                    style: textTheme.titleSmall!.copyWith(
                      color: colorScheme.onErrorContainer,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ),
        imageSemanticLabel: 'Image of ${place.title}',
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
