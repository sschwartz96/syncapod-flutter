import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncapod/models/podcast.dart';
import 'package:syncapod/pages/now_playing.dart';
import 'package:syncapod/providers/podcast.dart';
import 'package:syncapod/providers/storage.dart';

class EpisodesPage extends StatelessWidget {
  final Podcast _podcast;

  const EpisodesPage(
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
          // TODO: add episode details page
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
