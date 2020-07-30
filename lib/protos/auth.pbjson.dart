///
//  Generated code. Do not modify.
//  source: auth.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const AuthReq$json = const {
  '1': 'AuthReq',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
    const {'1': 'sessionKey', '3': 3, '4': 1, '5': 9, '10': 'sessionKey'},
    const {'1': 'userAgent', '3': 4, '4': 1, '5': 9, '10': 'userAgent'},
    const {'1': 'stayLoggedIn', '3': 5, '4': 1, '5': 8, '10': 'stayLoggedIn'},
  ],
};

const AuthRes$json = const {
  '1': 'AuthRes',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'sessionKey', '3': 2, '4': 1, '5': 9, '10': 'sessionKey'},
    const {'1': 'user', '3': 15, '4': 1, '5': 11, '6': '.protos.User', '10': 'user'},
  ],
};

