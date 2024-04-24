import 'package:flutter/material.dart';

class NewPlaceScreen extends StatelessWidget {
  const NewPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: Center(
        child: Text('Form goes here'),
      ),
    );
  }
}
