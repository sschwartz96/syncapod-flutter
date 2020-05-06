import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:syncapod/constants.dart';

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
  Duration _curPos = null;
  Duration _curDur = null;
  Image _curImage;
  Color _curBackground = Colors.grey.shade900;
  Color _curVibrant = Colors.deepPurple;
  Color _curMuted = Colors.grey;

  _NowPlayingPageState(this._podcast, this._episode);

  @override
  Widget build(BuildContext context) {
    // Grab the audio player from the [AudioProvider]
    final player = Provider.of<AudioProvider>(context);

    // Initiate playback start if we are in such state
    if (_currentStatus == Status.ToBePlayed) {
      player.playEpisode(_episode);
    }

    // Load the image
    if (_curImage == null) {
      _curImage = Image.network(
        _episode.image.url,
        alignment: Alignment.center,
        fit: BoxFit.cover,
        height: 310,
        width: 360,
      );
    }

    return FutureBuilder<PaletteGenerator>(
        future: PaletteGenerator.fromImageProvider(_curImage.image),
        builder: (context, genColorSnap) {
          // generate custom colors
          if (genColorSnap.hasData) {
            final c = genColorSnap.data;

            _curBackground = (c.darkVibrantColor != null
                ? c.darkVibrantColor.color
                : _curBackground);
            _curVibrant = (c.vibrantColor != null
                ? c.vibrantColor.color
                : (c.lightVibrantColor != null
                    ? c.lightVibrantColor.color
                    : _curVibrant));
            _curMuted = (c.mutedColor != null
                ? c.mutedColor.color
                : (c.lightMutedColor != null
                    ? c.lightMutedColor.color
                    : _curMuted));
          }

          return Scaffold(
            appBar: AppBar(
              title: LayoutBuilder(
                builder: (context, constraints) {
                  const fontSize = 18.0;
                  final span = TextSpan(
                    text: _episode.title,
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  );

                  // textpainter to see if we overflow
                  final textPainter = TextPainter(
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.ltr,
                    text: span,
                  );

                  // "render" to virtual space
                  textPainter.layout(maxWidth: constraints.maxWidth);

                  // check if we overflowed
                  return textPainter.didExceedMaxLines
                      ? SizedBox(
                          height: 40,
                          width: constraints.maxWidth,
                          child: Marquee(
                            text: '${_episode.title} ',
                            velocity: 30,
                            blankSpace: 60,
                            pauseAfterRound: Duration(seconds: 2),
                            style: TextStyle(
                              fontSize: fontSize,
                            ),
                          ),
                        )
                      : Text(
                          _episode.title,
                          style: TextStyle(
                            fontSize: fontSize,
                          ),
                        );
                },
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            backgroundColor: _curBackground,
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [_curBackground, Colors.grey.shade900, darkGrey],
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: _pageContents(player),
                ),
              ),
            ),
          );
        });
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

  // Widget _pageTitleText(BuildContext context, String title) {
  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       const fontSize = 24.0;
  //       final span = TextSpan(
  //         text: title,
  //         style: TextStyle(
  //           fontSize: fontSize,
  //         ),
  //       );

  //       // textpainter to see if we overflow
  //       final textPainter = TextPainter(
  //         maxLines: 1,
  //         textAlign: TextAlign.left,
  //         textDirection: TextDirection.ltr,
  //         text: span,
  //       );

  //       // "render" to virtual space
  //       print('our maxwidth: ${constraints.maxWidth}');
  //       textPainter.layout(maxWidth: constraints.maxWidth);

  //       // check if we overflowed
  //       return textPainter.didExceedMaxLines
  //           ? Marquee(
  //               text: title,
  //               style: TextStyle(
  //                 fontSize: fontSize,
  //               ),
  //             )
  //           : Text(
  //               title,
  //               style: TextStyle(
  //                 fontSize: fontSize,
  //               ),
  //             );
  //     },
  //   );
  // }

  Widget _pageContents(AudioProvider player) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: _curImage,
        ),
        SizedBox(
          height: 80,
        ),
        StreamBuilder<FullAudioPlaybackState>(
            stream: player.getFullPlaybackStream(),
            builder: (context, snapshot) {
              final fullState = snapshot.data;
              final state = fullState?.state;
              final buffering = fullState?.buffering;

              return StreamBuilder<Duration>(
                stream: player.getPositionStream(),
                builder: (context, posSnap) {
                  final position = posSnap.data ?? Duration.zero;
                  _curPos = position;

                  return FutureBuilder<Duration>(
                      future: player.getDuration(),
                      builder: (context, durSnap) {
                        final duration = durSnap.data ?? Duration.zero;
                        _curDur = duration;
                        return SeekBar(
                          color: _curVibrant,
                          inactiveColor: _curMuted,
                          duration: duration,
                          position: position,
                          onChangeEnd: player.seek,
                        );
                      });
                },
              );
            }),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.replay_10),
              onPressed: () {
                if (_curPos != null)
                  player.subtract(_curPos, Duration(seconds: 10));
              },
              color: Colors.white,
              highlightColor: Colors.transparent,
              iconSize: 40,
              tooltip: 'Rewind 10 Seconds',
            ),
            IconButton(
              icon: Icon(Icons.skip_previous),
              onPressed: () {
                if (_curPos != null) player.previous(_curPos);
              },
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
              iconSize: 80,
              tooltip: 'Play/Pause',
            ),
            IconButton(
              icon: Icon(Icons.skip_next),
              onPressed: () {
                player.next();
              },
              color: Colors.white,
              highlightColor: Colors.transparent,
              iconSize: 60,
              tooltip: 'Next',
            ),
            IconButton(
              icon: Icon(Icons.forward_30),
              onPressed: () {
                if (_curPos != null)
                  player.add(_curDur, _curPos, Duration(seconds: 30));
              },
              color: Colors.white,
              highlightColor: Colors.transparent,
              iconSize: 40,
              tooltip: 'Fast-Forward 30 Seconds',
            ),
          ],
        )
      ],
    );
  }
}
