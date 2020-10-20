import 'package:audio_service/audio_service.dart';
import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:syncapod/protos/podcast.pb.dart';

MediaItem episodeToMediaItem(Episode e, Podcast p) => MediaItem(
      title: e.title,
      id: e.mP3URL,
      artUri: e.image.url,
      artist: e.author ?? p.title,
      displayDescription: e.description,
      displaySubtitle: e.subtitle,
      displayTitle: e.title,
      duration: Duration(milliseconds: e.durationMillis.toInt()),
      playable: true,
      album: e.title,
      extras: {"epi_id": e.id, "pod_id": p.id},
    );

Episode episodeFromMediaItem(MediaItem item) => Episode()
  ..id = item.extras['epi_id']
  ..podcastID = item.extras['pod_id']
  ..title = item.title
  ..mP3URL = item.id
  ..image = (Image()..url = item.artUri)
  ..author = item.artist
  ..durationMillis = $fixnum.Int64(item.duration.inMilliseconds)
  ..subtitle = item.displaySubtitle
  ..description = item.displayDescription;
