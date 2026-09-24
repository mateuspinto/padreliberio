import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

/// Kept alive for the app's lifetime — dropping it would let Flutter stop
/// generating the semantics tree, which is what makes text on web
/// selectable/copyable (both renderers draw to a <canvas> otherwise).
// ignore: unused_element
SemanticsHandle? _webSemanticsHandle;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    _webSemanticsHandle = SemanticsBinding.instance.ensureSemantics();
  }
  runApp(const ProviderScope(child: App()));
}
