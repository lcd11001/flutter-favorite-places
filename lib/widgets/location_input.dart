import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_places/api/bing_maps_api.dart';
import 'package:favorite_places/api/google_maps_api.dart';
import 'package:favorite_places/models/place_location.dart';
import 'package:favorite_places/screens/google_maps_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

const bool _kUseGoogleMaps = !true;

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

    await _dispatchLocation(locationData.latitude!, locationData.longitude!);
  }

  Widget buildPreviewMap() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (_isGettingLocation && _pickedLocation == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CircularProgressIndicator(
              color: colorScheme.primary,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Getting location...',
              style: textTheme.labelLarge!.copyWith(
                color: colorScheme.primary,
              ),
            )
          ],
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
          imageUrl: _kUseGoogleMaps
              ? GoogleMapsApi.getStaticMapImageUrl(
                  _pickedLocation!.latitude,
                  _pickedLocation!.longitude,
                  zoom: 16,
                )
              : BingMapsApi.getStaticMapImageUrl(
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
    // final textTheme = Theme.of(context).textTheme;

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
                  onPressed: _pickMapLocation,
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

  void _pickMapLocation() async {
    final locationData = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => GoogleMapsScreen(
          isSelecting: true,
          location: _pickedLocation ??
              const PlaceLocation(
                latitude: 37.422,
                longitude: -122.084,
                address: 'Google Headquaters',
              ),
        ),
      ),
    );

    if (locationData == null) {
      return;
    }

    await _dispatchLocation(locationData.latitude, locationData.longitude);
  }

  Future<void> _dispatchLocation(double latitude, double longitude) async {
    setState(() {
      _isGettingLocation = true;
    });

    debugPrint('Location: $latitude, $longitude');
    final address = _kUseGoogleMaps
        ? await GoogleMapsApi.getAddress(
            latitude,
            longitude,
          )
        : await BingMapsApi.getAddress(
            latitude,
            longitude,
          );
    debugPrint('Address: $address');

    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: latitude,
        longitude: longitude,
        address: address,
      );
      _isGettingLocation = false;
    });

    widget.onPickedLocation(_pickedLocation!);
  }
}
