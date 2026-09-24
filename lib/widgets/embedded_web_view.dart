import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EmbeddedWebView extends StatefulWidget {
  const EmbeddedWebView({required this.url, super.key});

  final String url;

  @override
  State<EmbeddedWebView> createState() => EmbeddedWebViewState();
}

class EmbeddedWebViewState extends State<EmbeddedWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController();
    // A browser <iframe> always runs JavaScript already — the web platform
    // implementation doesn't support toggling it, unlike native WebViews.
    if (!kIsWeb) {
      controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    }
    controller.loadRequest(Uri.parse(widget.url));
  }

  void reload() => controller.loadRequest(Uri.parse(widget.url));

  @override
  Widget build(BuildContext context) => WebViewWidget(controller: controller);
}
