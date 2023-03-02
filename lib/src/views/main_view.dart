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
