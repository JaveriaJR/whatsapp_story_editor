import 'dart:io';
import 'package:whatsapp_story_editor/src/controller/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_story_editor/src/constants.dart';
import 'package:whatsapp_story_editor/src/controller/editing_controller.dart';
import 'package:whatsapp_story_editor/src/enums/editing_mode.dart';
import 'package:whatsapp_story_editor/src/views/crop_view.dart';
import 'package:whatsapp_story_editor/src/views/graphic_view.dart';
import 'package:whatsapp_story_editor/src/widgets/icon_widget.dart';
import 'package:whatsapp_story_editor/src/widgets/undo.dart';

/// The top editing bar containing crop, graphics (Stickers/Emojie), text and Painting
editingBar({required BuildContext context, required File file}) {
  return Container(
    height:
        MediaQuery.of(context).size.height * Constants.editingBarHeightRatio,
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      children: [
        buildIcon(
            onTap: () async {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: Icons.close),
        const Spacer(),
        Get.find<EditingController>().editableItemInfo.isNotEmpty
            ? undo(onTap: () {
                Get.find<EditingController>().editableItemInfo.removeLast();
              })
            : const SizedBox(),
        const SizedBox(width: 16.0),
        buildIcon(
            icon: Icons.crop,
            onTap: () {
              takeScreenshotAndReturnMemoryImage(getScreenshotKey)
                  .then((MemoryImage imageData) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CropView(image: file)));
              });
            }),
        const SizedBox(width: 16.0),
        buildIcon(
            icon: Icons.emoji_emotions_outlined,
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const GraphicView()))),
        const SizedBox(width: 16.0),
        buildIcon(
            icon: Icons.title,
            onTap: () => Get.find<EditingController>().editingModeSelected =
                EDITINGMODE.TEXT),
        const SizedBox(width: 16.0),
        buildIcon(
            icon: Icons.edit,
            onTap: () {
              Get.find<EditingController>().editingModeSelected =
                  EDITINGMODE.DRAWING;
            })
      ],
    ),
  );
}
