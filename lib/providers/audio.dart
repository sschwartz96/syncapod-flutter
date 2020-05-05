import 'package:just_audio/just_audio.dart';
import 'package:syncapod/models/podcast.dart';

class AudioProvider {
  final AudioPlayer _audioPlayer;
  AudioProvider(this._audioPlayer);

  void playPodcast(Podcast p) {}

  Future<Duration> playEpisode(Episode e) async {
    // TODO: pull data from account about the user and this episode

    final duration = await _audioPlayer.setUrl(e.mp3URL).catchError((error) {
      print('error playing episode: $error');
    });
    _audioPlayer.play();
    return duration;
  }

  void seek(Duration d) {
    _audioPlayer.seek(d);
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
}
