import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncapod/constants.dart';
import 'package:syncapod/models/podcast.dart';
import 'package:syncapod/pages/episodes.dart';
import 'package:syncapod/providers/user.dart';
import 'package:syncapod/widgets/podcast.dart';

class SubscriptionsTab extends StatelessWidget {
  SubscriptionsTab({this.navKey});

  final GlobalKey<NavigatorState> navKey;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final canPop = navKey.currentState.canPop();
        if (canPop) navKey.currentState.pop();
        return !canPop;
      },
      child: Navigator(
        key: navKey,
        initialRoute: NavSubPod,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case NavSubPod:
              return MaterialPageRoute(
                builder: (context) => _page(context),
                settings: settings,
                maintainState: true,
              );
            case NavSubEpi:
              final Podcast p = settings.arguments;
              return MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text('${p.title}'),
                  ),
                  body: EpisodesListPage(settings.arguments),
                ),
                settings: settings,
              );
            case NavSubEpiDetail:
              final Episode e = settings.arguments;
              return MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text('${e.title}'),
                  ),
                  body: EpisodeDetailPage(
                    episode: e,
                  ),
                ),
                settings: settings,
              );
            default:
              return MaterialPageRoute(
                builder: (context) => _page(context),
                settings: settings,
                maintainState: true,
              );
          }
        },
      ),
    );
  }

  Widget _page(BuildContext context) {
    // get the list of subs, loaded when the user was authorized
    List<Podcast> subs =
        Provider.of<UserProvider>(context, listen: false).getUserSubs();
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscriptions'),
      ),
      body: Builder(
        builder: (context) {
          return subs == null || subs.length == 0
              ? Text(
                  'No Subscriptions',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                )
              : ListView.builder(
                  itemCount: subs.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      return Navigator.of(context)
                          .pushNamed(NavSubEpi, arguments: subs[index]);
                    },
                    child: PodcastTile(
                      subs[index],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
