import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  final VoidCallback onPressed;

  PlayButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.green,
      radius: 20,
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(Icons.play_arrow),
        color: Colors.white,
        onPressed: onPressed,
      ),
    );
  }
}
