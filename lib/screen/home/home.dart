import 'package:flatter_playground/component/scaffold/start_drawer.dart';
import 'package:flatter_playground/component/scaffold/switch_theme_button.dart';
import 'package:flatter_playground/screen/home/tab_item.dart';
import 'package:flutter/material.dart';

import 'animation/ghost.dart';
import 'animation/grow.dart';
import 'animation/opacity.dart';
import 'animation/rotate.dart';
import 'animation/star_buttons.dart';
import 'animation/wave.dart';

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
      appBar: AppBar(title: const Text("ANIMATIONS")),
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
      floatingActionButton: const SwitchThemeButton(),
    );
  }
}
