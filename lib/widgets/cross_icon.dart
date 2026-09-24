import 'package:flutter/material.dart';

/// A plain Latin cross — Flutter's bundled Material Icons set has no such
/// glyph (only `church`, already used for the Horários tab), so this is a
/// couple of cheap `DecoratedBox`es instead of a custom font/SVG asset.
class CrossIcon extends StatelessWidget {
  const CrossIcon({required this.color, this.size = 28, super.key});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: size,
    height: size,
    child: Stack(
      children: [
        Positioned(
          left: size * 0.4,
          right: size * 0.4,
          top: 0,
          bottom: 0,
          child: DecoratedBox(decoration: BoxDecoration(color: color)),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: size * 0.28,
          height: size * 0.18,
          child: DecoratedBox(decoration: BoxDecoration(color: color)),
        ),
      ],
    ),
  );
}
