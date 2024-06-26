import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/models/place_location.dart';

import 'package:favorite_places/providers/places_provider.dart';

import 'package:favorite_places/widgets/location_form_input.dart';
import 'package:favorite_places/widgets/image_form_input.dart';
import 'package:favorite_places/widgets/place_text_field.dart';

class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  ConsumerState<NewPlaceScreen> createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends ConsumerState<NewPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  PlaceLocation? _pickedLocation;
  File? _pickedImage;
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
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
                const SizedBox(height: 16),
                ImageFormInput(
                  onPickedImage: (image) {
                    _pickedImage = image;
                  },
                  validator: (image) {
                    if (image == null) {
                      return 'Please pick an image';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                LocationFormInput(
                  onPickedLocation: (location) {
                    _pickedLocation = location;
                  },
                  validator: (location) {
                    if (location == null) {
                      return 'Please pick a location';
                    }
                    return null;
                  },
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

      Place newPlace = Place.create(
        title: _titleController.text,
        address: _pickedLocation!.address,
        imageUrl: _pickedImage!.path,
        latitude: _pickedLocation!.latitude,
        longitude: _pickedLocation!.longitude,
      );

      // Add place
      ref.read(asyncPlaceProvider.notifier).addPlace(newPlace).then((value) {
        // waiting until the new place is added
        Navigator.of(context).pop();
      });
    }
  }
}
