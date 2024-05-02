import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

// Execute the following command in the terminal to generate the part files:
// flutter pub run build_runner build
part 'place.freezed.dart';
part 'place.g.dart';

const _uuid = Uuid();

@freezed
class Place with _$Place {
  factory Place._({
    required String id,
    required String title,
    required String address,
    required String imageUrl,
    required double latitude,
    required double longitude,
  }) = _Place;

  factory Place.create({
    required String title,
    required String address,
    required String imageUrl,
    required double latitude,
    required double longitude,
  }) =>
      Place._(
        id: _uuid.v4(),
        title: title,
        address: address,
        imageUrl: imageUrl,
        latitude: latitude,
        longitude: longitude,
      );

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
}
