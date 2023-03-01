import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_story_editor/src/constants.dart';
import 'package:whatsapp_story_editor/src/controller/editing_controller.dart';
import 'package:whatsapp_story_editor/src/controller/utils.dart';
import 'package:whatsapp_story_editor/src/widgets/circle_widget.dart';
import 'package:whatsapp_story_editor/whatsapp_story_editor.dart';

bottomBar({required BuildContext context}) => Container(
      height:
          MediaQuery.of(context).size.height * Constants.bottomBarHeightRatio,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            decoration: BoxDecoration(
                color: Constants.mattBlack,
                borderRadius: const BorderRadius.all(Radius.circular(20.0))),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/story.png',
                  package: 'whatsapp_story_editor',
                  color: Colors.white,
                  height: 16,
                ),
                const SizedBox(width: 5.0),
                Text(
                  "Status (2 included)",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9), fontSize: 13),
                ),
              ],
            ),
          ),
          const Spacer(),
          circleWidget(
              radius: 50,
              padding: const EdgeInsets.only(left: 5.0),
              child: Image.asset(
                "assets/icons/send.png",
                package: 'whatsapp_story_editor',
                color: Colors.white,
              ),
              onTap: () async {
                takeScreenshotAndReturnMemoryImage(getScreenshotKey)
                    .then((imageData) {
                  Navigator.pop(context);
                  Navigator.pop(
                      context,
                      WhatsappStoryEditorResult(
                          image: imageData,
                          caption: Get.find<EditingController>().caption));
                });
              }),
        ],
      ),
    );
