import 'package:flutter/material.dart';

import '../../core/breakpoints.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../theme/color_tokens.dart';
import 'history_milestone.dart';

class HistorySection extends StatelessWidget {
  const HistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final wide = MediaQuery.sizeOf(context).width >= Breakpoints.lg;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.navHistory, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 24),
          wide ? const _HorizontalTimeline() : const _VerticalTimeline(),
        ],
      ),
    );
  }
}

class _VerticalTimeline extends StatelessWidget {
  const _VerticalTimeline();

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (final milestone in HistoryMilestoneId.values)
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  const _Dot(),
                  if (milestone != HistoryMilestoneId.values.last)
                    const Expanded(child: _Line(vertical: true)),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: _MilestoneCard(milestone: milestone),
                ),
              ),
            ],
          ),
        ),
    ],
  );
}

class _HorizontalTimeline extends StatelessWidget {
  const _HorizontalTimeline();

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.topCenter,
    children: [
      const Padding(
        padding: EdgeInsets.only(top: 6),
        child: _Line(vertical: false),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final milestone in HistoryMilestoneId.values)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    const _Dot(),
                    const SizedBox(height: 16),
                    _MilestoneCard(milestone: milestone),
                  ],
                ),
              ),
            ),
        ],
      ),
    ],
  );
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) => Container(
    width: 14,
    height: 14,
    decoration: const BoxDecoration(
      color: ColorTokens.secondary,
      shape: BoxShape.circle,
    ),
  );
}

class _Line extends StatelessWidget {
  const _Line({required this.vertical});

  final bool vertical;

  @override
  Widget build(BuildContext context) => Container(
    width: vertical ? 2 : null,
    height: vertical ? null : 2,
    color: ColorTokens.secondaryFaded,
  );
}

class _MilestoneCard extends StatelessWidget {
  const _MilestoneCard({required this.milestone});

  final HistoryMilestoneId milestone;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorTokens.surface,
        border: Border.all(color: ColorTokens.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            milestone.year(l10n),
            style: const TextStyle(
              color: ColorTokens.secondary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(milestone.text(l10n), style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
