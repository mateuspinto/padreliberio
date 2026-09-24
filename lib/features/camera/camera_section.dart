import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../widgets/embedded_web_view.dart';

const _cameraUrl =
    'https://safecam.brsuper.com.br/#/cembed/09e18bf10772b7e977c366c9ed61ab21554a9b137421eda2f06f7f221e9fa24c7ce8552b7a7327799dbf93151b6f';
final _cameraExternalUri = Uri.parse('https://minapadreliberio.brsuper.com.br/');
const _autoReloadInterval = Duration(minutes: 5);

class CameraSection extends StatefulWidget {
  /// [showOpenExternal] defaults to true (desktop, where "open in a new
  /// tab" is a familiar browser action) — mobile's `HomeSection` passes
  /// false, since there's no "tab" concept on a phone.
  const CameraSection({this.showOpenExternal = true, super.key});

  final bool showOpenExternal;

  @override
  State<CameraSection> createState() => _CameraSectionState();
}

class _CameraSectionState extends State<CameraSection> with WidgetsBindingObserver {
  final _webViewKey = GlobalKey<EmbeddedWebViewState>();
  Timer? _autoReloadTimer;
  DateTime _lastReload = DateTime.now();
  DateTime? _hiddenAt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _autoReloadTimer = Timer.periodic(_autoReloadInterval, (_) => _reload());
  }

  @override
  void dispose() {
    _autoReloadTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.hidden) {
      _hiddenAt = DateTime.now();
      return;
    }
    final hiddenAt = _hiddenAt;
    if (state == AppLifecycleState.resumed && hiddenAt != null) {
      if (DateTime.now().difference(hiddenAt) > _autoReloadInterval) _reload();
      _hiddenAt = null;
    }
  }

  void _reload() {
    _webViewKey.currentState?.reload();
    setState(() => _lastReload = DateTime.now());
  }

  void _openFullscreen() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => const _CameraFullscreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.navCamera, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ColoredBox(
                    color: Colors.black,
                    child: IgnorePointer(
                      child: EmbeddedWebView(key: _webViewKey, url: _cameraUrl),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: _LiveBadge(label: l10n.cameraLiveBadge),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          runSpacing: 8,
          children: [
            Text(
              TimeOfDay.fromDateTime(_lastReload).format(context),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            TextButton.icon(
              onPressed: _reload,
              icon: const Icon(Icons.refresh, size: 16),
              label: Text(l10n.cameraReload),
            ),
            TextButton.icon(
              onPressed: _openFullscreen,
              icon: const Icon(Icons.fullscreen, size: 16),
              label: Text(l10n.cameraFullscreen),
            ),
            if (widget.showOpenExternal)
              TextButton.icon(
                onPressed: () => launchUrl(_cameraExternalUri),
                icon: const Icon(Icons.open_in_new, size: 16),
                label: Text(l10n.cameraOpenExternal),
              ),
          ],
        ),
      ],
    );
  }
}

class _CameraFullscreen extends StatefulWidget {
  const _CameraFullscreen();

  @override
  State<_CameraFullscreen> createState() => _CameraFullscreenState();
}

class _CameraFullscreenState extends State<_CameraFullscreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Center(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: IgnorePointer(child: EmbeddedWebView(url: _cameraUrl)),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close, color: Colors.white),
              tooltip: l10n.cameraExitFullscreen,
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveBadge extends StatefulWidget {
  const _LiveBadge({required this.label});

  final String label;

  @override
  State<_LiveBadge> createState() => _LiveBadgeState();
}

class _LiveBadgeState extends State<_LiveBadge> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: const Color(0x8C000000),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: const Color(0x80EF5350)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeTransition(
          opacity: _controller,
          child: const DecoratedBox(
            decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: SizedBox(width: 6, height: 6),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          widget.label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ],
    ),
  );
}
