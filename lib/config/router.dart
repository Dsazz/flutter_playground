import 'package:flatter_playground/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:your_splash/your_splash.dart';

class Routers {
  static const String SPLASH_SCREEN = '/';
  static const String HOME = '/home';

  static Map<String, WidgetBuilder> init(BuildContext context) {
    return {
      SPLASH_SCREEN: (context) => SplashScreen.timed(
            seconds: 3,
            navigate: PageRouteBuilder(
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
    };
  }
}
