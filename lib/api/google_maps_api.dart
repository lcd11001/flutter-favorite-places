import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GoogleMapsApi {
  static String kKey = 'Your API Key Here';
  static const String kBaseUrl = 'maps.googleapis.com';
  static const String kPathGeoCode = 'maps/api/geocode/';
  static const String kPathStaticMap = 'maps/api/staticmap';
  static const String kOutputFormat = 'json'; // 'xml' or 'json'

  static Future<String> getPlace(String place) async {
    try {
      final response = await http.get(
        Uri.https(kBaseUrl, kPathGeoCode + kOutputFormat, <String, String>{
          'address': Uri.encodeQueryComponent(place),
          'key': kKey,
        }),
      );

      // debugPrint("Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        if (body['status'] != 'OK') {
          return body['error_message'] ?? body['status'];
        }

        final String address = body['results'][0]['formatted_address'];
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
      final response = await http.get(
        Uri.https(kBaseUrl, kPathGeoCode + kOutputFormat, <String, String>{
          'latlng': '$latitude,$longitude',
          'key': kKey,
        }),
      );

      // debugPrint("Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        if (body['status'] != 'OK') {
          return body['error_message'] ?? body['status'];
        }

        final String address = body['results'][0]['formatted_address'];
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
    int zoom = 16,
    int width = 600,
    int height = 300,
    String mapType = 'roadmap', // 'satellite', 'hybrid', 'terrain
  }) {
    return Uri.https(kBaseUrl, kPathStaticMap, <String, String>{
      'center': '$latitude,$longitude',
      'zoom': '$zoom',
      'size': '${width}x$height',
      'markers': 'color:red|$latitude,$longitude',
      'maptype': mapType,
      'key': kKey,
    }).toString();
  }
}
