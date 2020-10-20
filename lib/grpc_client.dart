import 'package:grpc/grpc.dart';
import 'protos/auth.pbgrpc.dart';
import 'protos/podcast.pbgrpc.dart';

import 'constants.dart';

final channel = ClientChannel(
  grpcServerName,
  port: grpcServerPort,
  options: const ChannelOptions(
    credentials: ChannelCredentials.secure(),
  ),
);

AuthClient createAuthClient() => AuthClient(
      channel,
      options: CallOptions(timeout: Duration(seconds: 10)),
    );

PodClient createPodClient(String token) {
  final metadata = Map<String, String>();
  metadata.putIfAbsent("token", () => token);
  return PodClient(
    channel,
    options: CallOptions(
      timeout: Duration(seconds: 10),
      metadata: metadata,
    ),
  );
}
