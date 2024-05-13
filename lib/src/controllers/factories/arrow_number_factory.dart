import 'dart:ui';

import 'package:flutter_painter/flutter_painter.dart';
import 'package:flutter_painter/src/controllers/drawables/shape/arrow_number_drawable.dart';

/// A [ArrowNumberDrawable] factory.
class ArrowNumberFactory extends ShapeFactory<ArrowNumberDrawable> {
  final PainterController controller;

  /// The size of the arrow head to be used in created [ArrowDrawable]s.
  double? arrowHeadSize;

  Offset? numberOffset;

  bool locked;

  /// Creates an instance of [ArrowFactory] with the given [arrowHeadSize].
  ArrowNumberFactory(
      {required this.controller,
      this.arrowHeadSize,
      this.numberOffset,
      this.locked = false})
      : super();

  /// Creates and returns a [ArrowDrawable] with length of 0 and the passed [position] and [paint].
  @override
  ArrowNumberDrawable create(Offset position, [Paint? paint]) {
    final drawables = controller.drawables.whereType<ArrowNumberDrawable>();
    final len = drawables.length;

    return ArrowNumberDrawable(
        length: 0,
        position: position,
        paint: paint,
        arrowHeadSize: arrowHeadSize,
        number: "${len + 1}",
        locked: locked,
        numberOffset: numberOffset);
  }
}
