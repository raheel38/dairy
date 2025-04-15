import 'package:diary/widgets/quoteCard.dart';
import 'package:diary/widgets/recentEntries.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Homeescreen extends StatelessWidget {
  const Homeescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome section
          const Text(
            'Welcome to Notie',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Capture your thoughts and ideas',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),

          const SizedBox(height: 30),

          // Quick stats card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(context, '3', 'Entries this week'),
                _buildDivider(),
                _buildStatItem(context, '12', 'Total entries'),
                _buildDivider(),
                _buildStatItem(context, '2', 'Days streak'),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Recent entries section
          const Text(
            'Recent Entries',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          // List of recent entries
          RecentEntriesList(),

          const SizedBox(height: 30),

          // Daily tip section
          QuoteCard(),

          const SizedBox(height: 30),

          // Mood tracker section
          // _buildMoodTrackerSection(context),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey[300],
    );
  }

  // Widget _buildRecentEntriesList() {
  //   // Placeholder data - replace with real data
  //   //Replace this
  //   final List<Map<String, String>> recentEntries = [
  //     {
  //       'title': 'My thoughts today',
  //       'date': '02/04/2025',
  //       'preview': 'Today was quite productive. I managed to...'
  //     },
  //     {
  //       'title': 'Project ideas',
  //       'date': '01/04/2025',
  //       'preview': 'Ive been thinking about starting a new...'
  //     },
  //   ];

  //   if (recentEntries.isEmpty) {
  //     return Container(
  //       padding: const EdgeInsets.all(20),
  //       alignment: Alignment.center,
  //       child: const Text(
  //         'No recent entries yet.\nStart writing today!',
  //         textAlign: TextAlign.center,
  //         style: TextStyle(color: Colors.grey),
  //       ),
  //     );
  //   }

  //   return Column(
  //     children: recentEntries.map((entry) {
  //       return Card(
  //         margin: const EdgeInsets.only(bottom: 12),
  //         elevation: 0,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(8),
  //           side: BorderSide(color: Colors.grey[200]!),
  //         ),
  //         child: ListTile(
  //           title: Text(
  //             entry['title']!,
  //             style: const TextStyle(fontWeight: FontWeight.w500),
  //           ),
  //           subtitle: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 entry['date']!,
  //                 style: TextStyle(
  //                   fontSize: 12,
  //                   color: Colors.grey[600],
  //                 ),
  //               ),
  //               const SizedBox(height: 4),
  //               Text(
  //                 entry['preview']!,
  //                 maxLines: 1,
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //             ],
  //           ),
  //           contentPadding:
  //               const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //           onTap: () {
  //             // View full entry
  //           },
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }

  // Widget _buildMoodTrackerSection(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text(
  //         'How are you feeling today?',
  //         style: TextStyle(
  //           fontSize: 18,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       const SizedBox(height: 16),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           _buildMoodButton(context, '😊', 'Happy'),
  //           _buildMoodButton(context, '😐', 'Neutral'),
  //           _buildMoodButton(context, '😔', 'Sad'),
  //           _buildMoodButton(context, '😡', 'Angry'),
  //           _buildMoodButton(context, '😴', 'Tired'),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Widget _buildMoodButton(BuildContext context, String emoji, String label) {
    return InkWell(
      onTap: () {
        // Save mood
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You\'re feeling $label today')),
        );
      },
      child: Column(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
