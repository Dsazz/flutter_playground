import 'package:flutter/material.dart';
import 'package:fplayground/animation/base_animation.dart';

import 'animation/grow.dart';
import 'animation/opacity.dart';
import 'animation/rotate.dart';
import 'component/button/play.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("PLAYGROUND"),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.accessible_forward)),
                Tab(icon: Icon(Icons.ac_unit))
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                child: ListView.separated(
                  itemBuilder: (context, index) => Container(
                    height: 150.0,
                    child: TabItem(item: tabAnimations[index]),
                  ),
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.green,
                  ),
                  itemCount: tabAnimations.length,
                ),
              ),
              Center(
                child: RaisedButton(
                  child: Text('Do simple animation'),
                  onPressed: () => {print('Pressed!!!')},
                  splashColor: Colors.amberAccent,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//@todo Move to some helper class
//T cast<T>(x) => x is T ? x : null;
T cast<T>(x) {
  if (x is T) {
    print("$x !!!");
    return x;
  } else {
    print("$x noope");
    return null;
  }
}

class TabItem extends StatelessWidget {
  final StatefulWidget item;

  TabItem({@required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PlayButton(onPressed: cast<BaseAnimation>(item).onPressed),
            ),
            Expanded(
              flex: 7,
              child: item,
            ),
          ],
        ),
      ],
    );
  }
}

final tabAnimations = <StatefulWidget>[
  GrowAnimation(),
  OpacityAnimation(),
  RotateAnimation(),
];
