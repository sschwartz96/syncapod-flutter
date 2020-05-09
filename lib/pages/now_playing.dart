import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:palette_generator/palette_generator.dart';

import 'package:syncapod/bg_audio.dart';
import 'package:syncapod/constants.dart';
import 'package:syncapod/models/podcast.dart';
import 'package:syncapod/widgets/playback_button.dart';
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
  IconData playPauseIcon = Icons.pause_circle_filled;
  Status _currentStatus = Status.ToBePlayed;
  Image _curImage;
  Color _curBackground = Colors.grey.shade900;
  Color _curVibrant = Colors.deepPurple;
  Color _curMuted = Colors.grey;

  _NowPlayingPageState(this._podcast, this._episode);

  @override
  Widget build(BuildContext context) {
    bool startingService = false;
    // make sure audio service is already started
    if (!AudioService.running) startingService = true;
    startAudioService().then((value) {
      if (value) AudioService.playMediaItem(_episode.toMediaItem());
      startingService = false;
    });

    // start the background audio service
    // Initiate playback start if we are in such state
    if (!startingService &&
        AudioService.running &&
        _currentStatus == Status.ToBePlayed) {
      AudioService.playMediaItem(_episode.toMediaItem());
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
                child: _pageContents(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _pageContents() {
    return StreamBuilder<PlaybackState>(
      stream: AudioService.playbackStateStream,
      builder: (context, snapshot) {
        final fullState = snapshot.data;
        final state = fullState?.basicState;
        final duration = AudioService.currentMediaItem != null
            ? Duration(milliseconds: AudioService.currentMediaItem.duration)
            : Duration.zero;
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
            StreamBuilder<Object>(
                stream: Stream.periodic(Duration(seconds: 1)),
                builder: (context, snapshot) {
                  final position = AudioService.playbackState != null
                      ? Duration(
                          milliseconds:
                              AudioService.playbackState.currentPosition,
                        )
                      : Duration.zero;

                  return SeekBar(
                    color: _curVibrant,
                    inactiveColor: _curMuted,
                    duration: duration,
                    position: position,
                    onChangeEnd: (d) => AudioService.seekTo(d.inMilliseconds),
                  );
                }),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                PlaybackButton(
                  icon: Icons.replay_10,
                  onPressed: () {
                    AudioService.skipToPrevious();
                  },
                  size: 40,
                  tooltip: 'Rewind 10 Seconds',
                ),
                PlaybackButton(
                  icon: Icons.skip_previous,
                  onPressed: () {
                    AudioService.rewind();
                  },
                  tooltip: 'Previous',
                  size: 60,
                ),
                PlaybackButton(
                  icon: playPauseIcon,
                  onPressed: () {
                    if (AudioService.playbackState.basicState ==
                        BasicPlaybackState.playing) {
                      playPauseIcon = Icons.play_arrow;
                    } else {
                      playPauseIcon = Icons.pause;
                    }
                    // although we say play, its implemented as play/pause
                    AudioService.play();
                  },
                  size: 80,
                  tooltip: 'Play/Pause',
                ),
                PlaybackButton(
                  icon: Icons.skip_next,
                  onPressed: () {
                    AudioService.fastForward();
                  },
                  size: 60,
                  tooltip: 'Next',
                ),
                PlaybackButton(
                  icon: Icons.forward_30,
                  onPressed: () {
                    AudioService.skipToNext();
                  },
                  size: 40,
                  tooltip: 'Fast-Forward 30 Seconds',
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
