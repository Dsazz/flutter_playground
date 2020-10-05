import 'package:flatter_playground/component/button/round_icon_button.dart';
import 'package:flatter_playground/component/loader/circle_loader.dart';
import 'package:flatter_playground/component/loader/flashing_dots_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'loader/bouncing_dots_loader.dart';

enum ReRunnableFutureLoaderType { FlashingDots, BouncingDots, Circle }

typedef ReRunnableFuture = Future<dynamic> Function();
typedef dynamic OnRerunFunc({ReRunnableFutureLoaderType loader});

class ReRunnableFutureWidget extends StatefulWidget {
  final ReRunnableFuture future;

  const ReRunnableFutureWidget({Key key, this.future}) : super(key: key);

  @override
  _ReRunnableFutureWidgetState createState() => _ReRunnableFutureWidgetState();
}

class _ReRunnableFutureWidgetState extends State<ReRunnableFutureWidget> {
  ReRunnableFutureLoaderType loaderType =
      ReRunnableFutureLoaderType.FlashingDots;

  @override
  Widget build(BuildContext context) {
    return ReRunnableFutureBuilder(widget.future,
        loader: this._getLoader(loaderType), onRerun: _runFuture);
  }

  StatefulWidget _getLoader(ReRunnableFutureLoaderType loader) {
    switch (loader) {
      case ReRunnableFutureLoaderType.BouncingDots:
        return BouncingDotsLoader(dotIcon: Icons.star, dotSize: 75);
      case ReRunnableFutureLoaderType.FlashingDots:
        return FlashingDotsLoader(dotIcon: Icons.star, dotSize: 75);
      case ReRunnableFutureLoaderType.Circle:
        return CircleLoader();
      default:
        return FlashingDotsLoader(dotIcon: Icons.star, dotSize: 75);
    }
  }

  _runFuture({ReRunnableFutureLoaderType loader}) {
    if (loader != null) {
      loaderType = loader;
    }

    widget.future();
    setState(() {});
  }
}

class ReRunnableFutureBuilder extends StatelessWidget {
  final ReRunnableFuture _future;
  final OnRerunFunc onRerun;
  final StatefulWidget loader;

  const ReRunnableFutureBuilder(this._future, {this.loader, this.onRerun});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container(
              alignment: Alignment.center,
              child: loader,
            );
          }

          if (snapshot.hasError) {
            return _ResultView(
                text: "ERROR: ${snapshot.error.toString()}", onRerun: onRerun);
          }

          return _ResultView(
            text: "RESULT: ${snapshot.data}",
            onRerun: onRerun,
          );
        });
  }
}

class _ResultView extends StatelessWidget {
  final String text;
  final OnRerunFunc onRerun;

  const _ResultView({Key key, this.text, this.onRerun}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          RoundIconButton(
              buttonText: const Text(
                "BOUNCING LOADER",
                style: TextStyle(color: Colors.white),
              ),
              icon: Icons.bubble_chart,
              backgroundColor: Colors.green,
              onPressed: () {
                onRerun(loader: ReRunnableFutureLoaderType.BouncingDots);
              }),
          RoundIconButton(
              buttonText: const Text(
                "FLASHING LOADER",
                style: TextStyle(color: Colors.white),
              ),
              icon: Icons.flash_on,
              backgroundColor: Colors.red,
              onPressed: () {
                onRerun(loader: ReRunnableFutureLoaderType.FlashingDots);
              }),
          RoundIconButton(
              buttonText: const Text(
                "CIRCLE LOADER",
                style: TextStyle(color: Colors.white),
              ),
              icon: Icons.blur_circular,
              backgroundColor: Colors.orange,
              onPressed: () {
                onRerun(loader: ReRunnableFutureLoaderType.Circle);
              }),
          const Divider(height: 50, indent: 20, endIndent: 20),
          Text(
            text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ]);
  }
}
