import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BingMapsApi {
  static String kKey = 'YOUR_BING_MAPS_API_KEY';
  static const String kBaseUrl = 'dev.virtualearth.net';
  static const String kPathGeoCode = '/REST/v1/Locations';
  static const String kPathStaticMap = '/REST/v1/Imagery/Map/Road';
  static const String kOutputFormat = 'json'; // 'xml' or 'json';
  static const String iconStyle = '66';

  static Future<String> getPlace(String place) async {
    try {
      final response = await http.get(
        Uri.https(kBaseUrl, kPathGeoCode, <String, String>{
          'query': Uri.encodeQueryComponent(place),
          'output': kOutputFormat,
          'key': kKey,
        }),
      );

      // debugPrint("Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        if (body['statusCode'] != 200) {
          return body['statusDescription'] ?? body['statusCode'];
        }

        final String address = body['resourceSets'][0]['resources'][0]
            ['address']['formattedAddress'];
        return address;
      } else if (response.statusCode >= 400) {
        debugPrint("Failed to fetch place: ${response.body}");
      }
    } catch (exception) {
      debugPrint("getPlace Exception: $exception");
    }
    return 'Unknown place';
  }

  static Future<String> getAddress(double latitude, double longitude) async {
    try {
      final point = '$latitude,$longitude';
      final response = await http.get(
        Uri.https(kBaseUrl, '$kPathGeoCode/$point', <String, String>{
          'output': kOutputFormat,
          'key': kKey,
        }),
      );

      // debugPrint("Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        if (body['statusCode'] != 200) {
          return body['statusDescription'] ?? body['statusCode'];
        }

        final String address = body['resourceSets'][0]['resources'][0]
            ['address']['formattedAddress'];
        return address;
      } else if (response.statusCode >= 400) {
        debugPrint("Failed to fetch address: ${response.body}");
      }
    } catch (exception) {
      debugPrint("getAddress Exception: $exception");
    }
    return 'Unknown address';
  }

  static String getStaticMapImageUrl(
    double latitude,
    double longitude, {
    int zoom = 14,
    int width = 600,
    int height = 300,
  }) {
    final String pushpin = '$latitude,$longitude';

    return Uri.https(
        kBaseUrl, '$kPathStaticMap/$pushpin/$zoom', <String, String>{
      'pushpin': '$pushpin;$iconStyle',
      'mapSize': '$width,$height',
      'key': kKey,
    }).toString();
  }
}
