import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../l10n/generated/app_localizations.dart';

/// One live YouTube video (Mass or Padre Geraldo Gabriel), full width, plus
/// an always-visible manual escape hatch to the camera+radio fallback page.
///
/// Uses `youtube_player_flutter` (the official IFrame Player API, wrapped)
/// instead of loading a bare `youtube.com/embed` URL in our own WebView —
/// YouTube's embed player refuses to play (error 150/152/153, "video player
/// configuration error") when it can't verify the embedder's origin, which a
/// raw `WebViewController.loadRequest` never establishes correctly; this
/// package handles that negotiation the way YouTube's own docs expect.
class LiveStreamSection extends StatefulWidget {
  const LiveStreamSection({
    required this.videoId,
    required this.title,
    required this.onShowFallback,
    super.key,
  });

  final String videoId;
  final String title;
  final VoidCallback onShowFallback;

  @override
  State<LiveStreamSection> createState() => _LiveStreamSectionState();
}

class _LiveStreamSectionState extends State<LiveStreamSection> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = _buildController(widget.videoId);
  }

  YoutubePlayerController _buildController(String videoId) =>
      YoutubePlayerController.fromVideoId(videoId: videoId, autoPlay: false);

  @override
  void didUpdateWidget(covariant LiveStreamSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoId != widget.videoId) {
      _controller.close();
      _controller = _buildController(widget.videoId);
    }
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: YoutubePlayer(controller: _controller),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: widget.onShowFallback,
          icon: const Icon(Icons.videocam_outlined),
          label: Text(l10n.liveFallbackButton),
        ),
      ],
    );
  }
}
