import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/section.dart';
import '../l10n/generated/app_localizations.dart';
import '../theme/color_tokens.dart';

/// Desktop/tablet top navbar — scrolls to a section instead of switching screens.
class Navbar extends ConsumerWidget implements PreferredSizeWidget {
  const Navbar({required this.sectionKeys, super.key});

  final Map<Section, GlobalKey> sectionKeys;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final selected = ref.watch(selectedSectionProvider);
    return AppBar(
      title: Text(l10n.appTitle),
      actions: [
        for (final section in Section.values)
          TextButton(
            onPressed: () => _scrollTo(section),
            style: TextButton.styleFrom(
              foregroundColor: selected == section
                  ? ColorTokens.secondary
                  : ColorTokens.white,
            ),
            child: Text(section.label(l10n)),
          ),
        const SizedBox(width: 8),
      ],
    );
  }

  void _scrollTo(Section section) {
    final context = sectionKeys[section]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
}
