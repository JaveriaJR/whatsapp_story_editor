// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:whatsapp_story_editor/src/helper/matrix_gesture_detector.dart';
// import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class TransformableWidget extends StatefulWidget {
  final Widget child;
  final Matrix4 transform;
  final Function? onTapDown;
  final Function(ScaleUpdateDetails details)? onScaleStart;
  final Function(ScaleEndDetails details)? onScaleEnd;
  final Function(Matrix4 transformedDetails)? onDetailsUpdate;

  const TransformableWidget(
      {super.key,
      required this.child,
      this.onTapDown,
      this.onDetailsUpdate,
      this.onScaleStart,
      this.onScaleEnd,
      required this.transform});

  @override
  State<TransformableWidget> createState() => _TransformableWidgetState();
}

class _TransformableWidgetState extends State<TransformableWidget> {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());

    return MatrixGestureDetector(
      onScaleStart: (d) {
        if (widget.onScaleStart != null) {
          widget.onScaleStart!(d);
        }
      },
      onScaleEnd: (d) {
        if (widget.onScaleEnd != null) {
          widget.onScaleEnd!(d);
        }
      },
      clipChild: false,
      onMatrixUpdate: (m, tm, sm, rm) {
        notifier.value = m;
        if (widget.onDetailsUpdate != null) {
          widget.onDetailsUpdate!(notifier.value);
        }
      },
      child: GestureDetector(
        onTap: () {
          if (widget.onTapDown != null) {
            widget.onTapDown!();
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: AnimatedBuilder(
            animation: notifier,
            builder: (ctx, childw) {
              return Transform(
                  transform: widget.transform, child: widget.child);
            },
          ),
        ),
      ),
    );
  }
}
