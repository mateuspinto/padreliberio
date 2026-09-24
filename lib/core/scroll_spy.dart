import 'package:flutter/widgets.dart';

import 'section.dart';

const double navbarHeight = 64;

/// Port of `useScrollSpy.js`: the lowest section whose top has crossed the
/// navbar is the active one, checked from the bottom of the page upward.
Section sectionAtScrollPosition(Map<Section, GlobalKey> sectionKeys) {
  for (final section in Section.values.reversed) {
    final renderObject = sectionKeys[section]?.currentContext
        ?.findRenderObject();
    if (renderObject is RenderBox && renderObject.attached) {
      final top = renderObject.localToGlobal(Offset.zero).dy;
      if (top <= navbarHeight + 16) return section;
    }
  }
  return Section.values.first;
}
