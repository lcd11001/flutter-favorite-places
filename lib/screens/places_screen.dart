import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';

import '../widgets/new_place_form.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _openAddPlaceScreen(context);
            },
          ),
        ],
      ),
      body: PlacesList(),
    );
  }

  void _openAddPlaceScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewPlaceForm(),
      ),
    );
  }
}
