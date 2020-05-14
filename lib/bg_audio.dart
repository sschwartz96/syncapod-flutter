import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:syncapod/constants.dart';
import 'package:syncapod/providers/podcast.dart';

class BackgroundAudio extends BackgroundAudioTask {
  PodcastProvider _podcastProvider;
  String _token;

  AudioPlayer _player;
  Completer _completer;
  bool pausedFromSystem;
  final List<MediaItem> _queue = [];
  int _qIndex = -1;
  List<double> _speedInc = [1.0, 1.2, 1.5, 1.7, 2.0, 0.7];
  int _speedIndex = 0;

  @override
  Future<void> onStart() async {
    print('background on start');
    _podcastProvider = PodcastProvider();
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
          speed: _getSpeed(),
        );
      }
    });

    return _completer.future;
  }

  @override
  void onPlayMediaItem(MediaItem mediaItem) async {
    // need to first get the latest playback for user
    print('_token: $_token');
    final userEpi = _podcastProvider.getUserEpisode(
        _token, mediaItem.extras['epi_id'], mediaItem.extras['pod_id']);
    //print('our offset: ${userEpi?.offset}');

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

    // update duration if necessary
    print('media duration: ${mediaItem.duration}');
    if (mediaItem.duration == null || mediaItem.duration == 0) {
      mediaItem = mediaItem.copyWith(duration: duration.inMilliseconds);
    }

    // "add to queue"
    AudioServiceBackground.setMediaItem(mediaItem);
    _queue.add(mediaItem);
    _qIndex++;

    // play and set the offset
    userEpi.then((value) {
      print('val of userEpi: $value');
      if (value?.offset != null) {
        _seek(Duration(milliseconds: value.offset));
      }
      _player.play();
    });
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
    switch (name) {
      case 'speed':
        _nextSpeed(arguments);
        break;
      case 'setToken':
        print('setting token in audio service: $arguments');
        _token = arguments;
        break;
    }
  }

  @override
  void onAudioBecomingNoisy() {
    print('headphone jack, or bluetooth device disconnected, pausing');
    _pause();
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
    if (_player.playbackState == AudioPlaybackState.playing) {
      _player.pause();
      pausedFromSystem = true;
    }
  }

  @override
  void onAudioFocusLostTransientCanDuck() {
    _player.setVolume(33);
  }

  @override
  void onAudioFocusLost() {
    if (_player.playbackState == AudioPlaybackState.playing) {
      _player.pause();
      pausedFromSystem = true;
    }
  }

  @override
  void onAudioFocusGained() {
    if (pausedFromSystem) {
      _player.play();
      pausedFromSystem = false;
    }
    _player.setVolume(100);
  }

  @override
  void onSeekTo(int position) {
    _seek(Duration(milliseconds: position));
  }

  // ***************** helper methods for the audio service ***************** //

  Duration _getPosition() => _player.playbackEvent == null
      ? Duration.zero
      : _player.playbackEvent.position;

  Duration _getDuration() => (_queue.length > 0)
      ? Duration(milliseconds: _queue[_qIndex].duration)
      : (_player.playbackEvent?.duration != null)
          ? _player.playbackEvent.duration
          : Duration.zero;

  void _playPause() {
    var playbackState = _player.playbackState;
    if (playbackState == AudioPlaybackState.playing) {
      _pause();
    }
    if (playbackState == AudioPlaybackState.paused) {
      _player.play();
    }
  }

  /// _pause pauses the audio player and sends an update of offset to the api
  void _pause() {
    _player.pause();
    MediaItem item = _queue[_qIndex];
    print(
        'seding update offset with token: $_token, position:${_getPosition()}');
    _podcastProvider.updateUserEpisodeOffset(_token, item.extras['epi_id'],
        item.extras['pod_id'], _getPosition().inMilliseconds);
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

  /// _nextSpeed changes the speed of the audio player to the next in the list
  /// [i] should be set to -1 if the index is not specified
  void _nextSpeed(int i) {
    if (i != -1)
      _speedIndex = i;
    else
      _speedIndex++;

    // normalize to prevent index overflow
    _speedIndex = _speedIndex % (_speedInc.length);

    _player.setSpeed(_speedInc[_speedIndex]);
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

  /// _getSpeed returns double speed of the audio player
  double _getSpeed() {
    return _player != null ? _player.speed : 1.0;
  }

  void _setState(
      {@required BasicPlaybackState state, int position, double speed}) {
    if (position == null) {
      position = _player.playbackEvent.position.inMilliseconds;
    }
    AudioServiceBackground.setState(
      controls: getControls(state),
      //msystemActions: [MediaAction.seekTo],
      basicState: state,
      position: position,
      speed: speed,
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
      notificationColor: darkGrey.value,
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
