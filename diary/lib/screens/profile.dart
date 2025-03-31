import 'dart:io';

import 'package:diary/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return UserImagePicker(
      onPickImage: (pickedImage) {
        _selectedImage = pickedImage;
      },
    );
  }
}
