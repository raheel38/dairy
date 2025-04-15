import 'package:flutter/material.dart';
import 'package:diary/screens/addEntry.dart';

class RecentEntriesList extends StatelessWidget {
  const RecentEntriesList({Key? key}) : super(key: key);

  Widget _buildRecentEntriesList() {
    // Placeholder data - replace with real data
    final List<Map<String, String>> recentEntries = [
      {
        'title': 'My thoughts today',
        'date': '02/04/2025',
        'preview': 'Today was quite productive. I managed to...'
      },
      {
        'title': 'Project ideas',
        'date': '01/04/2025',
        'preview': 'Ive been thinking about starting a new...'
      },
    ];

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
      children: recentEntries.map((entry) {
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
              // View full entry
            },
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildRecentEntriesList();
  }
}
