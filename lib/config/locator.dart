import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get_it/get_it.dart';

void setupLocator() {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioCache _player = AudioCache(fixedPlayer: _audioPlayer);
  _player.loadAll([
    "sound/star_1.mp3",
    "sound/star_2.mp3",
    "sound/star_3.mp3",
    "sound/ghost.mp3",
  ]);

  GetIt.I.registerSingleton<AudioCache>(_player);
}
