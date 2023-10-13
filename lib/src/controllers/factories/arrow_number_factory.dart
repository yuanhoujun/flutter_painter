import 'dart:ui';

import 'package:flutter_painter/flutter_painter.dart';
import 'package:flutter_painter/src/controllers/drawables/shape/arrow_number_drawable.dart';

/// A [ArrowNumberDrawable] factory.
class ArrowNumberFactory extends ShapeFactory<ArrowNumberDrawable> {
  /// The size of the arrow head to be used in created [ArrowDrawable]s.
  double? arrowHeadSize;

  String number;

  Offset? numberOffset;

  /// Creates an instance of [ArrowFactory] with the given [arrowHeadSize].
  ArrowNumberFactory({this.arrowHeadSize, required this.number, this.numberOffset}) : super();

  /// Creates and returns a [ArrowDrawable] with length of 0 and the passed [position] and [paint].
  @override
  ArrowNumberDrawable create(Offset position, [Paint? paint]) {
    return ArrowNumberDrawable(
        assists: {
          ObjectDrawableAssist.horizontal,
          ObjectDrawableAssist.vertical
        },
        length: 0,
        position: position,
        paint: paint,
        arrowHeadSize: arrowHeadSize,
        number: number,
        numberOffset: numberOffset);
  }
}
