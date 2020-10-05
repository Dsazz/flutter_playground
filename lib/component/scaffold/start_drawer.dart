import 'package:flatter_playground/config/router.dart';
import 'package:flatter_playground/util/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'drawer_list_tile.dart';

class StartDrawer extends StatelessWidget {
  final List<double> _defaultStops = <double>[
    0.0,
    0.45,
    0.5,
    0.55,
    1.0,
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          const DrawerListTile(Icons.slideshow, "Animations", Routers.HOME),
          const DrawerListTile(Icons.album, "Loaders", Routers.LOADERS),
          const Divider(),
          // const DrawerListTile(Icons.build, "Tools", Routers.HOME),
          AboutListTile(
            icon: const Icon(Icons.info),
            child: const Text("About"),
            applicationIcon: Shimmer(
              child: Image(
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
    );
  }
}
