import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  // final Function onSelectPlace;

  const LocationInput({
    super.key,
    // required this.onSelectPlace,
  });

  @override
  State<StatefulWidget> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LocationData? _pickedLocation;
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

    setState(() {
      _pickedLocation = locationData;
      _isGettingLocation = false;
    });
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
          child: Center(
            child: Text(
              _pickedLocation == null
                  ? 'No Location Chosen'
                  : 'Location Chosen (${_pickedLocation!.latitude}, ${_pickedLocation!.longitude})',
              style: textTheme.labelLarge!.copyWith(
                color: colorScheme.primary,
              ),
            ),
          ),
        ),
        IntrinsicWidth(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: _getCurrentLocation,
                  icon: _isGettingLocation
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(),
                        )
                      : const Icon(
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
