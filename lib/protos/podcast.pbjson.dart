///
//  Generated code. Do not modify.
//  source: podcast.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const Image$json = const {
  '1': 'Image',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'url', '3': 2, '4': 1, '5': 9, '10': 'url'},
  ],
};

const Category$json = const {
  '1': 'Category',
  '2': const [
    const {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    const {'1': 'category', '3': 2, '4': 3, '5': 11, '6': '.protos.Category', '10': 'category'},
  ],
};

const Podcast$json = const {
  '1': 'Podcast',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 11, '6': '.protos.ObjectID', '10': 'id'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'author', '3': 3, '4': 1, '5': 9, '10': 'author'},
    const {'1': 'type', '3': 4, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'subtitle', '3': 5, '4': 1, '5': 9, '10': 'subtitle'},
    const {'1': 'link', '3': 6, '4': 1, '5': 9, '10': 'link'},
    const {'1': 'image', '3': 7, '4': 1, '5': 11, '6': '.protos.Image', '10': 'image'},
    const {'1': 'explicit', '3': 8, '4': 1, '5': 9, '10': 'explicit'},
    const {'1': 'language', '3': 9, '4': 1, '5': 9, '10': 'language'},
    const {'1': 'Keywords', '3': 10, '4': 3, '5': 9, '10': 'Keywords'},
    const {'1': 'category', '3': 11, '4': 3, '5': 11, '6': '.protos.Category', '10': 'category'},
    const {'1': 'pubDate', '3': 12, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'pubDate'},
    const {'1': 'lastBuildDate', '3': 13, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastBuildDate'},
    const {'1': 'rss', '3': 14, '4': 1, '5': 9, '10': 'rss'},
  ],
};

const Episode$json = const {
  '1': 'Episode',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 11, '6': '.protos.ObjectID', '10': 'id'},
    const {'1': 'podcastID', '3': 2, '4': 1, '5': 11, '6': '.protos.ObjectID', '10': 'podcastID'},
    const {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'author', '3': 4, '4': 1, '5': 9, '10': 'author'},
    const {'1': 'type', '3': 5, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'image', '3': 6, '4': 1, '5': 11, '6': '.protos.Image', '10': 'image'},
    const {'1': 'pubDate', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'pubDate'},
    const {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'summary', '3': 9, '4': 1, '5': 9, '10': 'summary'},
    const {'1': 'season', '3': 10, '4': 1, '5': 5, '10': 'season'},
    const {'1': 'episode', '3': 11, '4': 1, '5': 5, '10': 'episode'},
    const {'1': 'category', '3': 12, '4': 3, '5': 11, '6': '.protos.Category', '10': 'category'},
    const {'1': 'explicit', '3': 13, '4': 1, '5': 9, '10': 'explicit'},
    const {'1': 'MP3URL', '3': 14, '4': 1, '5': 9, '10': 'MP3URL'},
    const {'1': 'durationMillis', '3': 15, '4': 1, '5': 3, '10': 'durationMillis'},
    const {'1': 'subtitle', '3': 16, '4': 1, '5': 9, '10': 'subtitle'},
  ],
};

const Request$json = const {
  '1': 'Request',
  '2': const [
    const {'1': 'podcastID', '3': 2, '4': 1, '5': 11, '6': '.protos.ObjectID', '10': 'podcastID'},
    const {'1': 'episodeID', '3': 3, '4': 1, '5': 11, '6': '.protos.ObjectID', '10': 'episodeID'},
    const {'1': 'start', '3': 4, '4': 1, '5': 3, '10': 'start'},
    const {'1': 'end', '3': 5, '4': 1, '5': 3, '10': 'end'},
  ],
};

const UserEpisodeReq$json = const {
  '1': 'UserEpisodeReq',
  '2': const [
    const {'1': 'podcastID', '3': 2, '4': 1, '5': 11, '6': '.protos.ObjectID', '10': 'podcastID'},
    const {'1': 'episodeID', '3': 3, '4': 1, '5': 11, '6': '.protos.ObjectID', '10': 'episodeID'},
    const {'1': 'offset', '3': 4, '4': 1, '5': 3, '10': 'offset'},
    const {'1': 'lastSeen', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastSeen'},
    const {'1': 'played', '3': 6, '4': 1, '5': 8, '10': 'played'},
  ],
};

const Response$json = const {
  '1': 'Response',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

const LastPlayedRes$json = const {
  '1': 'LastPlayedRes',
  '2': const [
    const {'1': 'podcast', '3': 1, '4': 1, '5': 11, '6': '.protos.Podcast', '10': 'podcast'},
    const {'1': 'episode', '3': 2, '4': 1, '5': 11, '6': '.protos.Episode', '10': 'episode'},
    const {'1': 'millis', '3': 3, '4': 1, '5': 3, '10': 'millis'},
  ],
};

const Subscriptions$json = const {
  '1': 'Subscriptions',
  '2': const [
    const {'1': 'subscriptions', '3': 1, '4': 3, '5': 11, '6': '.protos.Subscription', '10': 'subscriptions'},
  ],
};

const Episodes$json = const {
  '1': 'Episodes',
  '2': const [
    const {'1': 'episodes', '3': 1, '4': 3, '5': 11, '6': '.protos.Episode', '10': 'episodes'},
  ],
};

