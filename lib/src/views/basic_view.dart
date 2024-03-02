import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_story_editor/src/constants.dart';
import 'package:whatsapp_story_editor/src/controller/editing_controller.dart';
import 'package:whatsapp_story_editor/src/widgets/bars/bottom_bar.dart';
import 'package:whatsapp_story_editor/src/widgets/bars/caption_bar.dart';
import 'package:whatsapp_story_editor/src/widgets/bars/deletion_bar.dart';
import 'package:whatsapp_story_editor/src/widgets/bars/editing_bar.dart';
import 'package:whatsapp_story_editor/src/widgets/filter_title.dart';
import '../widgets/vertical_gest_behavior.dart';

/// the basic skeleton of all editing bars
class BasicView extends StatelessWidget {
  final File file;
  const BasicView({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Obx(
              () => Get.find<EditingController>().isDeletionEligible
                  ? deletionBar(context: context)
                  : editingBar(file: file, context: context),
            ),
            const Spacer(),
            
            bottomBar(context: context),
          ],
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: MediaQuery.of(context).size.height *
              (Constants.captionBarHeightRatio +
                  Constants.bottomBarHeightRatio),
          child: verticalGestureBehavior(child: filterTitle()),
        ),
      ],
    );
  }
}
