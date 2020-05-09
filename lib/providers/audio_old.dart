import 'package:just_audio/just_audio.dart';
import 'package:syncapod/models/podcast.dart';

class AudioProvider {
  final AudioPlayer _audioPlayer;
  AudioProvider(this._audioPlayer) {
    _playlist = List<Episode>();
  }

  List<Episode> _playlist;
  int _curListIndex;

  // TODO: build a playlist based on if the user is playing a single podcast (choose next episode)
  // or listening to a podcast within his/her subscriptions
  void buildPlaylist(Podcast p, Episode e) {
    if (_playlist.length == 0) {
      // first add our current podcast
      _playlist.add(e);

      // TODO: generate next podcast(s)
    }
  }

  void playPodcast(Podcast p) {
    buildPlaylist(p, null);
  }

  Future<Duration> playEpisode(Episode e) async {
    // TODO: pull data from account about the user and this episode

    buildPlaylist(null, e);
    final duration = await _audioPlayer.setUrl(e.mp3URL).catchError((error) {
      print('error playing episode: $error');
    });
    _audioPlayer.stop();
    _audioPlayer.play();
    return duration;
  }

  void seek(Duration d) {
    _audioPlayer.seek(d);
  }

  void add(Duration dur, Duration pos, Duration delta) {
    Duration newDur = pos + delta;
    if (newDur < dur) {
      seek(newDur);
    } else {
      seek(dur - Duration(seconds: 1));
    }
  }

  void subtract(Duration pos, Duration delta) {
    Duration newDur = pos - delta;
    if (newDur.inMilliseconds > 0) {
      seek(newDur);
    } else {
      seek(Duration.zero);
    }
  }

  Stream<FullAudioPlaybackState> getFullPlaybackStream() {
    return _audioPlayer.fullPlaybackStateStream;
  }

  Stream<Duration> getPositionStream() {
    return _audioPlayer.getPositionStream();
  }

  Future<Duration> getDuration() async {
    if (_audioPlayer.playbackState != AudioPlaybackState.connecting) {
      return await _audioPlayer.durationFuture;
    }
  }

  bool isPlaying() {
    return _audioPlayer.playbackState == AudioPlaybackState.playing;
  }

  void resume() async {
    if (_audioPlayer.playbackState == AudioPlaybackState.paused)
      await _audioPlayer.play();
  }

  void pause() async {
    await _audioPlayer.pause();
    // TODO: update the playback position to the server
  }

  void stop() {
    _audioPlayer.stop();
    // TODO: update the playback position to the server
  }

  void previous(Duration pos) {
    if (_curListIndex == 0) {
      // do nothing ? yes
      _audioPlayer.seek(Duration.zero);
    } else {
      if (pos.inSeconds > 5) {
        _audioPlayer.seek(Duration.zero);
      } else {
        _curListIndex--;
        playEpisode(_playlist[_curListIndex]);
      }
    }
  }

  void next() {
    if (_curListIndex == _playlist.length) {
      // do nothing? or find another episode somewhere
    } else {
      // TODO: update the episode with current position
      _curListIndex++;
      playEpisode(_playlist[_curListIndex]);
    }
  }
}
