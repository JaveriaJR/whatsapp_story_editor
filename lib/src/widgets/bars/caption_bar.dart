import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_story_editor/src/constants.dart';
import 'package:whatsapp_story_editor/src/controller/editing_controller.dart';

//Allows to add caption on the image
Container captionBar({required BuildContext context}) {
  final EditingController controller = Get.find<EditingController>();
  return Container(
    height:
        MediaQuery.of(context).size.height * Constants.captionBarHeightRatio,
    padding: const EdgeInsets.symmetric(vertical: 16.0),
   
  );
}
