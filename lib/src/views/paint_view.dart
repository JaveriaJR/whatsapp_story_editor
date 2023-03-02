import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:ui';
import 'package:perfect_freehand/perfect_freehand.dart';
import 'package:whatsapp_story_editor/src/controller/editing_controller.dart';
import 'package:whatsapp_story_editor/src/enums/editing_mode.dart';
import 'package:whatsapp_story_editor/src/models/paint_info.dart';
import 'package:whatsapp_story_editor/src/models/stroke_options_model.dart';
import 'package:whatsapp_story_editor/src/widgets/circle_widget.dart';
import 'package:whatsapp_story_editor/src/helper/sketcher.dart';
import '../models/stroke_model.dart';
import '../widgets/color_picker_slider.dart';
import '../widgets/done_btn.dart';
import '../widgets/undo.dart';

List<Stroke> lines = <Stroke>[];
Stroke? line;
var drawingUndoController = StreamController<bool>.broadcast();

class PaintView extends StatefulWidget {
  final bool shouldShowControls;
  const PaintView({Key? key, required this.shouldShowControls})
      : super(key: key);

  @override
  State<PaintView> createState() => _PaintViewState();
}

class _PaintViewState extends State<PaintView> {
  EditingController controller = Get.find<EditingController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: widget.shouldShowControls
            ? Stack(
                children: [
                  Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(),
                      margin:
                          const EdgeInsets.only(bottom: 70, top: 70, right: 30),
                      child: Painter(
                        shouldShowControls: widget.shouldShowControls,
                      )),
                  Column(
                    children: [
                      _drawTopBar(),
                      const Spacer(),
                      _drawBottomBar(),
                    ],
                  ),
                  const Positioned(
                      top: 80, right: 16, child: ColorPickerSlider()),
                ],
              )
            : Painter(shouldShowControls: widget.shouldShowControls),
      ),
    );
  }

  _drawTopBar() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Row(
          children: [
            doneBtn(onTap: () {
              controller.editingModeSelected = EDITINGMODE.NONE;
            }),
            const Spacer(),
            undo(onTap: () {
              setState(() {
                lines.isNotEmpty ? lines.removeLast() : lines = [];
                line = null;
                drawingUndoController.add(true);
              });
            }),
            const SizedBox(width: 14),
            Obx(() => circleWidget(
                radius: 45,
                bgColor: controller.hueController.value.toColor(),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                )))
          ],
        ),
      );

  _drawBottomBar() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        for (int i = 1; i <= 4; i++)
          Obx(() => Stack(
                alignment: Alignment.center,
                children: [
                  circleWidget(
                    radius: controller.paintBrush == i ? 35 : 30,
                    bgColor: Colors.black,
                    onTap: () {
                      controller.paintBrush = i;
                    },
                    child: Image.asset(
                      'assets/icons/draw$i.png',
                      package: 'whatsapp_story_editor',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  circleWidget(
                    radius: controller.paintBrush == i ? 50 : 40,
                    bgColor: controller.paintBrush == i
                        ? Colors.white.withOpacity(0.2)
                        : Colors.transparent,
                    onTap: () {
                      controller.paintBrush = i;
                    },
                  )
                ],
              ))
      ]));
}

class Painter extends StatefulWidget {
  final bool shouldShowControls;
  const Painter({Key? key, required this.shouldShowControls}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PainterState createState() => _PainterState();
}

class _PainterState extends State<Painter> {
  final EditingController controller = Get.find<EditingController>();

  StrokeOptions options = StrokeOptions();
  StreamController<Stroke> currentLineStreamController =
      StreamController<Stroke>.broadcast();
  StreamController<List<Stroke>> linesStreamController =
      StreamController<List<Stroke>>.broadcast();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: widget.shouldShowControls
            ? Stack(
                children: [
                  buildAllPaths(context),
                  buildCurrentPath(context),
                ],
              )
            : buildAllPaths(context));
  }

  @override
  void dispose() {
    linesStreamController.close();
    currentLineStreamController.close();
    super.dispose();
  }

  void onPointerDown(PointerDownEvent details) {
    options = StrokeOptions(
      simulatePressure: details.kind != PointerDeviceKind.stylus,
    );

    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(details.position);
    late final Point point;
    if (details.kind == PointerDeviceKind.stylus) {
      point = Point(
        offset.dx,
        offset.dy,
        (details.pressure - details.pressureMin) /
            (details.pressureMax - details.pressureMin),
      );
    } else {
      point = Point(offset.dx, offset.dy);
    }
    final points = [point];
    line = Stroke(points, controller.hueController.value.toColor(), options);
    currentLineStreamController.add(line!);
  }

  void onPointerMove(PointerMoveEvent details) {
    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(details.position);
    late final Point point;
    if (details.kind == PointerDeviceKind.stylus) {
      point = Point(
        offset.dx,
        offset.dy,
        (details.pressure - details.pressureMin) /
            (details.pressureMax - details.pressureMin),
      );
    } else {
      point = Point(offset.dx, offset.dy);
    }
    final points = [...line!.points, point];
    line = Stroke(points, controller.hueController.value.toColor(), options);
    currentLineStreamController.add(line!);
  }

  void onPointerUp(PointerUpEvent details) {
    lines = List.from(lines)..add(line!);
    linesStreamController.add(lines);
  }

  Widget buildCurrentPath(BuildContext context) {
    return Listener(
      onPointerDown: onPointerDown,
      onPointerMove: onPointerMove,
      onPointerUp: onPointerUp,
      child: RepaintBoundary(
        child: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: StreamBuilder<bool>(
                stream: drawingUndoController.stream,
                builder: (context, snap) {
                  return StreamBuilder<Stroke>(
                      stream: currentLineStreamController.stream,
                      builder: (context, snapshot) {
                        return CustomPaint(
                          painter: Sketcher(
                              editingmode: EDITINGMODE.DRAWING,
                              paintInfo: PaintInfo(
                                lines: line == null ? [] : [line!],
                                options: options
                                  ..size = controller.paintBrush.toDouble() * 8,
                              )),
                        );
                      });
                })),
      ),
    );
  }

  Widget buildAllPaths(BuildContext context) {
    return widget.shouldShowControls
        ? RepaintBoundary(
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<bool>(
                    stream: drawingUndoController.stream,
                    builder: (context, snap) {
                      return StreamBuilder<List<Stroke>>(
                        stream: linesStreamController.stream,
                        builder: (context, snapshot) {
                          return CustomPaint(
                            painter: Sketcher(
                                editingmode: EDITINGMODE.DRAWING,
                                paintInfo:
                                    PaintInfo(lines: lines, options: options)),
                          );
                        },
                      );
                    })),
          )
        : CustomPaint(
            painter: Sketcher(
                editingmode: EDITINGMODE.DRAWING,
                paintInfo: PaintInfo(lines: lines, options: options)));
  }
}
