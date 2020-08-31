import 'package:assets_audio_player/assets_audio_player.dart';

class AudioPlayerController {
  static AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.newPlayer();

  Future<void> play(String sound) async {
    await _audioPlayer.open(Audio("assets/sound/$sound.mp3"));
    _audioPlayer.setVolume(1);
    await _audioPlayer.play();
  }

  void stop() async {
    await _audioPlayer.stop();
  }
}
