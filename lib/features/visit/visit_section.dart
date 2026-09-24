import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../theme/color_tokens.dart';

final _mapsLinkUri = Uri.parse(
  'https://maps.google.com/?q=Mina+do+Padre+Lib%C3%A9rio,+S%C3%A3o+Jos%C3%A9+da+Varginha,+MG,+Brasil',
);

class VisitSection extends StatelessWidget {
  const VisitSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.navVisit, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 24),
          _InfoCard(l10n: l10n),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.l10n});

  final AppLocalizations l10n;

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
        _InfoItem(
          icon: Icons.place_outlined,
          label: l10n.visitAddressLabel,
          value: '${l10n.visitAddress}\n${l10n.visitAddressCep}',
        ),
        const SizedBox(height: 16),
        _InfoItem(
          icon: Icons.schedule,
          label: l10n.visitHoursLabel,
          value: l10n.visitHours,
        ),
        const SizedBox(height: 16),
        _InfoItem(
          icon: Icons.door_back_door_outlined,
          label: l10n.visitEntryLabel,
          value: l10n.visitEntry,
        ),
        const SizedBox(height: 16),
        _InfoItem(
          icon: Icons.signpost_outlined,
          label: l10n.visitDirectionsLabel,
          value: l10n.visitDirectionsTip,
        ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: () => launchUrl(_mapsLinkUri),
          icon: const Icon(Icons.map_outlined),
          label: Text(l10n.visitCta),
          style: FilledButton.styleFrom(backgroundColor: ColorTokens.secondary),
        ),
      ],
    ),
  );
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: ColorTokens.secondary),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: ColorTokens.secondary,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 2),
            Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    ],
  );
}
