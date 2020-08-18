import 'dart:math';

T cast<T>(x) => x is T ? x : null;

num degToRad(num deg) => deg * (pi / 180.0);

//bool isDarkTheme(BuildContext context) {
//  var mode = Theme.of(context).brightness;
//  print("BRIGHT $mode");
//  return Theme.of(context).brightness == Brightness.dark;
//}
