import 'package:assets_audio_player/assets_audio_player.dart';


bool nextDone = true;
bool previousDone = true;

class assetAudioplayineTools {
  static nextplay({required AssetsAudioPlayer audioPlayer}) async {
    if (nextDone) {
      nextDone = false;
      await audioPlayer.next();
      nextDone = true;
    }
  }

  static previousplay({required AssetsAudioPlayer audioPlayer}) async {
    if (previousDone) {
      previousDone = false;
      await audioPlayer.previous();
      previousDone = true;
    }
  }

  static playbutton({required AssetsAudioPlayer audioPlayer}) {
    audioPlayer.playOrPause();
  
  }

  static shufflesong( { required AssetsAudioPlayer audioPlayer} ){
    audioPlayer.shuffle;
  }
}
