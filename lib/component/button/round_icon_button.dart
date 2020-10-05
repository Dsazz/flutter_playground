import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final Color backgroundColor;
  final Text buttonText;
  final IconData icon;
  final Color iconColor;
  final Alignment iconAlignment;
  final Function onPressed;

  const RoundIconButton({
    this.backgroundColor = Colors.redAccent,
    this.buttonText = const Text("TEXT"),
    this.icon = Icons.email,
    this.iconColor,
    this.iconAlignment = Alignment.centerLeft,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    SizedBox emptyBox = const SizedBox();

    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              splashColor: backgroundColor,
              color: backgroundColor,
              child: Row(
                children: <Widget>[
                  iconAlignment == Alignment.centerLeft
                      ? new Transform.translate(
                          offset: Offset(-10.0, 0.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28.0),
                              ),
                              splashColor: Colors.white,
                              color: Colors.white,
                              child: Icon(
                                icon,
                                color: iconColor == null
                                    ? backgroundColor
                                    : iconColor,
                              ),
                              onPressed: () => {},
                            ),
                          ),
                        )
                      : emptyBox,
                  iconAlignment == Alignment.centerLeft
                      ? Expanded(child: emptyBox)
                      : emptyBox,
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                    child: buttonText,
                  ),
                  iconAlignment == Alignment.centerRight
                      ? Expanded(child: emptyBox)
                      : emptyBox,
                  iconAlignment == Alignment.centerRight
                      ? Transform.translate(
                          offset: Offset(10.0, 0.0),
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.0)),
                              splashColor: Colors.white,
                              color: Colors.white,
                              child: Icon(
                                icon,
                                color: iconColor == null
                                    ? backgroundColor
                                    : iconColor,
                              ),
                              onPressed: () => {},
                            ),
                          ),
                        )
                      : emptyBox,
                ],
              ),
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
