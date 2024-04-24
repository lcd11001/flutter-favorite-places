import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Detail'),
      ),
      body: Center(
        child: Text('Place detail goes here'),
      ),
    );
  }
}
