import 'package:flatter_playground/screen/home/home.dart';
import 'package:flatter_playground/screen/home/loaders.dart';
import 'package:flutter/material.dart';
import 'package:your_splash/your_splash.dart';

class Routers {
  static const String SPLASH_SCREEN = '/';
  static const String HOME = '/home';
  static const String LOADERS = '/loaders';

  static Map<String, WidgetBuilder> init(BuildContext context) {
    return {
      SPLASH_SCREEN: (context) => SplashScreen.timed(
            seconds: 1,
            route: PageRouteBuilder(
              settings: RouteSettings(name: HOME),
              pageBuilder: (context, animation, secondaryAnimation) => Home(),
              transitionDuration: Duration(seconds: 1),
              transitionsBuilder: (_, animation, secAnim, child) {
                var tween = Tween(begin: 0.0, end: 1.0).chain(
                  CurveTween(curve: Curves.easeInOutCirc),
                );
                return FadeTransition(
                    opacity: animation.drive(tween), child: child);
              },
            ),
            body: Scaffold(
              body: InkWell(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/image/splash.jpg"),
                    ),
                  ),
                ),
              ),
            ),
          ),
      HOME: (context) => Home(),
      LOADERS: (context) => const Loaders(),
    };
  }
}
