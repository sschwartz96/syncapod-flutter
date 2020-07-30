import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:syncapod/constants.dart';
import 'package:syncapod/pages/now_playing.dart';
import 'package:syncapod/providers/podcast.dart';
import 'package:syncapod/providers/storage.dart';
import 'package:syncapod/protos/podcast.pb.dart';

class EpisodesListPage extends StatelessWidget {
  final Podcast _podcast;

  const EpisodesListPage(
    this._podcast,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Episode>>(
      future: getEpisodes(context),
      builder: (context, snapshot) => !snapshot.hasData
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) =>
                  episode(context, snapshot.data[index]),
            ),
    );
  }

  Widget episode(BuildContext context, Episode e) => InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(NavSubEpiDetail, arguments: e);
        },
        child: Container(
          padding: EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('${e.title}'),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () async {
                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              NowPlayingPage(podcast: _podcast, episode: e)));
                },
                child: Icon(
                  Icons.play_circle_filled,
                  color: Colors.grey,
                  size: 50,
                ),
              )
            ],
          ),
        ),
      );

  Future<List<Episode>> getEpisodes(BuildContext context) async {
    final token = await Provider.of<StorageProvider>(context, listen: false)
        .read(StorageProvider.key_access_token);
    return Provider.of<PodcastProvider>(context, listen: false)
        .getEpisodes(token, _podcast.id, 0, 10);
  }
}

class EpisodeDetailPage extends StatelessWidget {
  EpisodeDetailPage({@required this.episode});
  final Episode episode;
  @override
  Widget build(BuildContext context) {
    print('epi dets: ${episode.description}');
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            // spacer
            SizedBox(
              height: 20,
            ),

            // Episode specific image
            Image.network(
              episode.image.url,
              height: 220,
              width: 320,
              alignment: Alignment.center,
              fit: BoxFit.fitHeight,
            ),

            // spacer
            SizedBox(
              height: 20,
            ),

            // Episode summary or description
            Container(
              padding: EdgeInsets.all(8),
              child: Html(
                data: episode.getDescription() ?? episode.summary,
                defaultTextStyle: TextStyle(fontSize: 16),
                onLinkTap: (url) async {
                  bool open = false;
                  await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Open url?'),
                        content: Text('$url'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                              return false;
                            },
                            child: Text('No'),
                          ),
                          FlatButton(
                            onPressed: () {
                              open = true;
                              Navigator.pop(context);
                              return true;
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                  if (open) {
                    launch(url);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
