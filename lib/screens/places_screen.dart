import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/widgets/places_list.dart';

import 'package:favorite_places/screens/new_place_screen.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPlaces = ref.watch(asyncPlaceProvider);

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
      body: switch (asyncPlaces) {
        AsyncData(:final value) => PlacesList(
            places: value,
          ),
        AsyncError(:final error) => Center(
            child: Text('An error occurred: $error'),
          ),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      },
    );
  }

  void _openAddPlaceScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewPlaceScreen(),
      ),
    );
  }
}
