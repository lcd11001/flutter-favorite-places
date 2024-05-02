import 'package:favorite_places/utils/file_helper.dart';
import 'package:favorite_places/utils/sqlite_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:favorite_places/models/place.dart';

part 'places_provider.g.dart';

const uuid = Uuid();

@riverpod
class AsyncPlace extends _$AsyncPlace {
  @override
  Future<List<Place>> build() async {
    return _fetchPlaces();
  }

  Future<List<Place>> _fetchPlaces() async {
    /*
    await Future.delayed(const Duration(seconds: 1));

    return List.generate(
      10,
      (index) {
        final id = uuid.v4();
        return Place(
          id: id,
          title: 'Place title ${index + 1}',
          address: 'Place address ${index + 1}',
          imageUrl: 'https://picsum.photos/seed/$id/200',
          latitude: 0,
          longitude: 0,
        );
      },
    );
    */
    final places = await SqliteHelper().queryAll();
    return places.map((place) => Place.fromJson(place)).toList();
  }

  Future<void> addPlace(Place place) async {
    state = await AsyncValue.guard(() async {
      // await Future.delayed(const Duration(seconds: 1));
      if (place.imageUrl.contains('http') == false) {
        final imageFile = await FileHelper.saveFromPath(place.imageUrl);
        place = place.copyWith(imageUrl: imageFile?.path ?? '');
      }

      SqliteHelper().insert(place.toJson());

      return [place, ...state.value ?? []];
    });
  }

  Future<void> removePlace(String id) async {
    state = await AsyncValue.guard(() async {
      // await Future.delayed(const Duration(seconds: 1));
      final place = state.value?.firstWhere((place) => place.id == id);
      if (place != null) {
        await FileHelper.deleteFromPath(place.imageUrl);
      }

      SqliteHelper().delete(id);

      final remainPlaces = state.value?.where((place) => place.id != id);
      return [...remainPlaces ?? []];
    });
  }
}
