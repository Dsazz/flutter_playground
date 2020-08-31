import 'package:flatter_playground/notifier/theme.dart';
import 'package:flatter_playground/screen/home/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'animation/ghost.dart';
import 'animation/grow.dart';
import 'animation/opacity.dart';
import 'animation/rotate.dart';
import 'animation/star_buttons.dart';
import 'animation/wave.dart';

final tabAnimations = <StatefulWidget>[
  AnimatedStarButtonsPainter(),
  AnimatedGhostPainter(),
  GrowAnimation(),
  OpacityAnimation(),
  RotateAnimation(),
  WaveAnimation(
    height: 150,
    speed: 1.0,
  ),
];

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("PLAYGROUND"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.ondemand_video)),
              Tab(icon: Icon(Icons.video_library))
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: ListView.separated(
                itemBuilder: (context, index) => Container(
                  height: 170.0,
                  child: TabItem(item: tabAnimations[index]),
                ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: tabAnimations.length,
              ),
            ),
            Center(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<ThemeNotifier>(context, listen: false).switchTheme();
          },
          child: Icon(
              Provider.of<ThemeNotifier>(context, listen: false).isLightModeOn()
                  ? Icons.brightness_3
                  : Icons.brightness_high),
        ),
      ),
    );
  }
}
