import 'package:flutter/material.dart';
import 'package:fplayground/component/button/play.dart';
import 'package:fplayground/util/util.dart';

import 'animation/base_animation.dart';

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
        Container(
          height: 170.0,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child:
                    PlayButton(onPressed: cast<BaseAnimation>(item).onPressed),
              ),
              Expanded(
                flex: 7,
                child: item,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
