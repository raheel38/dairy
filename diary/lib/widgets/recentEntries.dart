import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecentEntriesList extends StatelessWidget {
  const RecentEntriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      //
      stream: FirebaseFirestore.instance
          .collection('entries')
          .orderBy('timestamp', descending: true)
          .limit(5) // Limit to most recent 5 entries
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final entries = snapshot.data?.docs ?? [];

        // Fixed conversion code
        final List<Map<String, String>> recentEntries = entries.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          // Safely get the content with null check
          String content = data['content'] as String? ?? '';
          String preview = '';

          // Create preview only if content exists
          if (content.isNotEmpty) {
            preview = content.length > 50
                ? '${content.substring(0, 50)}...'
                : content;
          }

          return {
            'title': data['title'] as String? ?? 'Untitled',
            'date': data['date'] as String? ?? '',
            'preview': preview,
          };
        }).toList();

        return _buildRecentEntriesList(recentEntries);
      },
    );
  }

  Widget _buildRecentEntriesList(List<Map<String, String>> recentEntries) {
    if (recentEntries.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: const Text(
          'No recent entries yet.\nStart writing today!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Recent Entries',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...recentEntries.map((entry) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey[200]!),
            ),
            child: ListTile(
              title: Text(
                entry['title']!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry['date']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry['preview']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              onTap: () {
                // Navigate to view the full entry
              },
            ),
          );
        }).toList(),
      ],
    );
  }
}
