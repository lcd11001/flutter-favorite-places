import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:favorite_places/models/place.dart';

part 'places_provider.g.dart';

@riverpod
class AsyncPlace extends _$AsyncPlace {
  @override
  Future<List<Place>> build() async {
    return _fetchPlaces();
  }

  Future<List<Place>> _fetchPlaces() async {
    await Future.delayed(const Duration(seconds: 1));

    return List.generate(
      10,
      (index) => Place(
        id: index.toString(),
        title: 'Place title $index',
        address: 'Place address $index',
        imageUrl: 'https://picsum.photos/seed/$index/200',
        latitude: 0,
        longitude: 0,
      ),
    );
  }

  Future<void> addPlace(Place place) async {
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 1));
      return [...state.value ?? [], place];
    });
  }

  Future<void> removePlace(String id) async {
    state = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 1));
      final remainPlaces = state.value?.where((place) => place.id != id);
      return [...remainPlaces ?? []];
    });
  }
}
