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
    child: Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      decoration: BoxDecoration(
          color: Constants.mattBlack,
          borderRadius: const BorderRadius.all(Radius.circular(24.0))),
      child: Row(children: [
        const Icon(Icons.add_photo_alternate_rounded, color: Colors.white),
        const SizedBox(width: 10.0),
        Obx(() {
          return Expanded(
            child: TextField(
              controller: TextEditingController(text: controller.caption),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400),
              onSubmitted: (value) {
                controller.caption = value;
              },
              decoration: const InputDecoration.collapsed(
                hintText: 'Add a caption...',
                hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
          );
        })
      ]),
    ),
  );
}
