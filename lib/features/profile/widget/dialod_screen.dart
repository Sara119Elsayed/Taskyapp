import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showImageSourceDialog(BuildContext context, Function(XFile) selectedFile) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(
          'Choose Image Source',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              if (image != null) {
                selectedFile(image);
              }
            },
            padding: const EdgeInsets.all(16),
            child: const Row(
              children: [
                Icon(Icons.camera_alt),
                SizedBox(width: 8),
                Text('Camera'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (image != null) {
                selectedFile(image);
              }
            },
            padding: const EdgeInsets.all(16),
            child: const Row(
              children: [
                Icon(Icons.photo_library),
                SizedBox(width: 8),
                Text('Gallery'),
              ],
            ),
          )
        ],
      );
    },
  );
}