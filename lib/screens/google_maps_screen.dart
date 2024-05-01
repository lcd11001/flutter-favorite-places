import 'package:favorite_places/models/place_location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreen extends StatefulWidget {
  final PlaceLocation location;
  final bool isSelecting;

  const GoogleMapsScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: 'Google Headquaters',
    ),
    this.isSelecting = true,
  });

  @override
  State<StatefulWidget> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  late LatLng? _pickedLocation;

  @override
  void initState() {
    super.initState();
    if (!widget.isSelecting) {
      _pickedLocation = LatLng(
        widget.location.latitude,
        widget.location.longitude,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSelecting ? 'Pick your location' : 'Your location',
        ),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {},
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          zoom: 16,
        ),
        onTap: (position) {
          if (widget.isSelecting) {
            setState(() {
              _pickedLocation = position;
            });
          }
        },
        markers: (widget.isSelecting && _pickedLocation == null)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation!,
                  // change default marker color to green
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen,
                  ),
                ),
              },
      ),
    );
  }
}
