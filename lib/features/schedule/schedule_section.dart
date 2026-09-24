import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../theme/color_tokens.dart';

class ScheduleSection extends StatelessWidget {
  const ScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.navSchedule, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 24),
          _ScheduleCard(
            icon: Icons.church_outlined,
            title: l10n.scheduleMassesTitle,
            body: l10n.scheduleMassesText,
          ),
          const SizedBox(height: 16),
          _ScheduleCard(
            icon: Icons.live_tv_outlined,
            title: l10n.scheduleLivesTitle,
            body: l10n.scheduleLivesComingSoon,
          ),
        ],
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({required this.icon, required this.title, required this.body});

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
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: ColorTokens.secondaryFaded,
          child: Icon(icon, color: ColorTokens.secondary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: ColorTokens.text,
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                ),
              ),
              const SizedBox(height: 8),
              Text(body, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    ),
  );
}
