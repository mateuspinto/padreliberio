import 'package:flutter/material.dart';

import '../theme/color_tokens.dart';

class BottomBarItem {
  const BottomBarItem({required this.iconBuilder, required this.label});

  final Widget Function(Color color) iconBuilder;
  final String label;
}

/// Flat, edge-to-edge, always-visible bottom nav — the "iPhone style,
/// always" requirement: no floating pill, no rounding, no auto-hide, and
/// labels are always shown (not just on selection) per CLAUDE.md's
/// elderly-usability rules.
class FixedBottomBar extends StatelessWidget {
  const FixedBottomBar({
    required this.items,
    required this.selectedIndex,
    required this.onSelect,
    super.key,
  });

  final List<BottomBarItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      color: ColorTokens.surface,
      border: Border(top: BorderSide(color: ColorTokens.border)),
    ),
    child: SafeArea(
      top: false,
      child: SizedBox(
        height: 72,
        child: Row(
          children: [
            for (final (index, item) in items.indexed)
              Expanded(
                child: _BottomBarButton(
                  item: item,
                  selected: index == selectedIndex,
                  onTap: () => onSelect(index),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

class _BottomBarButton extends StatelessWidget {
  const _BottomBarButton({required this.item, required this.selected, required this.onTap});

  final BottomBarItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? ColorTokens.primary : ColorTokens.textMuted;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          item.iconBuilder(color),
          const SizedBox(height: 4),
          Text(
            item.label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
