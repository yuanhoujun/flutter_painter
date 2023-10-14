import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_painter/src/extensions/paint_copy_extension.dart';

import '../object_drawable.dart';
import '../sized2ddrawable_v2.dart';
import 'shape_drawable.dart';

/// A drawable of an oval.
class CircleSelectionDrawable extends Sized2DDrawableV2
    implements ShapeDrawable {
  /// The paint to be used for the line drawable.
  @override
  Paint paint;

  Color color;
  double lineWidth;

  Offset? Function(Offset) converter;

  /// Creates a new [OvalDrawable] with the given [size] and [paint].
  CircleSelectionDrawable(
      {Paint? paint,
      required Size size,
      required Offset position,
      double rotationAngle = 0,
      double scale = 1,
      Set<ObjectDrawableAssist> assists = const <ObjectDrawableAssist>{},
      Map<ObjectDrawableAssist, Paint> assistPaints =
          const <ObjectDrawableAssist, Paint>{},
      bool locked = false,
      bool hidden = false,
      required this.converter,
      required this.color,
      required this.lineWidth})
      : paint = paint ?? ShapeDrawable.defaultPaint,
        super(
            size: size,
            position: position,
            rotationAngle: rotationAngle,
            scale: scale,
            assists: assists,
            assistPaints: assistPaints,
            locked: locked,
            hidden: hidden);

  /// Getter for padding of drawable.
  ///
  /// Add padding equal to the stroke width of the paint.
  @protected
  @override
  EdgeInsets get padding => EdgeInsets.all(paint.strokeWidth / 2);

  /// Draws the arrow on the provided [canvas] of size [size].
  @override
  void drawObject(Canvas canvas, Size size) {
    final newPosition = converter.call(position);
    if (newPosition == null) return;

    final drawingSize = this.size * scale;
    final newPaint = paint.copyWith(
        color: color, strokeWidth: lineWidth, style: PaintingStyle.stroke);

    canvas.drawOval(
        Rect.fromCenter(
            center: newPosition,
            width: drawingSize.width,
            height: drawingSize.height),
        newPaint);
  }

  /// Creates a copy of this but with the given fields replaced with the new values.
  @override
  CircleSelectionDrawable copyWith(
      {bool? hidden,
      Set<ObjectDrawableAssist>? assists,
      Offset? position,
      double? rotation,
      double? scale,
      Size? size,
      Paint? paint,
      bool? locked,
      Offset Function(Offset)? converter,
      Color? color,
      double? lineWidth}) {
    return CircleSelectionDrawable(
        hidden: hidden ?? this.hidden,
        assists: assists ?? this.assists,
        position: position ?? this.position,
        rotationAngle: rotation ?? rotationAngle,
        scale: scale ?? this.scale,
        size: size ?? this.size,
        locked: locked ?? this.locked,
        paint: paint ?? this.paint,
        converter: converter ?? this.converter,
        color: color ?? this.color,
        lineWidth: lineWidth ?? this.lineWidth);
  }

  /// Calculates the size of the rendered object.
  @override
  Size getSize({double minWidth = 0.0, double maxWidth = double.infinity}) {
    final size = super.getSize();
    return Size(size.width, size.height);
  }

  /// Compares two [OvalDrawable]s for equality.
  // @override
  // bool operator ==(Object other) {
  //   return other is OvalDrawable &&
  //       super == other &&
  //       other.paint == paint &&
  //       other.size == size;
  // }
  //
  // @override
  // int get hashCode => hashValues(
  //     hidden,
  //     locked,
  //     hashList(assists),
  //     hashList(assistPaints.entries),
  //     position,
  //     rotationAngle,
  //     scale,
  //     paint,
  //     size);
}
