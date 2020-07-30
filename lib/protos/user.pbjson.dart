///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 11, '6': '.protos.ObjectID', '10': 'id'},
    const {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'username', '3': 3, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'password', '3': 4, '4': 1, '5': 9, '10': 'password'},
    const {'1': 'DOB', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'DOB'},
  ],
};

const Subscription$json = const {
  '1': 'Subscription',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 11, '6': '.protos.ObjectID', '10': 'id'},
    const {'1': 'userID', '3': 2, '4': 1, '5': 11, '6': '.protos.ObjectID', '10': 'userID'},
    const {'1': 'podcastID', '3': 3, '4': 1, '5': 11, '6': '.protos.ObjectID', '10': 'podcastID'},
    const {'1': 'completedIDs', '3': 4, '4': 3, '5': 11, '6': '.protos.ObjectID', '10': 'completedIDs'},
    const {'1': 'inProgressIDs', '3': 5, '4': 3, '5': 11, '6': '.protos.ObjectID', '10': 'inProgressIDs'},
  ],
};

const UserEpisode$json = const {
  '1': 'UserEpisode',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 11, '6': '.protos.ObjectID', '10': 'id'},
    const {'1': 'userID', '3': 2, '4': 1, '5': 11, '6': '.protos.ObjectID', '10': 'userID'},
    const {'1': 'podcastID', '3': 3, '4': 1, '5': 11, '6': '.protos.ObjectID', '10': 'podcastID'},
    const {'1': 'episodeID', '3': 4, '4': 1, '5': 11, '6': '.protos.ObjectID', '10': 'episodeID'},
    const {'1': 'offset', '3': 5, '4': 1, '5': 3, '10': 'offset'},
    const {'1': 'lastSeen', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastSeen'},
    const {'1': 'played', '3': 7, '4': 1, '5': 8, '10': 'played'},
  ],
};

const Session$json = const {
  '1': 'Session',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 11, '6': '.protos.ObjectID', '10': 'id'},
    const {'1': 'userID', '3': 2, '4': 1, '5': 11, '6': '.protos.ObjectID', '10': 'userID'},
    const {'1': 'sessionKey', '3': 3, '4': 1, '5': 9, '10': 'sessionKey'},
    const {'1': 'loginTime', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'loginTime'},
    const {'1': 'lastSeenTime', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'lastSeenTime'},
    const {'1': 'expires', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expires'},
    const {'1': 'userAgent', '3': 7, '4': 1, '5': 9, '10': 'userAgent'},
  ],
};

