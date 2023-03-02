import 'package:flutter/material.dart';
import 'package:whatsapp_story_editor/src/constants.dart';
import 'package:whatsapp_story_editor/src/widgets/icon_widget.dart';

///allows to delete graphic (Sticker/Emojie) by dragging to top left corner
deletionBar({required BuildContext context}) {
  return Container(
    height:
        MediaQuery.of(context).size.height * Constants.editingBarHeightRatio,
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      children: [
        buildIcon(onTap: () {}, icon: Icons.delete_outline_rounded),
        const Spacer(),
      ],
    ),
  );
}
