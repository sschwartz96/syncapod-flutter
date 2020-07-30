import 'package:grpc/grpc.dart';
import 'protos/auth.pbgrpc.dart';
import 'protos/podcast.pbgrpc.dart';

import 'constants.dart';

final channel = ClientChannel(grpcServerName,
    port: grpcServerPort,
    options: const ChannelOptions(credentials: ChannelCredentials.secure(password: token)));

final authClient = AuthClient(
  channel,
  options: CallOptions(timeout: Duration(seconds: 30)),
);

final podClient = PodcastServiceClient(
  channel,
  options: CallOptions(timeout: Duration(seconds: 30));
);