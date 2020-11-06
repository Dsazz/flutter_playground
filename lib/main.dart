import 'package:flatter_playground/screen/settings/bloc/settings_bloc.dart';
import 'package:flatter_playground/util/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/locator.dart';
import 'config/router.dart';
import 'lang/l10n_delegate.dart';

void main() {
  Bloc.observer = CustomBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  setupLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(),
        ),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingsState) {
      return MaterialApp(
        localizationsDelegates: [
          const L10nDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('us'),
          const Locale('ru'),
          const Locale('ua'),
        ],
        debugShowCheckedModeBanner: false,
        theme: settingsState.data.theme,
        title: 'Playground application',
        initialRoute: Routers.SPLASH_SCREEN,
        routes: Routers.init(context),
      );
    });
  }
}
