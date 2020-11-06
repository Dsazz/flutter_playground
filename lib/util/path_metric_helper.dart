import 'dart:ui';

import 'package:flutter/material.dart';

class PathMetricHelper {
  static Offset getAnimatedBlockPosition(
    Path path,
    double distance,
    double blockSize,
  ) {
    if (null == path || distance == 0 || distance == 1)
      return Offset(-blockSize, 0);

    final totalLength = getTotalLength(path);
    final currentLength = totalLength * distance;
    final metrics = path.computeMetrics();
    final metricsIterator = metrics.iterator;

    double countedLength = 0.0;
    while (metricsIterator.moveNext()) {
      final metric = metricsIterator.current;
      final nextLength = countedLength + metric.length;
      final isCurrent =
          currentLength >= countedLength && nextLength >= currentLength;
      final isFirst = countedLength == 0 && currentLength <= metric.length;

      if (isFirst || isCurrent) {
        var value = currentLength - countedLength;
        Tangent pos = metric.getTangentForOffset(value);

        return Offset(pos.position.dx - blockSize * 0.5,
            pos.position.dy - blockSize * 0.5);
      }

      countedLength = nextLength;
    }

    return Offset.zero;
  }

  static Path createAnimatedPath(
    Path originalPath,
    double animationPercent,
  ) {
    final totalLength = getTotalLength(originalPath);
    final currentLength = totalLength * animationPercent;

    return extractPathByLength(originalPath, currentLength);
  }

  static double getTotalLength(Path path) {
    return path
        .computeMetrics()
        .fold(0.0, (double prev, PathMetric metric) => prev + metric.length);
  }

  static Path extractPathByLength(
    Path originalPath,
    double length,
  ) {
    double currentLength = 0.0;

    final path = new Path();
    final metricsIterator = originalPath.computeMetrics().iterator;
    while (metricsIterator.moveNext()) {
      final metric = metricsIterator.current;
      final nextLength = currentLength + metric.length;
      final isLastSegment = nextLength > length;
      final remainingLength =
          isLastSegment ? length - currentLength : metric.length;
      final pathSegment = metric.extractPath(0.0, remainingLength);

      path.addPath(pathSegment, Offset.zero);

      currentLength = nextLength;
    }

    return path;
  }
}
