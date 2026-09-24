import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../theme/color_tokens.dart';
import '../footer/footer_section.dart';

/// Folds `FooterSection` at its tail on mobile (see SPECS.md §3.1).
class AboutSection extends StatelessWidget {
  const AboutSection({this.includeFooter = false, super.key});

  final bool includeFooter;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cards = [
      _AboutCard(
        icon: Icons.meeting_room_outlined,
        title: l10n.aboutCard2Title,
        body: l10n.aboutCard2Text,
      ),
      _AboutCard(
        icon: Icons.tour_outlined,
        title: l10n.aboutCard3Title,
        body: l10n.aboutCard3Text,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.navAbout, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [for (final card in cards) SizedBox(width: 280, child: card)],
          ),
          if (includeFooter) ...[const SizedBox(height: 48), const FooterSection()],
        ],
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard({required this.icon, required this.title, required this.body});

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: ColorTokens.surface,
      border: Border.all(color: ColorTokens.border),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: ColorTokens.secondaryFaded,
          child: Icon(icon, color: ColorTokens.secondary),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            color: ColorTokens.text,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        const SizedBox(height: 8),
        Text(body, style: Theme.of(context).textTheme.bodyMedium),
      ],
    ),
  );
}
