import 'package:flutter/material.dart';
import 'package:flutter_painter/src/controllers/drawables/shape/circle_selection_drawable.dart';

import '../drawables/shape/oval_drawable.dart';
import 'shape_factory.dart';

/// A [CircleSelectionFactory] factory.
class CircleSelectionFactory extends ShapeFactory<CircleSelectionDrawable> {
  double radius;
  Color color;
  double lineWidth;

  Offset? Function(Offset) converter;

  /// Creates an instance of [CircleSelectionFactory].
  CircleSelectionFactory(
      {this.radius = 30,
      this.color = Colors.blue,
      this.lineWidth = 2,
      required this.converter})
      : super();

  /// Creates and returns a [OvalDrawable] of zero size and the passed [position] and [paint].
  @override
  CircleSelectionDrawable create(Offset position, [Paint? paint]) {
    return CircleSelectionDrawable(
        converter: converter,
        size: Size(2 * radius, 2 * radius),
        position: position,
        color: color,
        lineWidth: lineWidth,
        paint: paint);
  }
}
