import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

final OnAudioQuery _audioQuery = OnAudioQuery();
AudioPlayer audioPlayer = AudioPlayer();

class JustAudio {
  static nextplay() {
    if (audioPlayer.hasNext) {
      audioPlayer.seekToNext();
    }
  }

  static previousplay() {
    if (audioPlayer.hasPrevious) {
      audioPlayer.seekToPrevious();
    }
  }
}
