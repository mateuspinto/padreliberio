import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../widgets/section_placeholder.dart';

/// Interim implementation until the final native rewrite (see SPECS.md §9).
class VelarioSection extends StatelessWidget {
  const VelarioSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SectionPlaceholder(
      title: l10n.navVelario,
      body: l10n.velarioNotAvailable,
    );
  }
}
