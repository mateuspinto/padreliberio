import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:minapadreliberio/features/about/about_section.dart';
import 'package:minapadreliberio/l10n/generated/app_localizations.dart';

void main() {
  testWidgets('AboutSection renders localized card titles', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(
          body: SingleChildScrollView(child: AboutSection()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Horários de Missa'), findsOneWidget);
    expect(find.text('Entrada Gratuita'), findsOneWidget);
    expect(find.text('Turismo Religioso'), findsOneWidget);
  });
}
