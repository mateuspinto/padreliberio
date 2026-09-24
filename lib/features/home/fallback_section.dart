import 'package:flutter/material.dart';

import '../../core/live_priority.dart';
import '../../l10n/generated/app_localizations.dart';
import '../camera/camera_section.dart';
import 'radio_section.dart';

/// Camera + radio — Início's default content, and always
/// manually reachable even while something is live. Shows a big red banner
/// on top when [livePriority] isn't [NoLive] (tapping it calls
/// [onReturnToLive]), or a calm blue notice at the bottom when it is.
class FallbackSection extends StatelessWidget {
  const FallbackSection({required this.livePriority, required this.onReturnToLive, super.key});

  final LivePriority livePriority;
  final VoidCallback onReturnToLive;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bannerText = switch (livePriority) {
      LiveMass() => l10n.liveMassBannerText,
      LivePadre() => l10n.livePadreBannerText,
      NoLive() => null,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (bannerText != null) ...[
          const SizedBox(height: 16),
          _LiveBanner(text: bannerText, onTap: onReturnToLive),
          const SizedBox(height: 20),
        ],
        const CameraSection(showOpenExternal: false),
        const SizedBox(height: 24),
        const RadioSection(),
        if (livePriority is NoLive) ...[
          const SizedBox(height: 32),
          _NoLiveNotice(text: l10n.noLiveNotice),
        ],
      ],
    );
  }
}

/// Calm, low-key counterpart to [_LiveBanner] — shown instead of it when
/// nothing's live, so Início never feels broken/empty.
class _NoLiveNotice extends StatelessWidget {
  const _NoLiveNotice({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: const Color(0xFFE8EEF5),
      border: Border.all(color: const Color(0xFFA9C0D6)),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xFF2E4A63),
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

class _LiveBanner extends StatefulWidget {
  const _LiveBanner({required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  State<_LiveBanner> createState() => _LiveBannerState();
}

class _LiveBannerState extends State<_LiveBanner> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Material(
    color: const Color(0xFFC62828),
    borderRadius: BorderRadius.circular(16),
    child: InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          children: [
            FadeTransition(
              opacity: _controller,
              child: const DecoratedBox(
                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: SizedBox(width: 18, height: 18),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white, size: 28),
          ],
        ),
      ),
    ),
  );
}
