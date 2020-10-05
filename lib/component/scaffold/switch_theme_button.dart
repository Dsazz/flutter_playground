import 'package:flatter_playground/notifier/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchThemeButton extends StatelessWidget {
  const SwitchThemeButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Provider.of<ThemeNotifier>(context, listen: false).switchTheme();
      },
      child: Icon(
          Provider.of<ThemeNotifier>(context, listen: false).isLightModeOn()
              ? Icons.brightness_3
              : Icons.brightness_high),
    );
  }
}
