part of 'settings.dart';

class ThemeModeSettings extends StatelessWidget {
  final L10n l10n;
  final bool lightOn;

  ThemeModeSettings(this.l10n, this.lightOn);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        title: Text(l10n.darkMode),
        secondary: const SizedBox(
          height: double.infinity,
          child: Icon(Icons.color_lens),
        ),
        subtitle: Text(lightOn ? l10n.off : l10n.on),
        value: !lightOn,
        onChanged: (value) {
          BlocProvider.of<SettingsBloc>(context)
              .add(SettingsThemeChanged(lightOn: !value));
        });
  }
}
