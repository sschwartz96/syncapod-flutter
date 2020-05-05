import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import 'package:syncapod/models/podcast.dart';
import 'package:syncapod/providers/audio.dart';
import 'package:syncapod/widgets/seek_bar.dart';

class NowPlayingPage extends StatefulWidget {
  final Podcast podcast;
  final Episode episode;
  const NowPlayingPage(
      {Key key, @required this.podcast, @required this.episode})
      : super(key: key);

  @override
  _NowPlayingPageState createState() => _NowPlayingPageState(podcast, episode);
}

enum Status { ToBePlayed, Playing, Paused }

class _NowPlayingPageState extends State<NowPlayingPage> {
  Podcast _podcast;
  Episode _episode;
  Icon playPauseIcon = Icon(Icons.pause_circle_filled);
  Status _currentStatus = Status.ToBePlayed;

  _NowPlayingPageState(this._podcast, this._episode);

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<AudioProvider>(context);
    if (_currentStatus == Status.ToBePlayed) {
      player.playEpisode(_episode);
      _currentStatus = Status.Playing;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing'),
        backgroundColor: Colors.grey.shade900,
      ),
      backgroundColor: Colors.grey.shade800,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.network(
              _episode.image.url,
              alignment: Alignment.center,
              fit: BoxFit.cover,
              height: 320,
              width: 320,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<FullAudioPlaybackState>(
              stream: player.getFullPlaybackStream(),
              builder: (context, snapshot) {
                final fullState = snapshot.data;
                final state = fullState?.state;
                final buffering = fullState?.buffering;

                Widget barOrLoad;
                if (state == AudioPlaybackState.connecting || buffering) {
                  barOrLoad = CircularProgressIndicator();
                } else {
                  barOrLoad = StreamBuilder<Duration>(
                    stream: player.getPositionStream(),
                    builder: (context, posSnap) {
                      final position = posSnap.data ?? Duration.zero;
                      return FutureBuilder<Duration>(
                          future: player.getDuration(),
                          builder: (context, durSnap) {
                            final duration = durSnap.data ?? Duration.zero;
                            return SeekBar(
                              duration: duration,
                              position: position,
                              onChangeEnd: player.seek,
                            );
                          });
                    },
                  );
                }
                return barOrLoad;
              }),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.replay_10),
                onPressed: () {},
                color: Colors.white,
                highlightColor: Colors.transparent,
                iconSize: 40,
                tooltip: 'Rewind 10 Seconds',
              ),
              IconButton(
                icon: Icon(Icons.skip_previous),
                onPressed: () {},
                color: Colors.white,
                highlightColor: Colors.transparent,
                iconSize: 60,
                tooltip: 'Previous',
              ),
              IconButton(
                icon: playPauseIcon,
                onPressed: () {
                  _onPlayPause(player);
                },
                color: Colors.white,
                highlightColor: Colors.transparent,
                iconSize: 60,
                tooltip: 'Play/Pause',
              ),
              IconButton(
                icon: Icon(Icons.skip_next),
                onPressed: () {},
                color: Colors.white,
                highlightColor: Colors.transparent,
                iconSize: 60,
                tooltip: 'Next',
              ),
              IconButton(
                icon: Icon(Icons.forward_30),
                onPressed: () {},
                color: Colors.white,
                highlightColor: Colors.transparent,
                iconSize: 40,
                tooltip: 'Fast-Forward 30 Seconds',
              ),
            ],
          )
        ],
      ),
    );
  }

  void _onPlayPause(AudioProvider player) {
    setState(() {
      if (player.isPlaying()) {
        print('pausing');
        player.pause();
        playPauseIcon = Icon(Icons.play_circle_filled);
        _currentStatus = Status.Paused;
      } else {
        print('resuming');
        player.resume();
        playPauseIcon = Icon(Icons.pause_circle_filled);
        _currentStatus = Status.Playing;
      }
    });
  }
}
