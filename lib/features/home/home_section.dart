import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/live_priority.dart';
import '../../l10n/generated/app_localizations.dart';
import 'fallback_section.dart';
import 'live_stream_section.dart';

/// Início: leads with whatever's actually live right now (Missa outranks
/// Padre Geraldo Gabriel's live), falling back to camera+radio otherwise —
/// always manually reachable via the fallback button/banner regardless.
///
/// Web never auto-detects (no CORS on YouTube's side to check from a
/// browser — see `core/youtube_live_check.dart`), so it's always the
/// fallback page there.
class HomeSection extends ConsumerStatefulWidget {
  const HomeSection({super.key});

  @override
  ConsumerState<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends ConsumerState<HomeSection> {
  var _showFallback = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (kIsWeb) {
      return FallbackSection(livePriority: const NoLive(), onReturnToLive: () {});
    }

    final priority = ref.watch(livePriorityProvider);

    if (_showFallback) {
      return FallbackSection(
        livePriority: priority,
        onReturnToLive: () => setState(() => _showFallback = false),
      );
    }

    return switch (priority) {
      LiveMass(:final videoId) => LiveStreamSection(
        videoId: videoId,
        title: l10n.liveMassTitle,
        onShowFallback: () => setState(() => _showFallback = true),
      ),
      LivePadre(:final videoId) => LiveStreamSection(
        videoId: videoId,
        title: l10n.livePadreTitle,
        onShowFallback: () => setState(() => _showFallback = true),
      ),
      NoLive() => const FallbackSection(livePriority: NoLive(), onReturnToLive: _noop),
    };
  }
}

void _noop() {}
