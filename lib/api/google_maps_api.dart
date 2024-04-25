import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GoogleMapsApi {
  static String kKey = 'Your API Key Here';
  static const String kBaseUrl = 'maps.googleapis.com';
  static const String kPath = 'maps/api/geocode/';
  static const String kOutputFormat = 'json'; // 'xml' or 'json'

  static Future<String> getPlace(String place) async {
    try {
      final response = await http.get(
        Uri.https(kBaseUrl, kPath + kOutputFormat, <String, String>{
          'address': Uri.encodeQueryComponent(place),
          'key': kKey,
        }),
      );

      debugPrint("Response: ${response.body}");

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
        Uri.https(kBaseUrl, kPath + kOutputFormat, <String, String>{
          'latlng': '$latitude,$longitude',
          'key': kKey,
        }),
      );

      debugPrint("Response: ${response.body}");

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
}
