import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';

import '../drawables/shape/image_shape_drawable.dart';
import 'shape_factory.dart';

/// A [ImageShapeDrawable] factory.
class ImageFactory extends ShapeFactory<ImageShapeDrawable> {
  final double scale;
  ui.Image image;

  /// Creates an instance of [ImageFactory].
  ImageFactory({required this.scale, required this.image}) : super();

  /// Creates and returns a [ImageShapeDrawable] with length of 0 and the passed [position] and [paint].
  @override
  ImageShapeDrawable create(Offset position, [Paint? paint]) {
    return ImageShapeDrawable(scale: scale, position: position, image: image);
  }
}
