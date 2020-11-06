import 'package:flatter_playground/component/scaffold/start_drawer.dart';
import 'package:flatter_playground/lang/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: StartDrawer(),
      appBar: AppBar(title: Text(L10n.of(context).weather.toUpperCase())),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 3), () {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text("Success"),
              ),
            );
          });
        },
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: Icon(CupertinoIcons.cloud_bolt_rain_fill),
            ),
          ],
        ),
      ),
    );
  }
}
