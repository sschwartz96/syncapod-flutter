import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:syncapod/bg_audio.dart' as bgAudio;
import 'package:syncapod/pages/now_playing.dart';
import 'package:syncapod/providers/podcast.dart';
import 'package:syncapod/providers/storage.dart';
import 'package:syncapod/util.dart';

class NowPlayingBar extends StatefulWidget {
  @override
  _NowPlayingBarState createState() => _NowPlayingBarState();
}

class _NowPlayingBarState extends State<NowPlayingBar> {
  bool audioServiceStarting = false;

  @override
  Widget build(BuildContext context) {
    bool playing = false;
    final width = MediaQuery.of(context).size.width;

    return StreamBuilder<MediaItem>(
      stream: AudioService.currentMediaItemStream,
      builder: (context, snapshot) {
        // if we have data in our audio service
        if (snapshot.hasData) {
          final item = snapshot.data;
          if (item != null) {
            playing = AudioService.playbackState.playing;
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return NowPlayingPage();
                    },
                  ),
                );
              },
              child: Container(
                width: width,
                padding: EdgeInsets.only(
                  left: 2,
                  right: 12,
                  top: 2,
                  bottom: 2,
                ),
                constraints: BoxConstraints.expand(height: 60),
                color: Colors.grey.shade900,
                child: Row(
                  children: <Widget>[
                    Image.network(
                      item.artUri,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _titleText(context, item.title),
                          // Text(
                          // item.title,
                          // style: TextStyle(fontSize: 18),
                          // ),
                          Text(item.artist),
                        ],
                      ),
                    ),
                    _playPauseButton(context),
                  ],
                ),
              ),
            );
          }
        }
        if (!audioServiceStarting) {
          _getLatestPlayed(context);
        }
        return Container();
      },
    );
  }

  void _getLatestPlayed(BuildContext context) async {
    audioServiceStarting = true;
    // get the token
    final token = await Provider.of<StorageProvider>(context, listen: false)
        .read(StorageProvider.key_access_token);

    // go get the latest podcast
    final latestPlayed =
        await Provider.of<PodcastProvider>(context, listen: false)
            .getLatestPlayed(token);

    // check if null (user has no latest played)
    if (latestPlayed == null) return;

    // convert episode to media item and add to queue
    var mediaItem =
        episodeToMediaItem(latestPlayed.episode, latestPlayed.podcast);
    mediaItem.extras['offset'] = latestPlayed.millis.toInt();

    // start the audio service if neccessary
    if (!AudioService.running) {
      bgAudio.startAudioService().then((value) {
        AudioService.customAction('setToken', token);
        print('audio service started: $value');
        audioServiceStarting = false;
        if (value ?? false) {
          AudioService.addQueueItem(mediaItem);
        }
      });
    } else {
      // AudioService.addQueueItem(mediaItem);
    }
  }

  Widget _titleText(BuildContext context, String title) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const fontSize = 18.0;
        final span = TextSpan(
          text: title,
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
        return Container(
          width: constraints.maxWidth,
          height: 30,
          child: textPainter.didExceedMaxLines
              ? Marquee(
                  text: '$title',
                  velocity: 30,
                  blankSpace: 60,
                  pauseAfterRound: Duration(seconds: 2),
                  style: TextStyle(
                    fontSize: fontSize,
                  ),
                )
              : Text(
                  title,
                  style: TextStyle(
                    fontSize: fontSize,
                  ),
                ),
        );
      },
    );
  }

  Widget _playPauseButton(BuildContext context) {
    return StreamBuilder<PlaybackState>(
      stream: AudioService.playbackStateStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return InkWell(
            onTap: () => AudioService.play(),
            child: Container(
              child: Icon(
                AudioService.playbackState.playing
                    ? Icons.pause
                    : Icons.play_arrow,
                size: 32,
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
