import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../theme/color_tokens.dart';

class DonationSection extends StatelessWidget {
  const DonationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 32,
        runSpacing: 24,
        children: [
          SizedBox(
            width: 360,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.donationTitle, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 12),
                Text(l10n.donationSubtitle, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 12),
                Text(
                  l10n.donationInstruction,
                  style: const TextStyle(
                    color: ColorTokens.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorTokens.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ColorTokens.primary, width: 3),
            ),
            child: Semantics(
              label: l10n.donationQrAlt,
              image: true,
              child: Image.asset(
                'assets/images/qrcode_pix.jpg',
                width: 220,
                height: 220,
                excludeFromSemantics: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
