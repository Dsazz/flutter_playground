import 'package:assets_audio_player/assets_audio_player.dart';

class AudioPlayerController {
  void play(String sound) async {
    AssetsAudioPlayer.playAndForget(Audio("assets/sound/$sound.mp3"),
        volume: 0.5);
  }
}
