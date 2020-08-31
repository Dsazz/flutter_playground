import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'config/locator.dart';
import 'config/router.dart';
import 'notifier/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //Here we provide our ThemeNotifier to child widget tree
      create: (_) => ThemeNotifier(),

      //Consumer will call builder method each time ThemeNotifier
      //calls notifyListeners()
      child: Consumer<ThemeNotifier>(builder: (context, themeNotifier, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeNotifier.getTheme(),
          title: 'Playground application',
          initialRoute: Routers.SPLASH_SCREEN,
          routes: Routers.init(context),
        );
      }),
    );
  }
}
