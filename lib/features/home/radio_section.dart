import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../theme/color_tokens.dart';
import '../../widgets/embedded_web_view.dart';

const _radioPlayerUrl =
    'https://player.brasilstream.com.br/2033694614/barra/'
    '?backgroundColor=FFFFFF&buttonColor=6E2532&fontColor=3A2418';

/// Rádio Santa Cruz FM's own embeddable live-audio player bar.
class RadioSection extends StatelessWidget {
  const RadioSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.radioLiveLabel, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 8),
        Container(
          height: 60,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ColorTokens.border),
          ),
          child: const EmbeddedWebView(url: _radioPlayerUrl),
        ),
      ],
    );
  }
}
