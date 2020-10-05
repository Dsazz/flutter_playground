import 'package:flatter_playground/util/util.dart';
import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;

  const DrawerListTile(this.icon, this.title, this.route);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: TextStyle(fontSize: 16.0)),
      onTap: () {
        if (!popAndPushNamedIfNotCurrent(context, route)) {
          Navigator.pop(context);
        }
      },
    );
  }
}
