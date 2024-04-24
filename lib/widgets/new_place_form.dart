import 'package:flutter/material.dart';

class NewPlaceForm extends StatelessWidget {
  const NewPlaceForm({super.key});

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
