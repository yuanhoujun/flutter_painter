import 'dart:math';

import 'package:flutter/material.dart';

import '../object_drawable.dart';
import 'shape_drawable.dart';
import '../sized1ddrawable.dart';
import '../../../extensions/paint_copy_extension.dart';

/// A drawable of a simple arrow shape.
class ArrowNumberDrawable extends Sized1DDrawable implements ShapeDrawable {
  /// The paint to be used for the line drawable.
  @override
  Paint paint;

  /// The size of the arrow head.
  ///
  /// If null, the arrow head size will be 3 times the [paint] strokeWidth.
  double? arrowHeadSize;

  /// 数字标识的半径
  double numberRadius;

  /// 数字表示的圆框颜色
  Color numberBackgroundColor;

  /// 数字标识的文字颜色
  Color numberTextColor;

  /// 数字标识的文字大小
  double numberTextSize;

  String number;

  /// 距离线条末端的偏移量
  Offset numberOffset;

  /// Creates a new [ArrowDrawable] with the given [length], [paint] and [arrowHeadSize].
  ArrowNumberDrawable(
      {Paint? paint,
      this.arrowHeadSize,
      required double length,
      required Offset position,
      double rotationAngle = 0,
      double scale = 1,
      Set<ObjectDrawableAssist> assists = const <ObjectDrawableAssist>{},
      Map<ObjectDrawableAssist, Paint> assistPaints =
          const <ObjectDrawableAssist, Paint>{},
      bool locked = false,
      bool hidden = false,
      this.numberRadius = 10,
      this.numberBackgroundColor = Colors.blue,
      this.numberTextColor = Colors.white,
      this.numberTextSize = 14.0,
      required this.number,
      Offset? numberOffset})
      : paint = paint ?? ShapeDrawable.defaultPaint,
        numberOffset = numberOffset ?? const Offset(-10, 0),
        super(
            length: length,
            position: position,
            rotationAngle: rotationAngle,
            scale: scale,
            assists: assists,
            assistPaints: assistPaints,
            locked: locked,
            hidden: hidden);

  /// The actual arrow head size used in drawing.
  double get _arrowHeadSize => arrowHeadSize ?? paint.strokeWidth * 3;

  /// Getter for padding of drawable.
  ///
  /// Add padding equal to the stroke width of the line and the size of the arrow head.
  @protected
  @override
  EdgeInsets get padding => EdgeInsets.symmetric(
      horizontal: paint.strokeWidth / 2,
      vertical: paint.strokeWidth / 2 + (_arrowHeadSize / 2));

  /// Draws the arrow on the provided [canvas] of size [size].
  @override
  void drawObject(Canvas canvas, Size size) {
    final arrowHeadSize = _arrowHeadSize;

    final dx = length / 2 * scale - arrowHeadSize;

    final start = position.translate(-length / 2 * scale, 0);
    final end = position.translate(dx, 0);

    if ((end - start).dx > 0) canvas.drawLine(start, end, paint);

    final pathDx = dx /*.clamp(-arrowHeadSize/2, double.infinity)*/;

    final path = Path();
    path.moveTo(position.dx + pathDx + arrowHeadSize, position.dy);
    path.lineTo(position.dx + pathDx, position.dy - (arrowHeadSize / 2));
    path.lineTo(position.dx + pathDx, position.dy + (arrowHeadSize / 2));
    path.lineTo(position.dx + pathDx + arrowHeadSize, position.dy);

    final headPaint = paint.copyWith(
      style: PaintingStyle.fill,
    );

    canvas.drawPath(path, headPaint);

    final circlePaint =
        paint.copyWith(style: PaintingStyle.fill, color: numberBackgroundColor);

    final numberCenter = end.translate(numberOffset.dx, numberOffset.dy);
    canvas.drawOval(
        Rect.fromCenter(
            center: numberCenter,
            width: numberRadius * 2,
            height: numberRadius * 2),
        circlePaint);

    // 绘制箭头序号
    final textPainter = TextPainter(
      text: TextSpan(
        text: number,
        style: TextStyle(
          color: numberTextColor,
          fontSize: numberTextSize,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final textOffset = Offset(numberCenter.dx - textPainter.width / 2,
        numberCenter.dy - textPainter.height / 2);

    canvas.translate(numberCenter.dx, numberCenter.dy);
    canvas.rotate(pi / 2);
    canvas.translate(-numberCenter.dx, -numberCenter.dy);
    textPainter.paint(canvas, textOffset);
  }

  /// Creates a copy of this but with the given fields replaced with the new values.
  @override
  ArrowNumberDrawable copyWith(
      {bool? hidden,
      Set<ObjectDrawableAssist>? assists,
      Offset? position,
      double? rotation,
      double? scale,
      double? length,
      Paint? paint,
      bool? locked,
      double? arrowHeadSize,
      String? number,
      Offset? numberOffset}) {
    return ArrowNumberDrawable(
        hidden: hidden ?? this.hidden,
        assists: assists ?? this.assists,
        position: position ?? this.position,
        rotationAngle: rotation ?? rotationAngle,
        scale: scale ?? this.scale,
        length: length ?? this.length,
        paint: paint ?? this.paint,
        locked: locked ?? this.locked,
        arrowHeadSize: arrowHeadSize ?? this.arrowHeadSize,
        number: number ?? this.number,
        numberOffset: numberOffset ?? this.numberOffset);
  }

  /// Calculates the size of the rendered object.
  @override
  Size getSize({double minWidth = 0.0, double maxWidth = double.infinity}) {
    final size = super.getSize();
    return Size(size.width, size.height);
  }

  /// Compares two [ArrowDrawable]s for equality.
  // @override
  // bool operator ==(Object other) {
  //   return other is ArrowDrawable &&
  //       super == other &&
  //       other.paint == paint &&
  //       other.length == length &&
  //       other.arrowHeadSize == arrowHeadSize;
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
  //     length,
  //     arrowHeadSize);
}
