import 'package:flutter/material.dart';

/// Stand-in body for a section not yet ported from the Vue site.
class SectionPlaceholder extends StatelessWidget {
  const SectionPlaceholder({required this.title, required this.body, super.key});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 12),
        Text(body, style: Theme.of(context).textTheme.bodyMedium),
      ],
    ),
  );
}
