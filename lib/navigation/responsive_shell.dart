import 'package:flutter/widgets.dart';

import '../core/breakpoints.dart';
import 'desktop_shell.dart';
import 'mobile_shell.dart';

class ResponsiveShell extends StatelessWidget {
  const ResponsiveShell({super.key});

  @override
  Widget build(BuildContext context) =>
      Breakpoints.isMobile(context) ? const MobileShell() : const DesktopShell();
}
