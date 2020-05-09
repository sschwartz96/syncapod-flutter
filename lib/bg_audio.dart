import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class BackgroundAudio extends BackgroundAudioTask {
  AudioPlayer _player;
  Completer _completer;
  final List<MediaItem> _queue = [];
  int _qIndex = -1;

  @override
  Future<void> onStart() async {
    print('background on start');
    _player = AudioPlayer();
    _completer = Completer();

    var playerStateSubscription = _player.playbackStateStream
        .where((state) => state == AudioPlaybackState.completed)
        .listen((state) {
      _handlePlaybackCompleted();
    });
    var eventSubscription = _player.playbackEventStream.listen((event) {
      final state = _eventToBasicState(event);
      if (state != BasicPlaybackState.stopped) {
        _setState(
          state: state,
          position: _getPosition().inMilliseconds,
        );
      }
    });

    return _completer.future;
  }

  @override
  void onPlayMediaItem(MediaItem mediaItem) async {
    Duration duration;
    // set the url, buffer, and play
    if (_isURL(mediaItem.id)) {
      print('playing from url: ${mediaItem.id}');
      duration = await _player.setUrl(mediaItem.id).then((value) {
        print('finisehed setting url');
      });
    } else {
      print('playing from file path: ${mediaItem.id}');
      duration = await _player.setFilePath(mediaItem.id);
    }

    // update duration
    print('media duration: ${mediaItem.duration}');
    if (mediaItem.duration == null || mediaItem.duration == 0) {
      mediaItem = mediaItem.copyWith(duration: duration.inMilliseconds);
    }

    // "add to queue"
    AudioServiceBackground.setMediaItem(mediaItem);
    _queue.add(mediaItem);
    _qIndex++;

    _player.play();
  }

  @override
  void onAddQueueItem(MediaItem mediaItem) {
    _queue.add(mediaItem);
  }

  @override
  void onPlay() {
    print('background play');
    //_player.play();
    _playPause();
  }

  @override
  void onPause() {
    print('background pause');
    // _player.pause();
    _playPause();
  }

  @override
  void onClick(MediaButton button) {
    print('onclick media button called');
    _playPause();
  }

  @override
  Future onCustomAction(String name, arguments) {
    print('custom action called: $name');
  }

  @override
  void onAudioBecomingNoisy() {
    print('headphone jack, or bluetooth device disconnected, pausing');
    _player.pause();
  }

  @override
  void onStop() {
    print('background stop');
    _player.stop();
    _queue.clear();
    _completer.complete();
  }

  /// onSkipNext is implemented like fast forward for media buttons
  @override
  void onSkipToNext() {
    _seek(_getPosition() + Duration(seconds: 30));
  }

  /// onSkipNext is implemented like rewind for media buttons
  @override
  void onSkipToPrevious() {
    _seek(_getPosition() - Duration(seconds: 10));
  }

  /// using this for skip next
  @override
  void onFastForward() {}

  /// using this for skip previous
  @override
  void onRewind() {}

  @override
  void onAudioFocusLostTransient() {
    print('onAudioFocusLostTransient()');
    _player.pause();
  }

  @override
  void onAudioFocusLostTransientCanDuck() {
    _player.setVolume(33);
  }

  @override
  void onAudioFocusLost() {
    _player.pause();
  }

  @override
  void onAudioFocusGained() {
    _player.setVolume(100);
    _player.play();
  }

  @override
  void onSeekTo(int position) {
    _seek(Duration(milliseconds: position));
  }

  // ***************** helper methods for the audio service ***************** //

  Duration _getPosition() => _player.playbackEvent == null
      ? Duration.zero
      : _player.playbackEvent.position;

  Duration _getDuration() => _player.playbackEvent == null
      ? Duration.zero
      : _player.playbackEvent.duration;

  void _playPause() {
    var playbackState = _player.playbackState;
    if (playbackState == AudioPlaybackState.playing) {
      _player.pause();
    }
    if (playbackState == AudioPlaybackState.paused) {
      _player.play();
    }
  }

  /// _seek seeks to the specified duration
  /// checks for proper player state
  /// may modify value to fit within the duration of audio
  void _seek(Duration d) {
    // check for proper seeking state
    final state = _player.playbackState;
    if (state != AudioPlaybackState.connecting &&
        state != AudioPlaybackState.none) {
      // prevent seeking negative
      if (d.isNegative) d = Duration.zero;

      // prevent seeking past total duration
      final ttlDur = _getDuration();
      if (d > ttlDur) d = (ttlDur - Duration(seconds: 5));

      _player.seek(d);
    }
  }

  /// _isURL is a simple url validator
  /// only checks for http(https) protocol is valid
  bool _isURL(String s) => s.contains("http") && s.contains('://');

  void _handlePlaybackCompleted() {
    if (_qIndex == (_queue.length - 1)) {
      onSkipToNext();
    } else {
      onStop();
    }
  }

  void _setState({@required BasicPlaybackState state, int position}) {
    if (position == null) {
      position = _player.playbackEvent.position.inMilliseconds;
    }
    AudioServiceBackground.setState(
      controls: getControls(state),
      //msystemActions: [MediaAction.seekTo],
      basicState: state,
      position: position,
    );
  }

  List<MediaControl> getControls(BasicPlaybackState state) {
    if (_player.playbackState == AudioPlaybackState.playing) {
      return [rewindControl, pauseControl, forwardControl];
    } else {
      return [rewindControl, playControl, forwardControl];
    }
  }

  BasicPlaybackState _eventToBasicState(AudioPlaybackEvent event) {
    if (event.buffering) {
      return BasicPlaybackState.buffering;
    } else {
      switch (event.state) {
        case AudioPlaybackState.none:
          return BasicPlaybackState.none;
        case AudioPlaybackState.stopped:
          return BasicPlaybackState.stopped;
        case AudioPlaybackState.paused:
          return BasicPlaybackState.paused;
        case AudioPlaybackState.playing:
          return BasicPlaybackState.playing;
        case AudioPlaybackState.connecting:
          return BasicPlaybackState.connecting;
        case AudioPlaybackState.completed:
          return BasicPlaybackState.stopped;
        default:
          throw Exception("Illegal state");
      }
    }
  }
} // BackgroundAudioTask

MediaControl playControl = MediaControl(
  androidIcon: 'drawable/baseline_play_arrow_white_36',
  label: 'Play',
  action: MediaAction.play,
);
MediaControl pauseControl = MediaControl(
  androidIcon: 'drawable/baseline_pause_white_36',
  label: 'Pause',
  action: MediaAction.pause,
);
MediaControl rewindControl = MediaControl(
  androidIcon: 'drawable/baseline_replay_10_white_36',
  label: 'Previous',
  action: MediaAction.skipToPrevious,
);
MediaControl forwardControl = MediaControl(
  androidIcon: 'drawable/baseline_forward_30_white_36',
  label: 'Next',
  action: MediaAction.skipToNext,
);

void backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => BackgroundAudio());
}

Future<bool> startAudioService() {
  if (!AudioService.running)
    return AudioService.start(
      backgroundTaskEntrypoint: backgroundTaskEntrypoint,
      androidNotificationChannelName: 'syncapod audio',
      androidArtDownscaleSize: Size(200, 200),
      notificationColor: 0xFF2196f3,
      enableQueue: true,
      androidStopForegroundOnPause: true,
    ).catchError((error) {
      print(error);
    }).whenComplete(
      () => () {
        print('completed on start');
      },
    );
  else
    return Future.value(false);
}
