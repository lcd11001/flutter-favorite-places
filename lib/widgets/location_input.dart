import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_places/api/google_maps_api.dart';
import 'package:favorite_places/models/place_location.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final void Function(PlaceLocation location) onPickedLocation;

  const LocationInput({
    super.key,
    required this.onPickedLocation,
  });

  @override
  State<StatefulWidget> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  bool _isGettingLocation = false;

  void _getCurrentLocation() async {
    Location location = Location.instance;

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    debugPrint('Location: ${locationData.latitude}, ${locationData.longitude}');
    final address = await GoogleMapsApi.getAddress(
        locationData.latitude!, locationData.longitude!);
    debugPrint('Address: $address');

    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
        address: address,
      );
      _isGettingLocation = false;
    });

    widget.onPickedLocation(_pickedLocation!);
  }

  Widget buildPreviewMap() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (_isGettingLocation && _pickedLocation == null) {
      return Center(
        child: CircularProgressIndicator(
          color: colorScheme.onSurface,
        ),
      );
    }

    if (_pickedLocation == null) {
      return Center(
        child: Text(
          'No Location Chosen',
          style: textTheme.labelLarge!.copyWith(
            color: colorScheme.primary,
          ),
        ),
      );
    }

    return Stack(
      children: [
        CachedNetworkImage(
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          imageUrl: GoogleMapsApi.getStaticMapImageUrl(
            _pickedLocation!.latitude,
            _pickedLocation!.longitude,
            zoom: 16,
          ),
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Center(
            child: Icon(
              Icons.error,
              size: 40,
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          left: 8,
          right: 8,
          child: Text(
            _pickedLocation!.address,
            style: textTheme.labelLarge!.copyWith(
              color: colorScheme.onInverseSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if (_isGettingLocation)
          Center(
            child: CircularProgressIndicator(
              color: colorScheme.onInverseSurface,
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: colorScheme.primary.withOpacity(0.2),
            ),
          ),
          height: 170,
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: buildPreviewMap(),
        ),
        IntrinsicWidth(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: _getCurrentLocation,
                  icon: const Icon(
                    Icons.location_on,
                    size: 20,
                  ),
                  label: const Text('Current Location'),
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.map,
                    size: 20,
                  ),
                  label: const Text('Select on Map'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
