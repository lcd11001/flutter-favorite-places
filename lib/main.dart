import 'package:favorite_places/api/bing_maps_api.dart';
import 'package:favorite_places/api/google_maps_api.dart';
import 'package:favorite_places/screens/places_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 102, 6, 247),
  background: const Color.fromARGB(255, 56, 49, 66),
);

final theme = ThemeData.dark(useMaterial3: true).copyWith(
  scaffoldBackgroundColor: colorScheme.background,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
  ),
);

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  if (dotenv.env.containsKey('GOOGLE_MAPS_API_KEY')) {
    GoogleMapsApi.kKey = dotenv.env['GOOGLE_MAPS_API_KEY']!;
    debugPrint('dotevn::Google Maps API Key: ${GoogleMapsApi.kKey}');
  }
  if (dotenv.env.containsKey('BING_MAPS_API_KEY')) {
    BingMapsApi.kKey = dotenv.env['BING_MAPS_API_KEY']!;
    debugPrint('dotevn::Bing Maps API Key: ${BingMapsApi.kKey}');
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Greate Places',
        theme: theme,
        home: const PlacesScreen(),
      ),
    );
  }
}
