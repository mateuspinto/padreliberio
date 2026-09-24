import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

const _userAgent =
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) '
    'Chrome/120.0.0.0 Safari/537.36';

final _liveVideoDetails = RegExp(
  r'"videoDetails":\{"videoId":"([a-zA-Z0-9_-]+)"[^}]*"isLive":true',
);

/// Whether [channelId] is broadcasting live right now, and if so the video
/// id to embed — or `null` if not live, on any error, or on web.
///
/// Web has no way to do this: YouTube's `/live` page sends no CORS headers,
/// so a browser blocks reading the response. There's no redirect to key off
/// either — YouTube always answers 200, live or not; live-ness is only
/// readable from the embedded `ytInitialPlayerResponse.videoDetails` block
/// in the page body (present + `isLive:true` only when actually live).
Future<String?> fetchLiveVideoId(String channelId) async {
  if (kIsWeb) return null;
  try {
    final response = await http
        .get(
          Uri.parse('https://www.youtube.com/channel/$channelId/live'),
          headers: {'User-Agent': _userAgent},
        )
        .timeout(const Duration(seconds: 6));
    if (response.statusCode != 200) return null;
    return _liveVideoDetails.firstMatch(response.body)?.group(1);
  } catch (_) {
    return null;
  }
}
