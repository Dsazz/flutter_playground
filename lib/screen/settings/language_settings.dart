part of 'settings.dart';

class LanguageSettings extends StatelessWidget {
  final L10n l10n;
  final SettingsData settings;

  LanguageSettings(this.l10n, this.settings);

  @override
  Widget build(BuildContext context) {
    var selectedLang = settings.selectedLanguage;

    return ListTile(
        title: Text(l10n.language),
        subtitle: Text(selectedLang.title),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey.shade400,
        ),
        leading: const SizedBox(
          height: double.infinity,
          child: Icon(Icons.language),
        ),
        onTap: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(children: [
                  Stack(children: [
                    Container(
                      width: double.infinity,
                      height: 56.0,
                      child: Center(
                        child: Text(l10n.language),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      top: 0.0,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ]),
                  Flexible(
                    child: ListWheelScrollView(
                      controller: FixedExtentScrollController(
                          initialItem: selectedLang.index),
                      magnification: 1.5,
                      useMagnifier: true,
                      physics: FixedExtentScrollPhysics(),
                      squeeze: 0.8,
                      itemExtent: 60,
                      onSelectedItemChanged: (index) {
                        BlocProvider.of<SettingsBloc>(context).add(
                          SettingsLocaleChanged(
                            locale: settings.languageByIndex(index).key,
                          ),
                        );
                      },
                      children: <Widget>[
                        ...settings.languages.map((item) {
                          return ListTile(
                            leading: Flag(
                              item.flag,
                              width: 50,
                              height: 35,
                              fit: BoxFit.fill,
                            ),
                            title: Text(item.title),
                            subtitle: Text(l10n.lang(item.key)),
                          );
                        }),
                      ],
                    ),
                  ),
                ]),
              );
            },
          );
        });
  }
}
