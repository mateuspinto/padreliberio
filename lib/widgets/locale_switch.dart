import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/app_locale.dart';

class LocaleSwitch extends ConsumerWidget {
  const LocaleSwitch({this.color, super.key});

  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(appLocaleProvider);
    return PopupMenuButton<Locale>(
      tooltip: 'Language',
      initialValue: locale,
      onSelected: (value) => ref.read(appLocaleProvider.notifier).select(value),
      itemBuilder: (context) => const [
        PopupMenuItem(value: Locale('pt'), child: Text('Português')),
        PopupMenuItem(value: Locale('en'), child: Text('English')),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.language, size: 18, color: color),
            const SizedBox(width: 4),
            Text(locale.languageCode.toUpperCase(), style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}
