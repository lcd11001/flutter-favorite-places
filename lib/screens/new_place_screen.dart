import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/places_provider.dart';

import 'package:favorite_places/widgets/place_text_field.dart';

class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  ConsumerState<NewPlaceScreen> createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends ConsumerState<NewPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                PlaceTextField(
                  titleController: _titleController,
                  title: 'Title',
                  hintErrorText: 'Enter place title',
                  maxLength: 50,
                ),
                PlaceTextField(
                  titleController: _addressController,
                  title: 'Address',
                  hintErrorText: 'Enter place address',
                  maxLength: 50,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(),
                        )
                      : const Icon(
                          Icons.add,
                          size: 20,
                        ),
                  onPressed: _saveNewPlace,
                  label: const Text('Add Place'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveNewPlace() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSaving = true;
      });

      // Save form
      _formKey.currentState!.save();

      final id = uuid.v4();
      Place newPlace = Place(
        id: id,
        title: _titleController.text,
        address: _addressController.text,
        imageUrl: 'https://picsum.photos/seed/$id/200',
        latitude: 0,
        longitude: 0,
      );

      // Add place
      ref.read(asyncPlaceProvider.notifier).addPlace(newPlace).then((value) {
        Navigator.of(context).pop();
      });
    }
  }
}
