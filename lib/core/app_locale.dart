import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const supportedAppLocales = [Locale('pt'), Locale('en')];

class AppLocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() => const Locale('pt');

  void select(Locale locale) => state = locale;
}

final appLocaleProvider = NotifierProvider<AppLocaleNotifier, Locale>(
  AppLocaleNotifier.new,
);
