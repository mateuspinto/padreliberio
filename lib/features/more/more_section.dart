import 'package:flutter/material.dart';

import '../../core/section.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../theme/color_tokens.dart';
import '../../widgets/section_scaffold.dart';
import '../about/about_section.dart';
import '../history/history_section.dart';
import '../velario/velario_section.dart';
import '../visit/visit_section.dart';

const _moreSections = [Section.velario, Section.about, Section.history, Section.visit];

/// "Outros" tab: a big icon+label list (A12 menu style). Each row pushes a
/// full-screen page instead of trying to keep a bottom-tab selected while
/// inside a sub-page.
class MoreSection extends StatelessWidget {
  const MoreSection({super.key});

  Widget _bodyFor(Section section) => switch (section) {
    Section.velario => const VelarioSection(),
    Section.about => const AboutSection(includeFooter: true),
    Section.history => const HistorySection(),
    Section.visit => const VisitSection(),
    Section.camera || Section.schedule || Section.donation =>
      throw StateError('$section is a primary tab, not a Mais destination'),
  };

  void _open(BuildContext context, Section section, AppLocalizations l10n) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text(section.label(l10n))),
          body: SingleChildScrollView(child: SectionScaffold(child: _bodyFor(section))),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: _moreSections.length,
      separatorBuilder: (context, index) => const Divider(height: 1, color: ColorTokens.border),
      itemBuilder: (context, index) {
        final section = _moreSections[index];
        return InkWell(
          onTap: () => _open(context, section, l10n),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Icon(section.icon, color: ColorTokens.secondary, size: 28),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    section.label(l10n),
                    style: const TextStyle(
                      color: ColorTokens.text,
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, color: ColorTokens.textMuted),
              ],
            ),
          ),
        );
      },
    );
  }
}
