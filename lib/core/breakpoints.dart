import 'package:flutter/widgets.dart';

/// Port of the sm/md/lg breakpoints from `main.css`.
abstract final class Breakpoints {
  static const double sm = 480;
  static const double md = 768;
  static const double lg = 1024;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < md;
}
