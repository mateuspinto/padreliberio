import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'youtube_live_check.dart';

// Real YouTube channel ids (the live-check/embed APIs need the UC... id,
// not the @handle — resolved once via each channel's public page data, no
// API key needed).
const _realMassChannelId = 'UCG9C_u90PbN3rQLTi_7kt2w'; // Missa: Rádio Santa Cruz FM, youtube.com/@radiosantacruzfm5590
const _realPadreChannelId = 'UCr0RBjOEsHJ39NiwVBzJ_gg'; // Padre Geraldo Gabriel, youtube.com/@GGPadre

// Lofi Girl's channel is reliably live 24/7 — used in test mode
// (`make dandroid TEST=1` / `make android TEST=1`, see the Makefile) to
// exercise the live-detection UI without waiting for a real Mass/Padre
// broadcast. Both slots point at the same channel, so test mode always
// resolves to "Missa" (it outranks Padre) — swap one of the two below for
// a second always-live channel if you need to test the Padre-only path.
const _testChannelId = 'UCSJ4gkVC6NrvII8umztf0Ow';

const _useTestChannels = bool.fromEnvironment('USE_TEST_CHANNELS');

const massChannelId = _useTestChannels ? _testChannelId : _realMassChannelId;
const padreChannelId = _useTestChannels ? _testChannelId : _realPadreChannelId;

const _pollInterval = Duration(seconds: 60);

sealed class LivePriority {
  const LivePriority();
}

class LiveMass extends LivePriority {
  const LiveMass(this.videoId);
  final String videoId;
}

class LivePadre extends LivePriority {
  const LivePadre(this.videoId);
  final String videoId;
}

class NoLive extends LivePriority {
  const NoLive();
}

/// Missa (Rádio Santa Cruz) outranks Padre Geraldo Gabriel's live, which
/// outranks "nothing live". Polls every minute while the app is in the
/// foreground; pauses in the background to save battery/data.
class LivePriorityNotifier extends Notifier<LivePriority> with WidgetsBindingObserver {
  Timer? _timer;

  @override
  LivePriority build() {
    WidgetsBinding.instance.addObserver(this);
    ref.onDispose(() {
      _timer?.cancel();
      WidgetsBinding.instance.removeObserver(this);
    });
    // Deferred: a `state =` assignment that lands before `build()` returns
    // gets clobbered by this method's own return value — the `await` inside
    // `_check()` normally outlasts `build()` anyway, but hopping to the next
    // microtask first keeps this correct even if that ever stops holding.
    Future.microtask(_startPolling);
    return const NoLive();
  }

  void _startPolling() {
    _check();
    _timer?.cancel();
    _timer = Timer.periodic(_pollInterval, (_) => _check());
  }

  Future<void> _check() async {
    final [massId, padreId] = await Future.wait([
      fetchLiveVideoId(massChannelId),
      fetchLiveVideoId(padreChannelId),
    ]);
    state = switch ((massId, padreId)) {
      (final id?, _) => LiveMass(id),
      (_, final id?) => LivePadre(id),
      _ => const NoLive(),
    };
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startPolling();
    } else if (state == AppLifecycleState.paused) {
      _timer?.cancel();
    }
  }
}

final livePriorityProvider = NotifierProvider<LivePriorityNotifier, LivePriority>(
  LivePriorityNotifier.new,
);
