import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import 'package:syncapod/bg_audio.dart';
import 'package:syncapod/constants.dart';
import 'package:syncapod/models/podcast.dart';
import 'package:syncapod/providers/storage.dart';
import 'package:syncapod/widgets/playback_button.dart';
import 'package:syncapod/widgets/seek_bar.dart';

class NowPlayingPage extends StatefulWidget {
  final Podcast podcast;
  final Episode episode;
  const NowPlayingPage({Key key, this.podcast, this.episode}) : super(key: key);

  @override
  _NowPlayingPageState createState() => _NowPlayingPageState(podcast, episode);
}

enum Status { StartingAudio, ToBePlayed, Playing, Paused }

class _NowPlayingPageState extends State<NowPlayingPage> {
  Podcast _podcast;
  Episode _episode;
  IconData playPauseIcon = null;
  Status _currentStatus = Status.ToBePlayed;
  String title, _imgUrl;
  Image _curImage;
  Color _curBackground = Colors.grey.shade900;
  Color _curVibrant = Colors.deepPurple;
  Color _curMuted = Colors.grey;
  bool gettingPalette = false;

  _NowPlayingPageState(this._podcast, this._episode);

  @override
  Widget build(BuildContext context) {
    // make sure audio service is already started
    if (!AudioService.running) {
      _currentStatus = Status.StartingAudio;
      startAudioService().then((value) {
        if (value) {
          // set the user token within the audio service and then play
          _setToken(context).then((value) => _playEpisode(context));
        }
      });
    } else {
      // are we already playing?
      if ((AudioService.playbackState.basicState ==
                  BasicPlaybackState.playing ||
              AudioService.playbackState.basicState ==
                  BasicPlaybackState.paused) &&
          _episode == null) {
        _currentStatus = Status.Playing;
        _episode = Episode.fromMediaItem(AudioService.currentMediaItem);
      } else
      // Initiate playback start if we are in such state
      if (_currentStatus == Status.ToBePlayed) {
        // only reason to be here is because coming from latestPlayed
        if (AudioService.currentMediaItem != null && _episode == null) {
          _currentStatus = Status.Playing;
          _episode = Episode.fromMediaItem(AudioService.currentMediaItem);
        } else {
          _playEpisode(context);
        }
      }
    }

    // Load the image
    // if (_curImage == null) {
    // _curImage = Image.network(
    // _episode.image.url,
    // alignment: Alignment.center,
    // fit: BoxFit.cover,
    // height: 310,
    // width: 360,
    // loadingBuilder: (context, child, progress) {
    // if (progress == null) return child;
//
    // return Container();
    // },
    // );
    // }

    return Scaffold(
      appBar: AppBar(
        title: _title(),
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
  }

  Widget _title() {
    return LayoutBuilder(
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

        _updatePlayIcon(false);

        final width = MediaQuery.of(context).size.width;
        // main column of the page
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: _curImage = Image.network(
                _episode.image.url,
                alignment: Alignment.center,
                fit: BoxFit.cover,
                width: min(width * .88, 400),
                height: min(width * .70, 400),
                loadingBuilder: (context, child, progress) {
                  if (progress == null) {
                    if (!gettingPalette && _curMuted == Colors.grey) {
                      gettingPalette = true;
                      _getColorPalette();
                    }
                    return child;
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            StreamBuilder<Object>(
                stream: Stream.periodic(Duration(milliseconds: 500)),
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
                    _updatePlayIcon(true);
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
            ),

            SizedBox(
              height: 10,
            ),
            // playback speed
            FlatButton(
              child: Builder(builder: (context) {
                final speed = fullState != null
                    ? fullState.speed.toStringAsFixed(1)
                    : 1.0;
                return Text(
                  '${speed}x',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                );
              }),
              onPressed: () {
                print('press playback speed');
                AudioService.customAction('speed', -1);
              },
            ),
          ],
        );
      },
    );
  }

  void _getColorPalette() async {
    print('getting palette');
    Future.delayed(Duration(milliseconds: 250)).then((value) => {
          PaletteGenerator.fromImageProvider(
            _curImage.image,
          ).then((c) {
            // generate custom colors
            setState(() {
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
            });
          }),
        });
  }

  /// _updatePlayIcon gets the AudioService state and changes the icon
  /// [playButtonPressed] is if this is called from the onPress function
  void _updatePlayIcon(bool playButtonPressed) {
    final state = AudioService.playbackState.basicState;
    if (state == BasicPlaybackState.connecting ||
        state == BasicPlaybackState.buffering) {
      playPauseIcon = null;
      return;
    }
    if (state == BasicPlaybackState.playing) {
      if (playButtonPressed)
        playPauseIcon = Icons.play_arrow;
      else
        playPauseIcon = Icons.pause;
    } else {
      if (playButtonPressed)
        playPauseIcon = Icons.pause;
      else
        playPauseIcon = Icons.play_arrow;
    }
  }

  void _playEpisode(BuildContext context) {
    // transform episode to [MediaItem]
    final mediaItem = _episode.toMediaItem(_podcast);

    // play the media item with the audio service
    AudioService.playMediaItem(mediaItem);

    // change our status
    _currentStatus = Status.Playing;
  }

  Future<void> _setToken(BuildContext context) async {
    // get the token from our storage provider
    final token = await Provider.of<StorageProvider>(context, listen: false)
        .read(StorageProvider.key_access_token);

    // set it within the audio service
    AudioService.customAction('setToken', token);
  }
}
