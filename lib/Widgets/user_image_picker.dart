import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({
    Key? key,
  }) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  var _imageFile;
  File? _storedImage;
  Future<void> _imagePicker() async {
    final picker = ImagePicker();
    _imageFile = await picker.pickImage(source: ImageSource.camera);
    if (_imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(_imageFile!.path);
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(_imageFile!.path);
    final savedImage =
        await File(_imageFile.path).copy('${appDir.path}/$fileName');
    _storedImage = savedImage;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _imagePicker();
      },
      child: CircleAvatar(
        radius: 55,
        backgroundImage: _storedImage == null ? null : FileImage(_storedImage!),
        child: _storedImage != null
            ? null
            : const Icon(
                Icons.add_a_photo_rounded,
                size: 40,
              ),
      ),
    );
  }
}
