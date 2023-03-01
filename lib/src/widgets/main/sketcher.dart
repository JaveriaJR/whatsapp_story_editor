import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect_freehand/perfect_freehand.dart';
import 'package:whatsapp_story_editor/src/controller/editing_controller.dart';
import 'package:whatsapp_story_editor/src/enums/editing_mode.dart';
import 'package:whatsapp_story_editor/src/models/graphic_info.dart';
import 'package:whatsapp_story_editor/src/models/paint_info.dart';
import 'package:whatsapp_story_editor/src/models/text_info.dart';

class Sketcher extends CustomPainter {
  final EDITINGMODE editingmode;
  final PaintInfo? paintInfo;

  Sketcher({
    required this.editingmode,
    this.paintInfo,
  }) {
    assert(
        (paintInfo != null && editingmode == EDITINGMODE.DRAWING) ||
            (paintInfo == null && editingmode == EDITINGMODE.TEXT),
        "PaintInfo can't be null with Drawing as Drawing Mode, OR PaintInfo not valid with Text as Editing Mode");
  }

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    if (editingmode == EDITINGMODE.DRAWING) {
      Paint paint = Paint()..color = paintInfo!.options.color;
      for (int i = 0; i < paintInfo!.lines.length; ++i) {
        final outlinePoints = getStroke(
          paintInfo!.lines[i].points,
          size: paintInfo!.lines[i].options.size,
          thinning: paintInfo!.lines[i].options.thinning,
          smoothing: paintInfo!.lines[i].options.smoothing,
          streamline: paintInfo!.lines[i].options.streamline,
          taperStart: paintInfo!.lines[i].options.taperStart,
          capStart: paintInfo!.lines[i].options.capStart,
          taperEnd: paintInfo!.lines[i].options.taperEnd,
          capEnd: paintInfo!.lines[i].options.capEnd,
          simulatePressure: paintInfo!.lines[i].options.simulatePressure,
          isComplete: paintInfo!.lines[i].options.isComplete,
        );
        paint.color = paintInfo!.lines[i].color;
        paint
          ..strokeWidth = 5
          // ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 5)
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round
          ..strokeMiterLimit = 5
          ..filterQuality = FilterQuality.high
          ..style = PaintingStyle.fill;

        final path = Path();
        if (outlinePoints.isEmpty) {
          return;
        } else if (outlinePoints.length < 2) {
          // If the path only has one line, draw a dot.
          path.addOval(Rect.fromCircle(
              center: Offset(outlinePoints[0].x, outlinePoints[0].y),
              radius: 1));
        } else {
          // Otherwise, draw a line that connects each point with a curve.
          path.moveTo(outlinePoints[0].x, outlinePoints[0].y);
          for (int i = 1; i < outlinePoints.length - 1; ++i) {
            final p0 = outlinePoints[i];
            final p1 = outlinePoints[i + 1];
            path.quadraticBezierTo(
                p0.x, p0.y, (p0.x + p1.x) / 2, (p0.y + p1.y) / 2);
          }
        }
        canvas.drawPath(path, paint);
      }
    } else if (editingmode == EDITINGMODE.TEXT) {
      // List<TextInfo> textOnImageList =
      //     Get.find<EditingController>().textOnImage;
      List<EditableItem> textOnImageList =
          Get.find<EditingController>().getEditableTextType();
      for (int i = 0; i < textOnImageList.length; i++) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: textOnImageList.elementAt(i).text!.text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: textOnImageList.elementAt(i).text!.color,
            ),
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          maxLines: 10,
        )..layout(minWidth: 0.0, maxWidth: size.width);
        double y = size.height / 2; //+ (i * 50);
        double x = 0;
        textPainter.paint(
            canvas, textOnImageList.elementAt(i).text!.offset ?? Offset(x, y));
      }
    } else {
      return;
    }
  }

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return true;
  }
}
