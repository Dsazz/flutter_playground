import 'dart:math';

import 'package:flutter/material.dart';

T cast<T>(x) => x is T ? x : null;

num degToRad(num deg) => deg * (pi / 180.0);
num calcCircumference(num radius) => 2 * pi * radius;

Size mediaSize(context) => MediaQuery.of(context).size;

double roundDouble(double value, int places) {
  double mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}
