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
  final List<MediaItem> _queue = [];
  int _qIndex = -1;
  int _speedIndex = 0;
  List<double> _speedInc = [1.0, 1.2, 1.5, 1.7, 2.0, 0.7];

  // _interrupted keeps track if we lost focus
  bool _interrupted = false;

  @override
  void onStart(Map<String, dynamic> params) {
    print('background on start');
    _podcastProvider = PodcastProvider();
    _player = AudioPlayer();
    print('started audio player');

    // attach player to audio service
    _player.playbackStateStream
        .where((state) => state == AudioPlaybackState.completed)
        .listen((state) {
      _handlePlaybackCompleted();
    });

    _player.playbackEventStream.listen((event) {
      final state = _eventToBasicState(event);
      if (state != AudioProcessingState.stopped) {
        _setState(
          state: state,
          position: _getPosition(),
          speed: _getSpeed(),
        );
      }
    });
  }

  @override
  void onPlayMediaItem(MediaItem mediaItem) async {
    // need to first get the latest playback for user
    final userEpi = _podcastProvider.getUserEpisode(
        _token, mediaItem.extras['epi_id'], mediaItem.extras['pod_id']);

    Duration duration;
    // set the url, buffer, and play
    if (_isURL(mediaItem.id)) {
      print('playing from url: ${mediaItem.id}');
      duration = await _player.setUrl(mediaItem.id).then((value) {
        print('finisehed setting url');
        return;
      });
    } else {
      print('playing from file path: ${mediaItem.id}');
      duration = await _player.setFilePath(mediaItem.id);
    }

    // update duration if necessary
    print('media duration: ${mediaItem.duration}');
    if (mediaItem.duration == null || mediaItem.duration.inMilliseconds == 0) {
      mediaItem = mediaItem.copyWith(duration: duration);
    }

    // "add to queue"
    AudioServiceBackground.setMediaItem(mediaItem);
    _queue.clear();
    _queue.add(mediaItem);
    _qIndex = 0;

    // play and set the offset
    userEpi.then((value) {
      print('val of userEpi: $value');
      if (value?.offset != null) {
        _seek(Duration(milliseconds: value.offset))
            .then((value) => _player.play());
      } else {
        _player.play();
      }
    });
  }

  @override
  void onAddQueueItem(MediaItem mediaItem) {
    // assume we are adding mediaitem from latest play
    if (_queue.length == 0) {
      _addLatestPlayed(mediaItem);
    } else {
      _queue.add(mediaItem);
    }
  }

  @override
  Future onCustomAction(String name, arguments) async {
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
  void onAudioBecomingNoisy() {
    print('headphone jack, or bluetooth device disconnected, pausing');
    _pause();
  }

  @override
  Future<void> onStop() async {
    print('background stop');
    _queue.clear();
    await _player.stop();

    await super.onStop();
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

  // @override
  // void onAudioFocusLostTransient() {
  //   print('onAudioFocusLostTransient()');
  //   if (_player.playbackState == AudioPlaybackState.playing) {
  //     _player.pause();
  //     pausedFromSystem = true;
  //   }
  // }

  // @override
  // void onAudioFocusLostTransientCanDuck() {
  //   _player.setVolume(33);
  // }

  @override
  void onAudioFocusLost(AudioInterruption interruption) {
    print('audio focus lost: $interruption');

    if (_isPlaying()) _interrupted = true;
    switch (interruption) {
      case AudioInterruption.pause:
      case AudioInterruption.temporaryPause:
      case AudioInterruption.unknownPause:
        onPause();
        break;
      case AudioInterruption.temporaryDuck:
        _player.setVolume(50);
    }
  }

  @override
  void onAudioFocusGained(AudioInterruption interruption) {
    print('audio focus gained: $interruption');
    _player.play();
    _player.setVolume(100);
  }

  @override
  void onSeekTo(Duration position) {
    _seek(position);
  }

  // ***************** helper methods for the audio service ***************** //

  /// _addLatestPlayed takes a media item and adds it to the queue
  /// its assumed that nothing is previously in the queue
  /// and the item.extras contains an offset value
  void _addLatestPlayed(MediaItem item) {
    // set the queue and add to audio service background
    _queue.clear();
    _queue.add(item);
    _qIndex = 0;
    AudioServiceBackground.setMediaItem(item);

    // set the proper offset
    _player.setUrl(item.id).then((value) {
      print("seeking: ${item.extras['offset']}");
      _seek(Duration(milliseconds: item.extras['offset'])).then((value) {
        // a hack to otherwise player stays in a perpetual state of loading
        // TODO: fix???
        _player.play();
        _player.pause();
      });
    });
  }

  Duration _getPosition() => _player.playbackEvent == null
      ? Duration.zero
      : _player.playbackEvent.position;

  Duration _getDuration() => (_queue.length > 0)
      ? _queue[_qIndex].duration
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
  Future<void> _seek(Duration d) async {
    // check for proper seeking state
    final state = _player.playbackState;
    if (state != AudioPlaybackState.connecting &&
        state != AudioPlaybackState.none) {
      // prevent seeking negative
      if (d.isNegative) d = Duration.zero;

      // prevent seeking past total duration
      final ttlDur = _getDuration();
      if (d > ttlDur) d = (ttlDur - Duration(seconds: 5));

      return _player.seek(d);
    }
  }

  bool _isPlaying() {
    return _player.playbackState == AudioPlaybackState.playing;
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
      {@required AudioProcessingState state, Duration position, double speed}) {
    if (position == null) {
      position = _player.playbackEvent.position;
    }
    AudioServiceBackground.setState(
      controls: getControls(state),
      processingState: state,
      position: position,
      playing: _player.playbackState == AudioPlaybackState.playing,
      speed: speed,
    );
  }

  List<MediaControl> getControls(AudioProcessingState state) {
    if (_player.playbackState == AudioPlaybackState.playing) {
      return [rewindControl, pauseControl, forwardControl];
    } else {
      return [rewindControl, playControl, forwardControl];
    }
  }

  AudioProcessingState _eventToBasicState(AudioPlaybackEvent event) {
    if (event.buffering) {
      return AudioProcessingState.buffering;
    } else {
      switch (event.state) {
        case AudioPlaybackState.none:
          return AudioProcessingState.none;
        case AudioPlaybackState.stopped:
          return AudioProcessingState.stopped;
        case AudioPlaybackState.paused:
        case AudioPlaybackState.playing:
          return AudioProcessingState.ready;
        case AudioPlaybackState.connecting:
          return AudioProcessingState.connecting;
        case AudioPlaybackState.completed:
          return AudioProcessingState.completed;
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
  if (!AudioService.running) {
    return AudioService.start(
      backgroundTaskEntrypoint: backgroundTaskEntrypoint,
      androidNotificationChannelName: 'syncapod audio',
      androidArtDownscaleSize: Size(200, 200),
      androidNotificationColor: darkGrey.value,
      androidEnableQueue: true,
      androidStopForegroundOnPause: true,
    ).catchError((error) {
      print('error starting audioService: $error');
    });
  } else
    return Future.value(false);
}
