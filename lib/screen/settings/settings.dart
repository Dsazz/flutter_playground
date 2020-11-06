import 'package:flag/flag.dart';
import 'package:flatter_playground/component/scaffold/start_drawer.dart';
import 'package:flatter_playground/lang/l10n.dart';
import 'package:flatter_playground/screen/settings/bloc/settings_bloc.dart';
import 'package:flatter_playground/screen/settings/bloc/settings_state_data.dart';
import 'package:flatter_playground/service/audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'language_settings.dart';
part 'theme_mode_settings.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
      if (state is SettingsThemeChange) {
        AudioPlayerController _player = GetIt.I<AudioPlayerController>();
        _player.play("press_on");
      }
    }, builder: (context, settings) {
      return Scaffold(
        drawer: StartDrawer(),
        appBar: AppBar(title: Text(L10n.of(context).settings)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                clipBehavior: Clip.antiAlias,
                elevation: 2,
                child: Column(
                  children: <Widget>[
                    LanguageSettings(L10n.of(context), settings.data),
                    const Divider(height: 1),
                    ThemeModeSettings(L10n.of(context), settings.data.lightOn),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
