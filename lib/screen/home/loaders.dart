import 'package:flatter_playground/component/rerunnable_future.dart';
import 'package:flatter_playground/component/scaffold/start_drawer.dart';
import 'package:flatter_playground/component/scaffold/switch_theme_button.dart';
import 'package:flutter/material.dart';

Future asyncData() async {
  await Future.delayed(const Duration(seconds: 2), () {});

  return 'Hello World';
}

class Loaders extends StatelessWidget {
  const Loaders({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: StartDrawer(),
      appBar: AppBar(title: const Text("LOADERS")),
      body: const ReRunnableFutureWidget(future: asyncData),
      floatingActionButton: const SwitchThemeButton(),
    );
  }
}
