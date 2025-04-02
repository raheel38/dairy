import 'dart:io';
import 'package:diary/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _selectedImage;

  // You would typically get these values from your auth provider or user state
  final String username = "Username"; // Replace with actual username
  final String email = "user@example.com"; // Replace with actual email

  void _logout() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pop(); // Navigate back after logging out
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),

          // Profile Image
          Center(
            child: UserImagePicker(
              onPickImage: (pickedImage) {
                setState(() {
                  _selectedImage = pickedImage;
                });
              },
            ),
          ),

          const SizedBox(height: 24),

          // Username Text
          Center(
            child: Text(
              username,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Email Text
          Center(
            child: Text(
              email,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),

          const Spacer(), // Pushes the logout button to the bottom

          // Logout Button at the Bottom
          Padding(
            padding: const EdgeInsets.only(
                bottom: 24), // Add some padding at the bottom
            child: TextButton(
              onPressed: _logout,
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
