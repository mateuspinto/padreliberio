import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app_locale.dart';
import 'l10n/generated/app_localizations.dart';
import 'navigation/responsive_shell.dart';
import 'theme/app_theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp(
    onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
    theme: buildAppTheme(),
    locale: ref.watch(appLocaleProvider),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: supportedAppLocales,
    debugShowCheckedModeBanner: false,
    // Text selection is a web-only concern — app builds draw straight to a
    // native canvas/surface and don't need Flutter's own selection layer.
    //
    // `child` here is the Navigator MaterialApp builds internally, so it sits
    // *below* this builder — wrapping SelectionArea directly around it puts
    // SelectableRegion above the only Overlay in the tree (the Navigator's),
    // instead of below it. Nest a fresh Overlay so SelectableRegion has one
    // as an ancestor.
    builder: (context, child) => kIsWeb
        ? SelectionArea(
            child: Overlay(initialEntries: [OverlayEntry(builder: (context) => child!)]),
          )
        : child!,
    home: const ResponsiveShell(),
  );
}
