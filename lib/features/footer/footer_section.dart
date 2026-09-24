import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../theme/color_tokens.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  static final Uri _developerLinkedin = Uri.parse(
    'https://www.linkedin.com/in/mateuspinto/',
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Text(
            l10n.footerDescription,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Text(
            '© ${DateTime.now().year} ${l10n.footerCopyright}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Text('${l10n.footerDevPrefix} ', style: Theme.of(context).textTheme.bodyMedium),
              InkWell(
                onTap: () => launchUrl(_developerLinkedin),
                child: Text(
                  l10n.footerDevName,
                  style: const TextStyle(
                    color: ColorTokens.secondary,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Text(' ${l10n.footerDevSuffix}', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}
