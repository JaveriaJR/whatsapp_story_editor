import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_story_editor/src/controller/editing_controller.dart';
import 'package:whatsapp_story_editor/src/enums/editing_mode.dart';

GestureDetector verticalGestureBehavior({required Widget child}) {
  final EditingController editingController = Get.find<EditingController>();
  late DragStartDetails? startVerticalDragDetails;
  late DragUpdateDetails? updateVerticalDragDetails;
  return GestureDetector(
      onVerticalDragStart: (dragDetails) {
        startVerticalDragDetails = dragDetails;
      },
      onVerticalDragUpdate: (dragDetails) {
        updateVerticalDragDetails = dragDetails;
      },
      onVerticalDragEnd: (endDetails) {
        double dy = updateVerticalDragDetails!.globalPosition.dy -
            startVerticalDragDetails!.globalPosition.dy;

        if (dy < 0) {
          editingController.editingModeSelected = EDITINGMODE.FILTERS;
        } else {
          editingController.editingModeSelected = EDITINGMODE.NONE;
        }
      },
      child: child);
}
