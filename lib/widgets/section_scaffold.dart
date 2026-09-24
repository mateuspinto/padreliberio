import 'package:flutter/material.dart';

/// Shared max-width/padding container, port of the `.container` CSS class.
class SectionScaffold extends StatelessWidget {
  const SectionScaffold({required this.child, super.key});

  final Widget child;

  static const double maxWidth = 1200;
  static const double horizontalPadding = 16;

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: maxWidth),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: child,
      ),
    ),
  );
}
