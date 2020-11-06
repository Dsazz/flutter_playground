import 'package:flatter_playground/config/router.dart';
import 'package:flatter_playground/lang/l10n.dart';
import 'package:flatter_playground/util/oval_right_border_clipper.dart';
import 'package:flatter_playground/util/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'drawer_list_tile.dart';

class StartDrawer extends StatelessWidget {
  static const List<double> _defaultStops = <double>[
    0.0,
    0.45,
    0.5,
    0.55,
    1.0,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    const RotatedBox(
                      quarterTurns: -1,
                      child: Text(
                        "FLUTTER PLAYGROUND",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Shimmer(
                      child: Image(
                        image: AssetImage("assets/image/menu.png"),
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: <Color>[
                          Colors.white10.withOpacity(0.0),
                          Colors.white10.withOpacity(0.0),
                          Colors.white,
                          Colors.white10.withOpacity(0.0),
                          Colors.white10.withOpacity(0.0),
                        ],
                        // stops: defaultStops,
                        stops: _defaultStops,
                      ),
                    ),
                  ],
                ),
              ),
              DrawerListTile(Icons.slideshow, l10n.animations, Routers.HOME),
              DrawerListTile(Icons.album, l10n.loaders, Routers.LOADERS),
              DrawerListTile(
                Icons.cloud,
                l10n.weather + " (BloC+API)",
                Routers.WEATHER,
              ),
              const Divider(),
              DrawerListTile(Icons.build, l10n.settings, Routers.SETTINGS),
              AboutListTile(
                icon: const Icon(Icons.info),
                child: Text(l10n.about, style: TextStyle(fontSize: 16.0)),
                applicationIcon: Shimmer(
                  child: const Image(
                    image: AssetImage("assets/image/icon.png"),
                    width: 65,
                    height: 65,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Colors.white10.withOpacity(0.0),
                      Colors.white10.withOpacity(0.0),
                      Colors.white,
                      Colors.white10.withOpacity(0.0),
                      Colors.white10.withOpacity(0.0),
                    ],
                    stops: _defaultStops,
                  ),
                ),
                applicationName: "Flutter Playground",
                applicationVersion: "0.0.1",
                applicationLegalese: "© 2019 Stanislav Stepanenko",
                aboutBoxChildren: <Widget>[
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  const Text("Playground app for Flutter!"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
