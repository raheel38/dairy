// addEntry.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:diary/screens/blog.dart';

class AddEntryPopup extends StatefulWidget {
  final void Function(BlogEntry entry) onSave;
  const AddEntryPopup({super.key, required this.onSave});

  @override
  State<AddEntryPopup> createState() => _AddEntryPopupState();
}

class _AddEntryPopupState extends State<AddEntryPopup> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  File? _selectedImage;
  String? _uploadedImageUrl;

  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null && !_isDisposed) {
      if (mounted) {
        setState(() {
          _selectedImage = File(picked.path);
        });
      }

      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = FirebaseStorage.instance.ref().child('blog_images/$fileName');
      await ref.putFile(_selectedImage!);

      final url = await ref.getDownloadURL();
      if (!_isDisposed && mounted) {
        setState(() {
          _uploadedImageUrl = url;
        });
      }
    }
  }

  void _saveEntry() {
    if (_titleController.text.isNotEmpty ||
        _contentController.text.isNotEmpty) {
      final newEntry = BlogEntry(
        title: _titleController.text.isNotEmpty
            ? _titleController.text
            : 'Untitled',
        content: _contentController.text,
        date: _getCurrentDate(),
        imageUrl: _uploadedImageUrl,
      );
      widget.onSave(newEntry);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 400,
        height: 600,
        child: Column(
          children: [
            AppBar(
              title: const Text('New Entry'),
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                TextButton(
                  onPressed: _saveEntry,
                  child: const Text('Save'),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        _getCurrentDate(),
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ),
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _contentController,
                      decoration: const InputDecoration(
                        hintText: 'Start writing your thoughts...',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                      maxLines: 6,
                      textAlignVertical: TextAlignVertical.top,
                    ),
                    const SizedBox(height: 16),
                    if (_selectedImage != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(_selectedImage!, height: 150),
                      ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _pickImage,
                          icon: const Icon(Icons.image),
                          label: const Text('Add Image'),
                        ),
                        const SizedBox(width: 10),
                        if (_selectedImage != null)
                          Text('Image selected',
                              style: TextStyle(color: Colors.green))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    return '${now.day}/${now.month}/${now.year} - ${_getWeekday(now.weekday)}';
  }

  String _getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
}
