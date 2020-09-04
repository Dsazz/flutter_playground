import 'package:flatter_playground/config/theme.dart';
import 'package:flatter_playground/service/audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  final _kLightModeOn = "light_mode_on";
  AudioPlayerController _player = GetIt.I<AudioPlayerController>();

  ThemeData _themeData;

  ThemeNotifier() {
    _loadTheme();
  }

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;

    // Save selected theme into SharedPreferences
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(_kLightModeOn, themeData.brightness == Brightness.light);

    notifyListeners();
  }

  bool isLightModeOn() {
    return _themeData?.brightness == Brightness.light;
  }

  switchTheme() async {
    _player.play("press_on");
    setTheme(isLightModeOn() ? darkTheme : lightTheme);
  }

  void _loadTheme() {
    SharedPreferences.getInstance().then((prefs) {
      bool lightModeOn = prefs.getBool(_kLightModeOn) ?? true;
      _themeData = lightModeOn ? lightTheme : darkTheme;

      notifyListeners();
    });
  }
}
