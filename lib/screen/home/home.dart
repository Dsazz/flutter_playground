import 'package:flatter_playground/component/scaffold/start_drawer.dart';
import 'package:flatter_playground/lang/l10n.dart';
import 'package:flatter_playground/screen/home/tab_item.dart';
import 'package:flutter/material.dart';

import 'animation/animations.dart';

class Home extends StatelessWidget {
  final tabAnimations = <StatefulWidget>[
    AnimatedStarButtonsPainter(key: GlobalKey()),
    AnimatedGhostPainter(key: GlobalKey()),
    GrowAnimation(key: GlobalKey()),
    OpacityAnimation(key: GlobalKey()),
    RotateAnimation(key: GlobalKey()),
    WaveAnimation(key: GlobalKey(), height: 150, speed: 1.0),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: StartDrawer(),
      appBar: AppBar(title: Text(L10n.of(context).animations.toUpperCase())),
      body: Container(
        child: ListView.separated(
          itemBuilder: (context, index) => Container(
            height: 170.0,
            child: TabItem(item: tabAnimations[index]),
          ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: tabAnimations.length,
        ),
      ),
    );
  }
}
