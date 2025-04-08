import 'dart:math';
import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  QuoteCard({super.key});

  final List<String> _quotes = const [
    "Believe in yourself and all that you are.",
    "You are stronger than you think.",
    "Start where you are. Use what you have. Do what you can.",
    "Push yourself, because no one else is going to do it for you.",
    "Success doesn't come from what you do occasionally, it comes from what you do consistently.",
    "Don't watch the clock; do what it does. Keep going.",
    "Discipline is choosing between what you want now and what you want most.",
    "Your only limit is your mind.",
    "Every day is a chance to get better.",
    "Make today count."
  ];

  String get _randomQuote {
    final random = Random();
    return _quotes[random.nextInt(_quotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
              const Text(
                'Quote of the Day',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _randomQuote,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
