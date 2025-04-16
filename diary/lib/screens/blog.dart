// blog.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary/screens/addEntry.dart';

class BlogEntry {
  final String title;
  final String content;
  final String date;
  final String? imageUrl;

  BlogEntry({
    required this.title,
    required this.content,
    required this.date,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'date': date,
      'imageUrl': imageUrl,
    };
  }

  factory BlogEntry.fromMap(Map<String, dynamic> map) {
    return BlogEntry(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      date: map['date'] ?? '',
      imageUrl: map['imageUrl'],
    );
  }
}

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final List<BlogEntry> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('blog_entries').get();

    final entries =
        snapshot.docs.map((doc) => BlogEntry.fromMap(doc.data())).toList();

    setState(() {
      _entries.clear();
      _entries.addAll(entries);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Blog')),
      body: _entries.isEmpty
          ? const Center(child: Text('No entries yet.'))
          : ListView.builder(
              itemCount: _entries.length,
              itemBuilder: (context, index) {
                final entry = _entries[index];
                return Card(
                  margin: const EdgeInsets.all(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (entry.imageUrl != null &&
                            entry.imageUrl!.isNotEmpty)
                          Image.network(entry.imageUrl!),
                        const SizedBox(height: 8),
                        Text(entry.date,
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 12)),
                        const SizedBox(height: 8),
                        Text(entry.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(entry.content,
                            maxLines: 3, overflow: TextOverflow.ellipsis),
                        TextButton(
                          onPressed: () => _viewEntry(entry),
                          child: const Text('Read more'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddEntryPopup(
              onSave: (entry) async {
                setState(() {
                  _entries.add(entry);
                });
                await FirebaseFirestore.instance
                    .collection('blog_entries')
                    .add(entry.toMap());
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _viewEntry(BlogEntry entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(entry.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (entry.imageUrl != null && entry.imageUrl!.isNotEmpty)
                Image.network(entry.imageUrl!),
              const SizedBox(height: 16),
              Text(entry.date,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              const SizedBox(height: 16),
              Text(entry.content),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
