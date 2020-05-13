import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:syncapod/pages/now_playing.dart';

class NowPlayingBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    bool playing = false;

    return StreamBuilder<MediaItem>(
      stream: AudioService.currentMediaItemStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final item = snapshot.data;
          if (item != null) {
            playing = AudioService.playbackState.basicState ==
                BasicPlaybackState.playing;
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
        } else {
          return Container();
        }
      },
    );
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
        print('we have ${constraints.maxWidth} max width');
        print('we have ${constraints.maxHeight} max height');

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
          final state = snapshot.data.basicState;
          return InkWell(
            onTap: () => AudioService.play(),
            child: Container(
              child: Icon(
                state == BasicPlaybackState.playing
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
