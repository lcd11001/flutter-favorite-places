import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final void Function(File image) onPickedImage;

  const ImageInput({super.key, required this.onPickedImage});

  @override
  State<StatefulWidget> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final imageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) {
      return;
    }

    debugPrint('Image path: ${imageFile.path}');

    setState(() {
      _selectedImage = File(imageFile.path);
    });

    widget.onPickedImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child:
          _selectedImage == null ? _buildCameraButton() : _buildPreviewImage(),
    );
  }

  Widget _buildCameraButton() {
    return TextButton.icon(
      onPressed: _takePicture,
      icon: const Icon(
        Icons.camera,
        size: 20,
      ),
      label: const Text('Take Picture'),
    );
  }

  Widget _buildPreviewImage() {
    return GestureDetector(
      onTap: _takePicture,
      child: Image.file(
        _selectedImage!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
