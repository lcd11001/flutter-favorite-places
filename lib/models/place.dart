import 'package:freezed_annotation/freezed_annotation.dart';

// Execute the following command in the terminal to generate the part files:
// flutter pub run build_runner build
part 'place.freezed.dart';
part 'place.g.dart';

@freezed
class Place with _$Place {
  factory Place({
    required String id,
    required String title,
    required String address,
    required String imageUrl,
    required double latitude,
    required double longitude,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
}
