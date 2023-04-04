import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsv_color_pickers/hsv_color_pickers.dart';
import 'package:whatsapp_story_editor/src/controller/editing_controller.dart';
import 'package:whatsapp_story_editor/src/enums/editing_mode.dart';
import 'package:whatsapp_story_editor/src/views/basic_view.dart';
import 'package:whatsapp_story_editor/src/views/paint_view.dart';
import 'package:whatsapp_story_editor/src/views/text_view.dart';
import 'package:whatsapp_story_editor/src/widgets/bars/editing_bar.dart';
import 'package:whatsapp_story_editor/src/helper/background_image.dart';
import 'package:whatsapp_story_editor/src/widgets/bars/filters_bar.dart';
import 'package:whatsapp_story_editor/src/widgets/vertical_gest_behavior.dart';

class MainControllerView extends StatefulWidget {
  final File file;
  const MainControllerView({super.key, required this.file});

  @override
  State<MainControllerView> createState() => _MainControllerViewState();
}

class _MainControllerViewState extends State<MainControllerView> {
  final EditingController controller = Get.put(EditingController());
  HueController huecontroller = HueController(HSVColor.fromColor(Colors.green));

  final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());

  @override
  Widget build(BuildContext context) {
    //moved Material App from here to whatsappstoryeditor screen
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, (route) => route.isFirst);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.black,
            // body: Center(
            //   child: Column(children: [
            //     MatrixGestureDetector(
            //       onScaleStart: (d) {
            //         EditableItem.changeSvgColor(
            //             EditableItem.circleShapeSvg(), Colors.red);
            //         print("start: " + d.toString());
            //       },
            //       onScaleEnd: (d) {
            //         print("end: " + d.toString());
            //       },
            //       clipChild: false,
            //       onMatrixUpdate: (m, tm, sm, rm) {
            //         notifier.value = m;
            //       },
            //       child: GestureDetector(
            //         onTap: () {},
            //         child: Container(
            //           width: MediaQuery.of(context).size.width,
            //           height: MediaQuery.of(context).size.height - 100,
            //           alignment: Alignment.center,
            //           child: AnimatedBuilder(
            //             animation: notifier,
            //             builder: (ctx, childw) {
            //               return Transform(
            //                   transform: notifier.value,
            //                   child: Container(
            //                     height: 200,
            //                     width: 200,
            //                     //Circle:
            //                     child: SvgPicture.string(
            //                         EditableItem.squareShapeSvg()),
            //                     //Arrow:
            //                     //child: SvgPicture.string("""<svg height="24" width="24"> <path d="M2,12 L22,12 M16,6 L22,12 L16,18" stroke="black" stroke-width="1" fill="none" /></svg>""")
            //                     //Line:
            //                     //child: SvgPicture.string("""<svg height="2" width="100"> <line x1="0" y1="1" x2="100" y2="1" stroke="black" stroke-width="2" /></svg>"""),
            //                     //doubleArrow:
            //                     //child: SvgPicture.string("""<svg height="24" width="24"><path d="M2,12 L10,12 M14,12 L22,12 M16,6 L22,12 L16,18 M2,12 L10,12 M14,12 L2,12 M8,6 L2,12 L8,18" stroke="black" stroke-width="2" fill="none" /></svg>"""),
            //                     // rectangle:
            //                     // child: SvgPicture.string("""<svg height="100" width="200"><rect x="50" y="20" width="100" height="60" stroke="black" stroke-width="2" fill="none" /></svg>""")
            //                   ));
            //             },
            //           ),
            //         ),
            //       ),
            //     )
            //   ]),
            // ),
            body: Obx(
              () => controller.editingModeSelected == EDITINGMODE.FILTERS
                  ? Column(
                      children: [
                        editingBar(file: widget.file, context: context),
                        Expanded(
                            child: verticalGestureBehavior(
                                child: BackgroundImage(
                                    context: context, file: widget.file))),
                        filtersBar(file: widget.file)
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              controller.editingModeSelected == EDITINGMODE.NONE
                                  ? Center(
                                      child: BackgroundImage(
                                          context: context, file: widget.file))
                                  : BackgroundImage(
                                      context: context, file: widget.file),
                              controller.editingModeSelected ==
                                      EDITINGMODE.DRAWING
                                  ? const PaintView(shouldShowControls: true)
                                  : controller.editingModeSelected ==
                                          EDITINGMODE.TEXT
                                      ? const TextView()
                                      : BasicView(file: widget.file)
                            ],
                          ),
                        )
                      ],
                    ),
            )),
      ),
    );
  }
}
